include 'linear_algebra.f'
program main
    use linear_algebra
    real, dimension(:,:), allocatable :: id, matrix, matIn, matOut
    real, dimension(:), allocatable :: vector, coefficients
    real, dimension(:), allocatable :: eigenvalues
    character(len=50) :: filename
    character :: tmp
    integer :: i, j, n

    print*, 'This program prints the eigenpolynomial coefficients of a matrix'
    print*, ''
    print*, 'Default file is matrix.txt, use another file? [Y/n]'
    read(*,*) tmp
    if (tmp == 'y' .OR. tmp =='Y') then
        print*, 'Name of file with matrix A and vector B, with their rows in &
            &order:'
        read(*,*) filename
        print*, 'Reading ', trim(filename)
    else
        print*, 'Reading matrix.txt'
        filename = 'matrix.txt'
    end if

    open(9, file=filename)
    n = 0
    !this do, counts lines
    do                              
        read(9,*,END=100) tmp
        n = n+1
    end do
    100     print*, 'Found matrix of dimension', n
    allocate(matIn(n,n))
    allocate(matOut(n,n))
    allocate(Id(n,n))
    allocate(matrix(n,n))
    allocate(eigenValues(n))
    allocate(coefficients(n))
    allocate(vector(n))
    rewind 9

    !read by row
    do i=1,n
        read(9,*) matIn(i,:)
    end do
    close (9)

    !identity matrix
    do i=1,n
        do j=1,n
            if (i == j) then
                id(i,j) = 1
            else
                id(i,j) = 0
            end if
        end do
    end do

    print*, 'The matrix A is'
    do i=1,n
        print*, matIn(i,:)
    end do

    !determinant of matrix - lambda*Identity
    !it creates an eigenpolynomial of grade n for any values of lambda
    !taking n values, say 1,2,3,..., we have a system of linear equations
    !the matrix multiplied by the coefficients of the eigenpolynomial
    !to solve we invert the matrix and multiply for the vector whose value
    !per element is the result of the determinant in said values
    !1,2,...,etc.
    ! M*X = V --> X = inv(M)*V, where X are the coefficients
    !and then solve for the eigenvalues
    do i=1,n
        do j=1,n
            matrix(i,j) = i**(n-j)
        end do
        vector(i) = determinant(matIn-i*id)
    end do
    print*, 'matrix'
    do i=1,n
        print*, matrix(i,:) 
    enddo
    coefficients = matrixvector(inv(matrix),vector)
    print*, "coefficients of eigenpolynomial", coefficients
end program main
