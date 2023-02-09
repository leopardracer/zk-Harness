SHELL = zsh

benchmark_directory = benchmarks

gnark_directory = gnark
gnark_benchmarks_directory = $(benchmark_directory)/$(gnark_directory)

circom_directory = circom
circom_benchmarks_directory = $(benchmark_directory)/$(circom_directory)
circom_script = $(circom_directory)/scripts/run_circuit.sh
circom_circuits = $(circom_directory)/circuits/benchmarks
circom_inputs = $(circom_directory)/inputs/benchmarks
circom_ptau = $(circom_directory)/phase1/powersOfTau28_hez_final_16.ptau 


all: benchmark-toy

benchmark-toy-circom:
	$(info --------------------------------------------)
	$(info ---------- CIRCOM TOY BENCHMARKS -----------)
	$(info --------------------------------------------)
	$(circom_script) $(circom_circuits)/cubic/circuit.circom $(circom_inputs)/cubic/input.json $(circom_ptau) $(circom_benchmarks_directory)/circom_cubic.csv; rm -rf tmp

benchmark-toy-gnark:
	$(info --------------------------------------------)
	$(info ----------- GNARK TOY BENCHMARKS -----------)
	$(info --------------------------------------------)
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=expo --algo=setup 
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=expo --algo=prove 
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=expo --algo=verify 
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=expo --algo=setup --curve=bls12_377
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=expo --algo=prove --curve=bls12_377
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=expo --algo=verify --curve=bls12_377
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=expo --algo=setup --curve=bw6_761
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=expo --algo=prove --curve=bw6_761
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=expo --algo=verify --curve=bw6_761
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=expo --algo=setup --curve=bls24_315
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=expo --algo=prove --curve=bls24_315
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=expo --algo=verify --curve=bls24_315
	# cd $(gnark_directory); go build; ./gnark groth16 --circuit=expo --algo=setup --curve=bw6_756
	# cd $(gnark_directory); go build; ./gnark groth16 --circuit=expo --algo=prove --curve=bw6_756
	# cd $(gnark_directory); go build; ./gnark groth16 --circuit=expo --algo=verify --curve=bw6_756
	cd $(gnark_directory); go build; ./gnark plonk --circuit expo --algo=setup 
	cd $(gnark_directory); go build; ./gnark plonk --circuit expo --algo=prove
	cd $(gnark_directory); go build; ./gnark plonk --circuit expo --algo=verify 
	cd $(gnark_directory); go build; ./gnark plonk --circuit expo --algo=setup --curve=bls12_377
	cd $(gnark_directory); go build; ./gnark plonk --circuit expo --algo=prove --curve=bls12_377
	cd $(gnark_directory); go build; ./gnark plonk --circuit expo --algo=verify --curve=bls12_377
	cd $(gnark_directory); go build; ./gnark plonk --circuit expo --algo=setup --curve=bw6_761
	cd $(gnark_directory); go build; ./gnark plonk --circuit expo --algo=prove --curve=bw6_761
	cd $(gnark_directory); go build; ./gnark plonk --circuit expo --algo=verify --curve=bw6_761
	# cd $(gnark_directory); go build; ./gnark plonk --circuit expo --algo=setup --curve=bls12_378
	# cd $(gnark_directory); go build; ./gnark plonk --circuit expo --algo=prove --curve=bls12_378
	# cd $(gnark_directory); go build; ./gnark plonk --circuit expo --algo=verify --curve=bls12_378
	# cd $(gnark_directory); go build; ./gnark plonk --circuit expo --algo=setup --curve=bw6_756
	# cd $(gnark_directory); go build; ./gnark plonk --circuit expo --algo=prove --curve=bw6_756
	# cd $(gnark_directory); go build; ./gnark plonk --circuit expo --algo=verify --curve=bw6_756

	cd $(gnark_directory); go build; ./gnark groth16 --circuit=cubic --algo=setup 
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=cubic --algo=prove 
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=cubic --algo=verify 
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=cubic --algo=setup --curve=bls12_377
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=cubic --algo=prove --curve=bls12_377
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=cubic --algo=verify --curve=bls12_377
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=cubic --algo=setup --curve=bw6_761
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=cubic --algo=prove --curve=bw6_761
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=cubic --algo=verify --curve=bw6_761
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=cubic --algo=setup --curve=bls24_315
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=cubic --algo=prove --curve=bls24_315
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=cubic --algo=verify --curve=bls24_315
	# cd $(gnark_directory); go build; ./gnark groth16 --circuit=cubic --algo=setup --curve=bw6_756
	# cd $(gnark_directory); go build; ./gnark groth16 --circuit=cubic --algo=prove --curve=bw6_756
	# cd $(gnark_directory); go build; ./gnark groth16 --circuit=cubic --algo=verify --curve=bw6_756
	cd $(gnark_directory); go build; ./gnark plonk --circuit cubic --algo=setup 
	cd $(gnark_directory); go build; ./gnark plonk --circuit cubic --algo=prove
	cd $(gnark_directory); go build; ./gnark plonk --circuit cubic --algo=verify 
	cd $(gnark_directory); go build; ./gnark plonk --circuit cubic --algo=setup --curve=bls12_377
	cd $(gnark_directory); go build; ./gnark plonk --circuit cubic --algo=prove --curve=bls12_377
	cd $(gnark_directory); go build; ./gnark plonk --circuit cubic --algo=verify --curve=bls12_377
	cd $(gnark_directory); go build; ./gnark plonk --circuit cubic --algo=setup --curve=bw6_761
	cd $(gnark_directory); go build; ./gnark plonk --circuit cubic --algo=prove --curve=bw6_761
	cd $(gnark_directory); go build; ./gnark plonk --circuit cubic --algo=verify --curve=bw6_761
	# cd $(gnark_directory); go build; ./gnark plonk --circuit cubic --algo=setup --curve=bls12_378
	# cd $(gnark_directory); go build; ./gnark plonk --circuit cubic --algo=prove --curve=bls12_378
	# cd $(gnark_directory); go build; ./gnark plonk --circuit cubic --algo=verify --curve=bls12_378
	# cd $(gnark_directory); go build; ./gnark plonk --circuit cubic --algo=setup --curve=bw6_756
	# cd $(gnark_directory); go build; ./gnark plonk --circuit cubic --algo=prove --curve=bw6_756
	# cd $(gnark_directory); go build; ./gnark plonk --circuit cubic --algo=verify --curve=bw6_756

	cd $(gnark_directory); go build; ./gnark groth16 --circuit=exponentiate --algo=setup 
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=exponentiate --algo=prove 
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=exponentiate --algo=verify 
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=exponentiate --algo=setup --curve=bls12_377
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=exponentiate --algo=prove --curve=bls12_377
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=exponentiate --algo=verify --curve=bls12_377
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=exponentiate --algo=setup --curve=bw6_761
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=exponentiate --algo=prove --curve=bw6_761
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=exponentiate --algo=verify --curve=bw6_761
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=exponentiate --algo=setup --curve=bls24_315
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=exponentiate --algo=prove --curve=bls24_315
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=exponentiate --algo=verify --curve=bls24_315
	# cd $(gnark_directory); go build; ./gnark groth16 --circuit=exponentiate --algo=setup --curve=bw6_756
	# cd $(gnark_directory); go build; ./gnark groth16 --circuit=exponentiate --algo=prove --curve=bw6_756
	# cd $(gnark_directory); go build; ./gnark groth16 --circuit=exponentiate --algo=verify --curve=bw6_756
	cd $(gnark_directory); go build; ./gnark plonk --circuit exponentiate --algo=setup 
	cd $(gnark_directory); go build; ./gnark plonk --circuit exponentiate --algo=prove
	cd $(gnark_directory); go build; ./gnark plonk --circuit exponentiate --algo=verify 
	cd $(gnark_directory); go build; ./gnark plonk --circuit exponentiate --algo=setup --curve=bls12_377
	cd $(gnark_directory); go build; ./gnark plonk --circuit exponentiate --algo=prove --curve=bls12_377
	cd $(gnark_directory); go build; ./gnark plonk --circuit exponentiate --algo=verify --curve=bls12_377
	cd $(gnark_directory); go build; ./gnark plonk --circuit exponentiate --algo=setup --curve=bw6_761
	cd $(gnark_directory); go build; ./gnark plonk --circuit exponentiate --algo=prove --curve=bw6_761
	cd $(gnark_directory); go build; ./gnark plonk --circuit exponentiate --algo=verify --curve=bw6_761
	# cd $(gnark_directory); go build; ./gnark plonk --circuit exponentiate --algo=setup --curve=bls12_378
	# cd $(gnark_directory); go build; ./gnark plonk --circuit exponentiate --algo=prove --curve=bls12_378
	# cd $(gnark_directory); go build; ./gnark plonk --circuit exponentiate --algo=verify --curve=bls12_378
	# cd $(gnark_directory); go build; ./gnark plonk --circuit exponentiate --algo=setup --curve=bw6_756
	# cd $(gnark_directory); go build; ./gnark plonk --circuit exponentiate --algo=prove --curve=bw6_756
	# cd $(gnark_directory); go build; ./gnark plonk --circuit exponentiate --algo=verify --curve=bw6_756

benchmark-prf:
	# MIMC over bls12_377, bw6_761, bls24_315 yields an error -> unsatisfied constraint
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=mimc --algo=setup 
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=mimc --algo=prove 
	cd $(gnark_directory); go build; ./gnark groth16 --circuit=mimc --algo=verify 
	cd $(gnark_directory); go build; ./gnark plonk --circuit mimc --algo=setup 
	cd $(gnark_directory); go build; ./gnark plonk --circuit mimc --algo=prove
	cd $(gnark_directory); go build; ./gnark plonk --circuit mimc --algo=verify 


clean:
	rm -r $(gnark_benchmarks_directory)/*