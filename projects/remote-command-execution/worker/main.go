package main

import (
	"context"
	"fmt"
	"log"
	"os"

	"github.com/urfave/cli/v3"
)

func main() {
	// TODO sanity check: exit if not Linunx (if cgroups are not available).

	cmd := &cli.Command{
		Name:  "worker",
		Usage: "Run the worker process that executes tasks in a cgroup",
		Flags: []cli.Flag{
			&cli.StringFlag{
				Name:  "lang",
				Value: "english",
				Usage: "language for the greeting",
			},
		},
		Action: func(ctx context.Context, cmd *cli.Command) error {
			name := "Nefertiti"
			if cmd.NArg() > 0 {
				name = cmd.Args().Get(0)
			}
			if cmd.String("lang") == "spanish" {
				fmt.Println("Hola", name)
			} else {
				fmt.Println("Hello", name)
			}

			return nil
		},
	}

	if err := cmd.Run(context.Background(), os.Args); err != nil {
		log.Fatal(err)
	}
}
