!------------------------------------------------
!Particle in constant Magnetic and electric field
!q B/m = k1 z   q E/m = k2 x + k3 y + k4 z
subroutine F(T,Y,YP)
  include 'rk3.inc'
 real(8) :: t
 real(8) :: Y(*),YP(*)
 real(8) :: th, j
 th = Y(1)
 j  = Y(2) 
 !-------------------------
 YP(1) = omega_bar + k*j**(k-1) 
 YP(2) = v1*n1*sin(n1*th-m1*OMEGA*t) + v2*n2*sin(n2*th-m2*OMEGA*t)
end subroutine F
!---------------------------------
