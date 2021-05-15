############################# PREAMBLE #############################
FLAGS = -ffree-form
src = solve_system_of_equations.f array_slicing_example.f \
	  coefficients_of_eigenpolynomial.f matrix_by_vector.f
targets = $(src:.f=.bin)

.PHONY: prebuild clean clean-mod all test

############################# TARGETS ##############################
all: $(targets)

prebuild:
	@if [ ! -d bin ]; then mkdir bin; fi

############################# BINARIES #############################
$(targets): prebuild
	@gfortran $(@:.bin=.f) -o bin/$@ $(FLAGS)

############################## TESTS ###############################
.ONESHELL tests: all
	@./tests.sh

############################## CLEAN ###############################
clean: clean_mod
	rm -rf bin solution_to_matrix_and_vector.txt
clean_mod:
	rm -f *.mod
clean_tests:
	rm -f tests.sh.log
