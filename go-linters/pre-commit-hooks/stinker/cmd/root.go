package cmd

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

var (
	cfgFile               string
	isDebugLoggingEnabled bool
)

var rootCmd = &cobra.Command{
	Use:   "stinker",
	Short: "stinker makes a stink if your commit fails any of the pre-commit checks!",
	Run:   runRootCmd,
}

func Execute() {
	err := rootCmd.Execute()
	if err != nil {
		os.Exit(1)
	}
}

func init() {
	cobra.OnInitialize(initConfig)

	rootCmd.PersistentFlags().
		StringVar(
			&cfgFile,
			"config",
			"",
			"config file (default is $HOME/.stinker.yaml)",
		)
	rootCmd.PersistentFlags().
		BoolVar(
			&isDebugLoggingEnabled,
			"debug",
			false,
			"enable debug logging",
		)
}

func initConfig() {
	if cfgFile != "" {
		viper.SetConfigFile(cfgFile)
	} else {
		home, err := os.UserHomeDir()
		cobra.CheckErr(err)

		viper.AddConfigPath(home)
		viper.SetConfigType("yaml")
		viper.SetConfigName(".stinker")
	}

	viper.AutomaticEnv()

	if err := viper.ReadInConfig(); err == nil {
		fmt.Fprintln(os.Stderr, "Using config file:", viper.ConfigFileUsed())
	}
}

func runRootCmd(_ *cobra.Command, _ []string) {
	fmt.Println("use stinker --help to see available commands")
}
