!Author: Gustavo Murillo Vega
      include 'linear-algebra.f'
      program matrix_vector_product
      use auxiliar
      real :: sizeB
      real, dimension(:,:), allocatable :: A
      real, dimension(:), allocatable :: B, X
      character(len=50) :: filename
      character(len=5000) :: tmp
      integer :: i, n
      write(*,*) 'This program solves AX=B, where'
      write(*,*) 'A is a square matrix, ',
     &  'X and B are column vectors.'
      write(*,*) ''
      write(*,*) 'Name of file with matrix A and vector B, ',
     &  'with their rows in order:'
      read(*,*) filename
      open(9, file=filename)
      n = 0
      do                              !this do counts lines
              read(9,*,END=100) tmp
              n = n+1
      enddo
100   n = n-1
      print*, 'Found matrix of dimension', n
      allocate(A(n,n))
      allocate(B(n))
      allocate(X(n))
      rewind 9
      do i=1,n                        !read by row
              read(9,*) A(i,:)
      enddo
      read(9,*) B(:)
      close (9)
      write(*,*) 'The matrix A is'
      do i=1,n
              write(*,*) A(i,:)
      enddo
      write(*,*) 'The vector B is'
      write(*,*) B(:)
      sizeB = norm(B)                 !defined at included file
      write(*,*) 'The size of B is', sizeB
!minimum precision of real is 9 digits
      A(:,:) = A(:,:)*100
      print*, 'determinantA', determinant(A)
      if (abs(determinant(A)) < 1E-9) then 
              if (sizeB < 1E-9) then 
                      write(*,*) 'any X is solution'
              else
                      write(*,*) 'there is no solution for X'
              endif
      else
              X = matrixvector(inv(A),B)   !defined at included file
              write(*,*) 'The vector which solves AX=B is X=A¯¹B:'
              write(*,*) X(:)
              open(10,file='output')
              do i=1,n
                      write(10,*) A(i,:)
              enddo
              write(10,*) ''
              write(10,*) X
              close(10)
      endif
      endprogram
