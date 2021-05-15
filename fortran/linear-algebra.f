!can change real(4) for any kind, in vim %s/real(4)/real(16)/g would do
!the trick

module linear_algebra
    implicit none
contains

    function inv(A)
        real(4), intent(in) :: A(:,:)
        real(4), allocatable :: inv(:,:)
        integer :: i, j, n
        n = size(A,1)
        allocate(inv(n,n))
        inv = adj(A)
        inv(:,:) = inv(:,:)/determinant(A)
    end function

    function adj(A)
        real(4), intent(in) :: A(:,:)
        real(4), allocatable :: adj(:,:)
        integer :: i, j, n
        n = size(A,1)
        allocate(adj(n,n))
        do i=1,n
            do j=1,n
                adj(i,j) = (-1)**(i+j)*determinant(minor(A,j,i))
            end do
        end do
    end function

    real(4) recursive function determinant(A) result(dsum)
        real(4) :: A(:,:)
        integer :: d, i, j
        d=size(A,1)
        dsum=0
        if (d > 2) then
            do j=1,d
                dsum = dsum + A(1,j)*(-1)**(1+j)*determinant(minor(A,1,j))
            end do
        else if (d == 2) then
            dsum = A(1,1)*A(2,2)-A(1,2)*A(2,1)
        else if (d == 1) then
            dsum = A(1,1)
        end if
    end function determinant

    ! if the next function 'minor' or any other in this file
    ! can be done in a more efficient way I'll be glad to know
    ! and branch that into my repo

    function minor(A, Ai, Aj)
    ! Mnxn -> Mn-1xn-1
    ! From input matrix, creates another matrix without row Ai and column Aj
        real(4), intent(in) :: A(:,:)
        real(4), allocatable :: minor(:,:)
        integer, intent(in) ::    Ai, Aj
        integer :: k, l, d, i, j
        d = size(A,1)
        allocate(minor(d-1, d-1))
        k = 1
        l = 1
        do i=1,d
            if (i /= Ai) then
                l = 1
                do j=1,d
                    if (j /= Aj) then
                        minor(k,l) = A(i,j)
                        l = l+1
                    end if
                end do
                k = k+1
            end if
        end do
    end function

    function norm(X)
    !return euclidean norm
        real(4) :: norm
        real(4), dimension (:), intent(in) :: X
        integer :: i
        norm = 0
        do i=1,size(X)
            norm = norm+abs(X(i))**2
        end do
        norm = sqrt(norm)
    end function

    function matrixVector(A,B)
    !returns matrix A by vector B
        real(4) :: A(:,:), B(:)
        real(4), allocatable :: matrixvector(:)
        real(4) :: fsum
        integer :: i, k, n
        n = size(B)
        allocate(matrixvector(n))
        do i=1,n
        fsum = 0
            do k=1,n
                fsum = fsum+A(i,k)*B(k)
            end do
        matrixvector(i)=fsum
        end do
    end function

    function matrixMatrix(A,B)
    !return AxB
        real(4) :: A(:,:), B(:,:)
        real(4), allocatable :: matrixMatrix(:,:)
        real(4) :: fsum
        integer :: i, j, k, n
        n = size(A,1)
        allocate(matrixMatrix(n,n))
        do i=1,n
            do j=1,n
                fsum=0
                do k=1,n
                    fsum=fsum+A(i,k)*B(k,j)
                end do
                matrixMatrix(i,j)=fsum
            end do
        end do
    end function

    integer function maxInVector(A)
        real(4), intent(in) :: A(:)
        integer :: i, n
        n = size(A)
        maxInVector=1
        do i=1,n
            if (A(i) > A(maxInVector)) maxInVector = i
        end do
    end function

    subroutine solveX(A,B,X,message)
    !solve system AX=B, for X
    !additionally writes exit status to message
        real(4) :: sizeB, A(:,:), B(:), X(:)
        character(len=50) :: message
        if (size(B) /= size(X)) print*, 'X and B of different dimensions'
        sizeB = norm(B)
        if (abs(determinant(A)) < 1E-6) then
            if (sizeB < 1E-6) then
                message = 'Any X is solution.'
            else
                message = 'No solution for X.'
            end if
        else
            X = matrixvector(inv(A),B)
            message = '0'
        end if
    endsubroutine

    subroutine writef(A,B,X,n)
    !write solution of solvex to file
    !open a file with open in unit n, then use this subroutine
        real(4) :: A(:,:), B(:), X(:)
        integer :: i, n
        write(n,*) 'Matrix'
        do i=1,size(B)
            write(n,*) A(i,:)
        end do
        write(n,*) 'multiplied by vector (solution)'
        do i=1,size(B)
            write(n,*) X(i)
        end do
        write(n,*) 'equals vector'
        do i=1,size(B)
            write(n,*) B(i)
        end do
        write(n,*) ''
    endsubroutine

endmodule
