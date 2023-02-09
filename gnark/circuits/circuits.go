package circuits

import (
	"github.com/consensys/gnark-crypto/ecc"
	bls12377fr "github.com/consensys/gnark-crypto/ecc/bls12-377/fr"

	bls12381fr "github.com/consensys/gnark-crypto/ecc/bls12-381/fr"
	bls24315fr "github.com/consensys/gnark-crypto/ecc/bls24-315/fr"
	bn254fr "github.com/consensys/gnark-crypto/ecc/bn254/fr"
	bw6633fr "github.com/consensys/gnark-crypto/ecc/bw6-633/fr"
	bw6761fr "github.com/consensys/gnark-crypto/ecc/bw6-761/fr"
	"github.com/consensys/gnark/backend/witness"
	"github.com/consensys/gnark/frontend"
	"github.com/tumberger/zk-compilers/gnark/circuits/prf/mimc"
	"github.com/tumberger/zk-compilers/gnark/circuits/toy/cubic"
	"github.com/tumberger/zk-compilers/gnark/circuits/toy/expo"
	"github.com/tumberger/zk-compilers/gnark/circuits/toy/exponentiate"
)

var BenchCircuits map[string]BenchCircuit

type BenchCircuit interface {
	Circuit(size int, name string) frontend.Circuit
	Witness(size int, curveID ecc.ID, name string) *witness.Witness
}

type TemplateCircuit struct {
	X frontend.Variable
	Y frontend.Variable `gnark:",public"`
}

func init() {
	BenchCircuits = make(map[string]BenchCircuit)
	BenchCircuits["cubic"] = &defaultCircuit{}
	BenchCircuits["expo"] = &defaultCircuit{}
	BenchCircuits["exponentiate"] = &defaultCircuit{}

	BenchCircuits["mimc"] = &defaultCircuit{}
}

func preCalc(size int, curveID ecc.ID) interface{} {
	switch curveID {
	case ecc.BN254:
		// compute expected Y
		var expectedY bn254fr.Element
		expectedY.SetInterface(2)
		for i := 0; i < size; i++ {
			expectedY.Mul(&expectedY, &expectedY)
		}
		return expectedY
	case ecc.BLS12_381:
		// compute expected Y
		var expectedY bls12381fr.Element
		expectedY.SetInterface(2)
		for i := 0; i < size; i++ {
			expectedY.Mul(&expectedY, &expectedY)
		}

		return expectedY
	case ecc.BLS12_377:
		// compute expected Y
		var expectedY bls12377fr.Element
		expectedY.SetInterface(2)
		for i := 0; i < size; i++ {
			expectedY.Mul(&expectedY, &expectedY)
		}

		return expectedY
	case ecc.BLS24_315:
		// compute expected Y
		var expectedY bls24315fr.Element
		expectedY.SetInterface(2)
		for i := 0; i < size; i++ {
			expectedY.Mul(&expectedY, &expectedY)
		}

		return expectedY
	case ecc.BW6_761:
		// compute expected Y
		var expectedY bw6761fr.Element
		expectedY.SetInterface(2)
		for i := 0; i < size; i++ {
			expectedY.Mul(&expectedY, &expectedY)
		}

		return expectedY
	case ecc.BW6_633:
		// compute expected Y
		var expectedY bw6633fr.Element
		expectedY.SetInterface(2)
		for i := 0; i < size; i++ {
			expectedY.Mul(&expectedY, &expectedY)
		}

		return expectedY
	default:
		panic("not implemented")
	}
}

type defaultCircuit struct {
}

func (d *defaultCircuit) Circuit(size int, name string) frontend.Circuit {
	switch name {
	case "cubic":
		return &cubic.CubicCircuit{}
	case "expo":
		return &expo.BenchCircuit{N: size}
	case "exponentiate":
		return &exponentiate.ExponentiateCircuit{}
	case "mimc":
		return &mimc.MimcCircuit{}
	default:
		panic("not implemented")
	}
}

func (d *defaultCircuit) Witness(size int, curveID ecc.ID, name string) *witness.Witness {

	switch name {
	case "cubic":
		witness := cubic.CubicCircuit{}
		witness.X = (3)
		witness.Y = (35)

		w, err := frontend.NewWitness(&witness, curveID)
		if err != nil {
			panic(err)
		}
		return w
	case "expo":
		witness := expo.BenchCircuit{N: size}
		witness.X = (2)
		witness.Y = preCalc(size, curveID)

		w, err := frontend.NewWitness(&witness, curveID)
		if err != nil {
			panic(err)
		}
		return w
	case "exponentiate":
		witness := exponentiate.ExponentiateCircuit{}
		witness.X = (2)
		witness.E = (12)
		witness.Y = (4096)

		w, err := frontend.NewWitness(&witness, curveID)
		if err != nil {
			panic(err)
		}
		return w
	case "mimc":
		witness := mimc.MimcCircuit{}
		witness.PreImage = ("16130099170765464552823636852555369511329944820189892919423002775646948828469")
		witness.Hash = ("8674594860895598770446879254410848023850744751986836044725552747672873438975")

		w, err := frontend.NewWitness(&witness, curveID)
		if err != nil {
			panic(err)
		}
		return w
	default:
		panic("not implemented")
	}
}