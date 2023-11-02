# ---------------------------------------------------------------------
# Definition of the equations
# \dot{\theta} =& \bar{\omega} + kJ^{k-1} 
# \dot{J     } =& V_1n_1sin(n_1\theta-m_1\Omega t) + V_2n_2sin(n_2\theta-m_2\Omega t)
#----------------------------------------------------------------------
def f(t,x):
     ''' t  : time 
         x  : NumPy array for current x -position variable u
         xp : NumPy array for current x'-momentum variable

          \dot{\theta} =& \bar{\omega} + kJ^{k-1} 
          \dot{J     } =& V_1n_1sin(n_1\theta-m_1\Omega t) + V_2n_2sin(n_2\theta-m_2\Omega t)
   '''
    #	 imports & ease
     import inc
     import numpy as np
     import math 
     omega=inc.omega;OMEGA=inc.OMEGA; k=inc.k
     n1   =inc.n1   ; n2  =inc.n2   ;m1=inc.m1; m2=inc.m2
     v1   = inc.v1  ; v2  =inc.v2 
     NEQ=inc.NEQ
     #-------------------------------
     xp = np.zeros(NEQ)
     th = x[0]
     j  = x[1]
     #---------------------------------
     # generalized momentum - derivatives
     xp[0] = omega + k*j**(k-1) 
     xp[1] = v1*n1*math.sin(n1*th-m1*OMEGA*t) + v2*n2*math.sin(n2*th-m2*OMEGA*t)
     #---------------------------------
     return xp
 #------------------------------------------------
