def T0(m1,m2):
    '''
    T0 = l1*T_1 = l2*T_2 , where 
    l1, l2, min integers s.t. l1/l2=m1/m2
    '''
    #--
    import inc
    import math
    OMEGA = inc.OMEGA 
    #-------
    T1 = 2*math.pi/(OMEGA*l1) ; T2 = 2*math.pi/(OMEGA*l2)
    m  = m1/m2 
    if m1%m2==0:
        l1 = m1
        l2 = 1
    else:
        if is_prime(m1) & is_prime(m2):
            l1=m1; l2=m2
        else:
            l1=m1; l2=m2
            
        
