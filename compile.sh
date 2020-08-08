#!/bin/sh
mkdir bin
gfortran example.f -o bin/example.bin
gfortran array-slicing-example.f -o bin/array-slicing-example.bin
gfortran coefficients-of-eigenpolynomial.f -o bin/coefficients-of-eigenpolynomial.bin
