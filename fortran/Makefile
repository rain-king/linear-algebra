############################# PREAMBLE #############################
FC = gfortran
CFLAGS = -ffree-form
src = solve_system_of_equations.f array_slicing_example.f \
	  coefficients_of_eigenpolynomial.f matrix_by_vector.f
binaries = $(src:.f=.bin)

.PHONY: prebuild clean clean-mod all test install

############################# TARGETS ##############################
all: $(binaries)

prebuild:
	@if [ ! -d bin ]; then mkdir bin; fi

README.html: README.md
	@pandoc -f gfm -t html README.md -o README.html

############################# BINARIES #############################
$(binaries): prebuild $(src)
	@$(FC) $(@:.bin=.f) -o bin/$@ $(CFLAGS)

install: $(binaries)
	@if [ $${PREFIX:(-1)} != "/" ]; then \
		PREFIX="$$PREFIX/"; \
	fi; \
	@mkdir -p $${PREFIX}bin; \
	@for binary in $^; do \
		install bin/$$binary $${PREFIX}bin; \
	done

############################## TESTS ###############################
tests: all
	@./tests.sh

############################## CLEAN ###############################
clean: clean_mod
	rm -rf bin solution_to_matrix_and_vector.txt
clean_mod:
	rm -f *.mod
clean_tests:
	rm -f tests.sh.log
