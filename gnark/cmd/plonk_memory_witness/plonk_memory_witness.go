package main

import (
	"fmt"
	"os"
	"strings"

	"github.com/consensys/gnark-crypto/ecc"
	"github.com/spf13/cobra"
	"github.com/zkCollective/zk-Harness/gnark/circuits"
	"github.com/zkCollective/zk-Harness/gnark/parser"
)

var plonkMemoryWitnessCmd = &cobra.Command{
	Use:   "plonkMemoryWitness",
	Short: "runs memory benchmarks using Plonk proof system",
	Run:   runPlonkMemoryWitness,
}

var cfg = parser.NewConfig()

func runPlonkMemoryWitness(cmd *cobra.Command, args []string) {

	if err := parser.ParseFlagsMemory(cfg); err != nil {
		fmt.Println("error: ", err.Error())
		cmd.Help()
		os.Exit(-1)
	}

	witness := parser.C.Witness(*cfg.CircuitSize, parser.CurveID, *cfg.Circuit, circuits.WithInputWitness(*cfg.InputPath))

	f, err := os.Create("tmp/witness.dat")
	if err != nil {
		panic("Failed to create file: " + err.Error())
	}
	defer f.Close()

	_, err = witness.WriteTo(f)
	if err != nil {
		panic("Failed to write to file: " + err.Error())
	}
	return
}

func Execute() {
	if err := plonkMemoryWitnessCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}

func init() {

	cobra.OnInitialize()

	_curves := ecc.Implemented()
	curves := make([]string, len(_curves))
	for i := 0; i < len(_curves); i++ {
		curves[i] = strings.ToLower(_curves[i].String())
	}

	cfg.InputPath = plonkMemoryWitnessCmd.PersistentFlags().String("input", "none", "input path to the dedicated input")
	plonkMemoryWitnessCmd.MarkPersistentFlagRequired("input")
	cfg.Circuit = plonkMemoryWitnessCmd.PersistentFlags().String("circuit", "expo", "name of the circuit to use")
	cfg.CircuitSize = plonkMemoryWitnessCmd.PersistentFlags().Int("size", 10000, "size of the circuit, parameter to circuit constructor")
	cfg.Count = plonkMemoryWitnessCmd.PersistentFlags().Int("count", 2, "bench count (time is averaged on number of executions)")
	cfg.Curve = plonkMemoryWitnessCmd.PersistentFlags().String("curve", "bn254", "curve name. must be "+fmt.Sprint(curves))
	cfg.FileType = plonkMemoryWitnessCmd.PersistentFlags().String("filetype", "csv", "Type of file to output for benchmarks")
}
