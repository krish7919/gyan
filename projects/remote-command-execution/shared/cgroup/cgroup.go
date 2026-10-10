package cgroup

type CGroupManager interface {
	// CreateCGroup creates a new cgroup with the specified name and resource limits.
	CreateCGroup(name string, cpuLimit int, memoryLimit int) error

	// DeleteCGroup deletes the cgroup with the specified name.
	DeleteCGroup(name string) error

	// AddProcessToCGroup adds a process with the specified PID to the cgroup with the specified name.
	AddProcessToCGroup(name string, pid int) error
}

const (
	// CGroupRoot is the root directory for cgroups.
	CGroupRoot = "/sys/fs/cgroup"
	// CGroupCPUPath is the path for CPU cgroups.
	CGroupCPUPath = CGroupRoot + "/cpu"
	// CGroupMemoryPath is the path for memory cgroups.
	CGroupMemoryPath = CGroupRoot + "/memory"

	// CGroupEventsPath is the path for cgroup events.
	CGroupEventsPath = CGroupRoot + "/events"
	// CGroupProcsPath is the path for cgroup processes.
	CGroupProcsPath = CGroupRoot + "/cgroup.procs"
)

type cGroupManager struct {
	// You can add fields here if needed, such as a logger or configuration.
}

func NewCGroupManager() CGroupManager {
	return &cGroupManager{}
}

func (m *cGroupManager) CreateCGroup(name string, cpuLimit int, memoryLimit int) error {
	// Implement the logic to create a cgroup with the specified name and resource limits.
	return nil
}

func (m *cGroupManager) DeleteCGroup(name string) error {
	// Implement the logic to delete the cgroup with the specified name.
	return nil
}

func (m *cGroupManager) AddProcessToCGroup(name string, pid int) error {
	// Implement the logic to add a process with the specified PID to the cgroup with the specified name.
	return nil
}
