package cmd

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
	/*
	"go/ast"
	"go/parser"
	"go/token"
 	"go/build"
 	"path/filepath"
*/
)

const (
	golangTestNamesCmdName = "golang-test-names-validate"
)

// golangTestNamesCmd represents the golangTestNames command.
var golangTestNamesCmd = &cobra.Command{
	Use:   golangTestNamesCmdName,
	Short: "validates that the Golang test names contain no spaces, and are snake-cased",
	Long: `Golang test failures always print the test name that failed with underscores in
place of spaces in the test names. When debugging repeatedly failing tests on
projects, it makes it easier to run a single test by copying the test name from
the failure message. However, this becomes cumbersome as we have to replace all
the spaces with underscores manually, or enclose the failing test name within
quotes. It becomes worse when we do not know which file contains the failed
test, and we need to search for the test by:

1. copying the test name
2. replacing underscores with space
3. using the search function in the console/IDE to find the location of the test

To avoid all this, we should name all tests without spaces, and use underscores
to separate words. This way, we can easily copy the test name from the failure
message and run/search for the test directly.

This command reports such invalid, space-separated test names in Golang projects,
and optionally fixes them.`,
	Run: runGolangTestNamesCmd,
}

func init() {
	rootCmd.AddCommand(golangTestNamesCmd)

	golangTestNamesCmd.Flags().String(
		"go-test-output",
		"",
		"filename that contains output of `go test -json ./...` command",
	)
	_ = golangTestNamesCmd.MarkFlagRequired("go-test-output")

	golangTestNamesCmd.Flags().Bool(
		"auto-fix",
		false,
		"auto-fix invalid test names",
	)
}

func runGolangTestNamesCmd(cmd *cobra.Command, args []string) {
	initLogger()

	goTestOutput := cmd.Flag("go-test-output").Value.String()
	isAutoFix := cmd.Flag("auto-fix").Value.String()

	// TODO: workflow:
	// 1. https://golangci-lint.run/contributing/new-linters/ and https://disaev.me/p/writing-useful-go-analysis-linter/
	// 2. Collect the output of `go test -json ./...` command
	// 3. Parse it to get all the test names
	// 4. Validate the test names
	// 5. If invalid, fix them using string substitution


	// for _, modifiedFileName := range args {
	// 	// Slurp the entire file into memory.
	// 	sourceCode, err := os.ReadFile(modifiedFileName)
	// 	if err != nil {
	// 		fmt.Printf("cannot read source file '%s': '%s'", modifiedFileName, err.Error())
	// 		os.Exit(1)
	// 	}
	// 	processFile(modifiedFileName, sourceCode)

	// 	// errmsg := fmt.Sprintf("commit message does not match the pattern: '%s'", pattern)
	// 	// fmt.Printf("\n%s: %s\n", commitMsgCmdName, errmsg)
	// 	// os.Exit(1)
	// }

	os.Exit(0)
}

func listTestNamesWithSpaces(dir string) (err error) {
	// fmt.Printf("Processing dir: %s\n", dir)
	fset := token.NewFileSet()
	// var files []*ast.File

	// pkg, err := build.ImportDir(dir, 0)
	// if err != nil {
	// 	return
	// }

	// fmt.Printf("Package: %s\n", pkg.Name)

	// for _, file := range append(pkg.TestGoFiles, pkg.XTestGoFiles...) {
	// fmt.Printf("Processing file: %s\n", file)

	// astfile, err := parser.ParseFile(fset, filepath.Join(dir, file), nil, 0)
	astfile, err := parser.ParseFile(fset, "", testFile, 0)
	if err != nil {
		return err
	}
	// files = append(files, astfile)

	// var positions []token.Position
	// conf := types.Config{Importer: importer.Default()}
	// info := &types.Info{Types: map[ast.Expr]types.TypeAndValue{}}
	// if _, err := conf.Check(pkg.ImportPath, fset, files, info); err != nil {
	// 	return nil, err
	// }

	// for expr, typeVal := range info.Types {
	// 	if _, ok := expr.(*ast.CompositeLit); ok {
	// 		if typeVal.Type.String() == "crypto/tls.Config" {
	// 			positions = append(positions, fset.Position(expr.Pos()))
	// 		}
	// 	}
	// }
	// }

	// Get all funcstions from the files.
	funcs := []*ast.FuncDecl{}
	for _, astFile := range files {
		for _, declarations := range astFile.Decls {
			if fn, isFn := declarations.(*ast.FuncDecl); isFn {
				funcs = append(funcs, fn)
			}
		}
	}

	for _, fn := range funcs {
		if fn.Name.Name != "TestService_BreakOut" {
			continue
		}
		fmt.Printf("!!!!Function name: %s\n", fn.Name.Name)
		fmt.Printf("Function body: %v\n", fn.Body.List)
		for _, s := range fn.Body.List {
			fmt.Printf("adfalks %v\n", s)
		}
	}

	// return positions, nil
	return
}

var testFile = `
func TestIntMinTableDriven(t *testing.T) {
    var tests = []struct {
        a, b int
        want int
    }{
        {0, 1, 0},
        {1, 0, 0},
        {2, -2, -2},
        {0, -1, -1},
        {-1, 0, -1},
    }
    for _, tt := range tests {
        testname := fmt.Sprintf("%d,%d", tt.a, tt.b)
        t.Run(testname, func(t *testing.T) {
            ans := IntMin(tt.a, tt.b)
            if ans != tt.want {
                t.Errorf("got %d, want %d", ans, tt.want)
            }
        })
    }
}`
*/
