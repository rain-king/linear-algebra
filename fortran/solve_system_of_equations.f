!alternatively use solveX from linear-algebra.f
include 'linear_algebra.f'
program main
    use linear_algebra
    real :: sizeB
    real, dimension(:,:), allocatable :: A
    real, dimension(:), allocatable :: B, X
    character(len=50) :: filename
    character(len=5000) :: tmp
    integer :: i, n

    print*, 'This program solves AX=B, where'
    print*, 'A is a square matrix, X and B are column vectors.'
    print*, ''
    print*, 'Default file is example.txt, use another file? [Y/n]'
    read(*,*) tmp
    if (tmp == 'y' .OR. tmp =='Y') then
        print*, 'Name of file with matrix A and vector B, with their rows in &
            &order:'
        read(*,*) filename
        print*, 'Reading ', trim(filename)
    else
        print*, 'Reading example.txt'
        filename = 'example.txt'
    end if

    open(9, file=filename)
    n = 0
    !this do, counts lines
    do                              
        read(9,*,END=100) tmp
        n = n+1
    end do
    100     n = n-1
    print*, 'Found matrix of dimension', n
    allocate(A(n,n))
    allocate(B(n))
    allocate(X(n))
    rewind 9

    !read by row
    do i=1,n
        read(9,*) A(i,:)
    end do
    read(9,*) B(:)
    close (9)
    print*, 'The matrix A is'
    do i=1,n
        print*, A(i,:)
    end do
    print*, 'The vector B is'
    print*, B(:)
    !norm defined at included file, distance from one point to another
    sizeB = norm(B)                 
    print*, 'The size of B is', sizeB
    !minimum precision of real is 9 digits, if smaller, the consider it as
    !zero
    A(:,:) = A(:,:)*100
    print*, 'determinantA', determinant(A)
    if (abs(determinant(A)) < 1E-9) then 
        if (sizeB < 1E-9) then 
            print*, 'any X is solution'
        else
            print*, 'there is no solution for X'
        end if
    else
        X = matrixvector(inv(A),B)   !defined at included file
        print*, 'The vector which solves AX=B is X=A¯¹B:'
        print*, X(:)
        open(10,file='output.txt')
        do i=1,n
            write(10,*) A(i,:)
        end do
        write(10,*) ''
        write(10,*) X
        close(10)
    end if
end program main
