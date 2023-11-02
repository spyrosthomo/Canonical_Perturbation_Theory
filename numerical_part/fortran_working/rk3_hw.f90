!---------------------------------
!Simple harmonic oscillator
subroutine F(T,Y,YP)
 include 'rk3.inc'
 real(8) :: t
 real(8) :: Y(*),YP(*)
 real(8) :: x1,x2,x3,v1,v2,v3
 x1 = Y(1);v1 = Y(4)
 x2 = Y(2);v2 = Y(5)
 x3 = Y(3);v3 = Y(6)
!Velocities:   dx_i/dt = v_i
 YP(1) = v1
 YP(2) = v2
 YP(3) = v3
!Acceleration: dv_i/dt = a_i
 YP(4) = -k1*x1
 YP(5) = -k2*x2
 YP(6) = -k3*x3
end subroutine F
!---------------------------------
real(8) function energy(T,Y)
 include 'rk3.inc'
 real(8) :: t,e
 real(8) :: Y(*)
 real(8) :: x1,x2,x3,v1,v2,v3
 x1 = Y(1);v1 = Y(4)
 x2 = Y(2);v2 = Y(5)
 x3 = Y(3);v3 = Y(6)
!Kinetic Energy
 e = 0.5*(v1*v1+v2*v2+v3*v3)
!Potential Energy
 e = e + 0.5D0*(k1*x1*x1+k2*x2*x2+k3*x3*x3)
 energy = e
end function energy
