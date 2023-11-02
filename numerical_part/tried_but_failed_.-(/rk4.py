#def method(ti, tf, x0, Nt):
#''' ti : initial time 
#    tf : final   time 
#    x0 : NumPy array (1xNEQ) which contains the initial conditions
#    Nt : steps of integration 
#'''
# TO BE MADE GLOBAL 
#    NEQ = 6
#
#-------
#    x = np.zeros(NEQ)
#-------
#    dt     = (tf-ti) /(Nt-1)
#    t      = ti
#    x      = x0
#    ts     = ti
#    xs     = x0

#    for i in range(1,Nt+1):
#        rkstep(t, xs, dt)
#        t   = ti + (i-1) * dt
#        xs  = x    
        
#--------------------------------------------------
def m(t, x, dt):
    '''One step forward of rk4 method  '''
    #import double_pen as der  #const_Bz_E as der - hoc  - g_field
    #----------
    import importlib
    import inc
    der  = importlib.import_module(inc.syst)
    #----------
    h  = dt
    h2 = 0.5*h
    h6 = h/6.0
   
    #-----------------------
    # Step
    k1 = der.f(t, x)
    #type(k1)
    k2 = der.f(t+h2,x+h2*k1)
    k3 = der.f(t+h2,x+h2*k2)
    k4 = der.f(t+h ,x+h *k3)
    #------------------------------
    t += h
    x += h6*(k1 + 2.0*(k2+k3) + k4)
    return x 

