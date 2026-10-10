package cmd

import (
	"fmt"
	"go/ast"
	"go/parser"
	"go/token"

	"github.com/spf13/cobra"
)

// import (
// 	"fmt"
// 	"go/ast"
// 	"go/build"
// 	"go/parser"
// 	"go/token"
// 	"path/filepath"

// 	"github.com/spf13/cobra"
// )

// findInconsistentTestNamesCmd represents the findInconsistentTestNames command
var findInconsistentTestNamesCmd = &cobra.Command{
	Use:   "find-inconsistent-test-names",
	Short: "replaces spaces in test names with underscores",
	RunE: func(cmd *cobra.Command, args []string) (err error) {
		err = findInconsistentTestNamesHandler(cmd, args)
		return
	},
}

func init() {
	rootCmd.AddCommand(findInconsistentTestNamesCmd)
	// TODO findInconsistentTestNamesCmd.PersistentFlags().
	// 	String("directory", "", "path to the directory where the tool should look for Golang test files")
	// TODO findInconsistentTestNamesCmd.MarkPersistentFlagRequired("directory")
	// TODO findInconsistentTestNamesCmd.PersistentFlags().String("fix", "", "autofix the files")
}

func findInconsistentTestNamesHandler(cmd *cobra.Command, _ []string) (err error) {
	dirPath := cmd.Flag("directory").Value.String()

	err = listTestNamesWithSpaces(dirPath)
	if err != nil {
		panic(err)
	}

	return
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
