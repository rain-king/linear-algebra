include "linear_algebra.f"

subroutine get_filename(filename, default_filename)
    character(len=*) :: filename
    character(len=*) :: default_filename
    character(len=3) :: answer
    print*, "&
This program reads a file looking for a matrix and a vector, then prints their"
    print*, " product (MATRIX x VECTOR, not VECTOR x MATRIX)."
    print*, "&
The file must have one row vector per line."
    print*, "&
The default file to read is "//default_filename//". Do you want to read another"
    print*, "file? (Y/n)"
    read(*,*) answer
    if (answer == 'y' .OR. answer == 'Y' .OR. answer == "yes") then
        print*, "Read which file?"
        read(*,*) filename
    else
        filename = default_filename
    end if
end subroutine get_filename

subroutine get_lines(file_unit, number_of_lines)
    integer :: file_unit, number_of_lines
    character :: buffer
    number_of_lines = 0
    do
        read(file_unit,*,END=100) buffer !reads a line, moves down a line
        number_of_lines = number_of_lines+1
    end do
100 print *, number_of_lines, " lines found"
    rewind file_unit
end subroutine get_lines

program main
    use linear_algebra
    real, allocatable :: matrix(:,:), vector(:)
    integer :: i, matrix_dimension
    character(len=50) :: filename
    call get_filename(filename, "solution_to_matrix_and_vector.txt")
    open(10, file=filename)
    call get_lines(10, matrix_dimension)
    matrix_dimension = matrix_dimension -1
    allocate(matrix(matrix_dimension, matrix_dimension))
    allocate(vector(matrix_dimension))
    do i = 1, matrix_dimension
        read(10,*) matrix(i,:)
    end do
    read(10,*) vector(:)
    close(10)
    print*, matrixVector(matrix, vector)
end program main
