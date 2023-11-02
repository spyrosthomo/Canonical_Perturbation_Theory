!Basic definitions of variables for the suite rksuite
 implicit none
!NEQ is the number of equations, 6 in 3 dimansions
!METHOD=2 is for RK45.
 INTEGER            NEQ,  LENWRK,       METHOD
 PARAMETER         (NEQ=6,LENWRK=32*NEQ,METHOD=2)
  real(8) :: omega_bar, OMEGA, k
 real(8) :: v1, v2
 integer :: n1,n2,m1,m2
 
 COMMON /COUPLINGS/omega_bar, OMEGA, k, v1, v2, n1, n2, m1, m2
 
 

