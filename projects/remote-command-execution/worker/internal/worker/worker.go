package worker

import (
	"context"
	"fmt"
	"os"
)

type Worker interface{}

type worker struct{}

func NewWorker(
	ctx context.Context,
	logFileHandler *os.File,
	signalHandler *os.File,
	cgroupPath string,
	command string,
	args []string,
	cpuLimit string,
	memoryLimit string,
) Worker {
	pid := os.Getpid()
	fmt.Println("Current PID:", pid)
	return &worker{}
}

func addCurrentProcessToCGroup(cgroupPath string) error {
	filePath := fmt.Sprintf("%s/cgroup.procs", cgroupPath)
	pid := os.Getpid()
	pidStr := fmt.Sprintf("%d", pid)

	// Open the cgroup.procs file for writing.
	procFileHandler, err := os.OpenFile(filePath, os.O_WRONLY|os.O_APPEND|os.O_CREATE, 0644)
	if err != nil {
		return fmt.Errorf("failed to open cgroup.procs: %w", err)
	}
	defer procFileHandler.Close()

	// Write the PID to the cgroup.procs file
	if _, err := procFileHandler.WriteString(pidStr + "\n"); err != nil {
		return fmt.Errorf("failed to write PID to cgroup.procs: %w", err)
	}

	return nil
}
func runShim() {
	fmt.Printf("Running in namespaces as PID %d\n", os.Getpid())

	// 1. Cgroup setup (Cgroup v2)
	cgPath := "/sys/fs/cgroup/my-container"
	os.MkdirAll(cgPath, 0755)
	
	// Write our PID to the cgroup.procs file to move ourselves into the cgroup
	pid := []byte(fmt.Sprintf("%d", os.Getpid()))
	os.WriteFile(filepath.Join(cgPath, "cgroup.procs"), pid, 0644)
	
	// Set a 512MB memory limit
	os.WriteFile(filepath.Join(cgPath, "memory.max"), []byte("536870912"), 0644)

	// 2. Mount /proc so that 'ps' and 'top' work correctly in the PID namespace
	syscall.Mount("proc", "/proc", "proc", 0, "")

	// 3. Final Exec - replace this shim with the user command
	userCmd := os.Args[2]
	userArgs := os.Args[2:]
	if err := syscall.Exec(userCmd, userArgs, os.Environ()); err != nil {
		fmt.Printf("Exec error: %v\n", err)
	}
}
package main

import (
	"os"
	"os/exec"
	"syscall"
)

func main() {
	// 1. Open the file on the HOST root filesystem
	// This happens before any namespaces are created.
	logFile, err := os.OpenFile("/var/log/my-job.log", os.O_CREATE|os.O_WRONLY|os.O_APPEND, 0666)
	if err != nil {
		panic(err)
	}
	defer logFile.Close()

	// 2. Prepare the command
	// We point to a binary that will be executed inside the namespace
	cmd := exec.Command("/bin/sh", "-c", "echo 'Writing from inside the namespace!'")

	// 3. Assign the host file to the child's Stdout
	cmd.Stdout = logFile
	cmd.Stderr = logFile

	// 4. Define Namespace Isolation
	cmd.SysProcAttr = &syscall.SysProcAttr{
		Cloneflags: syscall.CLONE_NEWPID | // Isolated PIDs
			syscall.CLONE_NEWNS | // Isolated Mounts
			syscall.CLONE_NEWNET | // Isolated Network
			syscall.CLONE_NEWUTS, // Isolated Hostname
	}

	// 5. Run the command
	if err := cmd.Run(); err != nil {
		panic(err)
	}
}