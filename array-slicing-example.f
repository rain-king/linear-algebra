      program main
        integer :: A(3), B(3), C(5,3)
        data A(:), B(:), C(3,:) /3*1,3*3,3*5/
        B(2) = -5
        C(3,1) = -5
        print *, A(:)+B(:)+C(3,:)
      end program main
