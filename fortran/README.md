# Fortran Linear Algebra Library
## Some programs

You can see the binaries in `bin/`.
### Solve a System Of Equations
To compile:
```
make solve_system_of_equations.bin
```
Running the program in a terminal will ask you for a filename with data, it
must be formatted to one row by line. The default filename will be
`matrix_and_vector.txt`. 

### Eigenpolynomial Coefficients of a Matrix
To compile:
```
make coefficients_of_eigenpolynomial.bin
```
Reads one row per line from the file and returns the coefficients of the
eigenpolynomial corresponding to the matrix.

### Matrix by Vector Product
To compile:
```
make matrix_by_vector.bin
```
Reads a file with a matrix and a vector, respectively prints matrix by vector.

## Tests
To check all programs run without crashing run:
```
make tests
```

### To Do
Check the programs for basic functionality with tests.
