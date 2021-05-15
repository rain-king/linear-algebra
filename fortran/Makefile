############################# PREAMBLE #############################
FLAGS = -ffree-form
src = example.f array-slicing-example.f coefficients-of-eigenpolynomial.f
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
	@./basic-tests.sh

############################## CLEAN ###############################
clean: clean-mod
	rm -rf bin output.txt
clean-mod:
	rm -f *.mod
