package cmd

import (
	"fmt"
	"os"
	"regexp"

	"github.com/spf13/cobra"
)

const (
	commitMsgCmdName = "commit-msg-validate"
)

var commitMsgCmd = &cobra.Command{
	Use:   commitMsgCmdName,
	Short: "validates that the commit message meets the required format",
	Run:   runCommitMsgCmd,
}

func init() {
	rootCmd.AddCommand(commitMsgCmd)

	commitMsgCmd.Flags().StringP(
		"regexp",
		"r",
		"",
		"pattern to match the commit message against",
	)
	_ = commitMsgCmd.MarkFlagRequired("regexp")
}

func runCommitMsgCmd(cmd *cobra.Command, args []string) {
	initLogger()

	pattern := cmd.Flag("regexp").Value.String()

	regexpPattern, err := regexp.Compile(pattern)
	if err != nil {
		fmt.Printf("invalid regexp pattern: '%s': '%s'", pattern, err.Error())
		os.Exit(1)
	}

	// Commenting the following code as its easier to test without this check.
	//
	// // pre-commit passes a file name ".git/COMMIT_EDITMSG" as an argument, which
	// // contains the commit message.
	// if args[0] != ".git/COMMIT_EDITMSG" {
	// 	fmt.Printf("invalid filename, expected: '.git/COMMIT_EDITMSG', got: '%s'", args[0])
	// 	os.Exit(1)
	// }

	// Fetch the commit message from the filename
	// passed as argument.
	commitMsg, err := os.ReadFile(args[0])
	if err != nil {
		fmt.Printf("cannot read commit message: '%s'", err.Error())
		os.Exit(1)
	}

	if regexpPattern.MatchString(string(commitMsg)) { // nolint: mirror
		os.Exit(0)
	}

	errmsg := fmt.Sprintf("commit message does not match the pattern: '%s'", pattern)
	fmt.Printf("\n%s: %s\n", commitMsgCmdName, errmsg)
	os.Exit(1)
}
