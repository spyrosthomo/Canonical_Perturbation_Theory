print("#Numerical method for ODE system approximation")
print("#------------------------------------------------------")
#-------------------------
#!!!!!!!!
#TO BE MADE INTERACTIVE
#Choose method
#meth = "rk4"
#syst = "double_pen" #"g_field" "hoc" "Bz_E"
#import rk4        as method
#Choose derivatives
#import double_pen as der  # hoc constant_Bz_E

#--------------------------------------------
# initialize methods and systems available :))
#
methods = {1:"rk4"}
systems = {1:"system_hw"} 
#-------------------------------------------
# standard imports 
import numpy as np
import inc
import importlib 
import math
import mods          # contains the needed modules
import matplotlib.pyplot as plt 
#--------------------------------------------
inc.dp  = 7            # number of decimals in the exported file

# INPUTS
#--- choose method & system-------
for i in methods:
    print(i, " : ", methods[i])
print("#======================================================")
for i in systems:
    print(i, " : ", systems[i])
print("#------------------------------------------------------")
inc.meth = methods[int(input("Choose method: "))]
inc.syst = systems[int(input("Choose system: "))] 
#-------------------------------
inc.NEQ                                                       = int(input("# Enter the number of equations                       : \n"))
inc.omega,inc.OMEGA,inc.k                                     = [float(x) for x in input("# Enter the parameters omega, OMEGA,k  : \n").split()]
inc.v1   ,inc.v2                                              = [float(x) for x in input("# Enter the parameters v1   , v2       : \n").split()]
inc.n1   ,inc.m1   ,inc.n2, inc.m2                            = [int(  x) for x in input("# Enter the integers n1, m1, n2, m2    : \n").split()]
steps                                                         = int(               input("# Enter number of steps                : \n"))
inc.t0,inc.tf,inc.th0,inc.j0                                  = [float(x) for x in input("# Enter t0, tf, th0, j0                : \n").split()]
# \theta \in [0,2\pi) 
tanth0  = math.tan(inc.th0) 
inc.th0 = math.atan(tanth0) 
#extras                                                        = input("# Do you want to compute extra functions of the solution? (y/n) : \n")
# For exmple extras are needed for systems solved in polar coordinates, if we want to compute cartesian coordinates.
#----------------
# ease - variables from inc.py
#
omega= inc.omega;OMEGA=inc.OMEGA; k=inc.k
n1   = inc.n1   ; n2  =inc.n2   ;m1=inc.m1; m2=inc.m2
v1   = inc.v1   ; v2  =inc.v2 
th0  = inc.th0  ; j0  =inc.j0
NEQ  = inc.NEQ
t0   = inc.t0   ; tf=inc.tf
meth = inc.meth
syst = inc.syst
dp   = inc.dp
NEQ  = inc.NEQ
#T0   = mods.T0(m1,m2)
T0 = 2*math.pi/(omega)
#
# PRINT INPUTS
print( "# Chosen method %s " %(meth))
print( "# Chosen system %s " %(syst))
print( "#  omega = %.4f, OMEGA= %.4f, k = %.4f  "       %(omega, OMEGA, k))
print( "#  v1    = %.4f, v2   = %.4f            "       %(v1   ,v2       )) 
print( "#  n1    = %d  , m1   = %d  , n2= %d  , m2= %d" %(n1,m1,n2,m2    ))
print(f"# steps  = {steps}")
print( "#    t0  = %.4f, tf = %.4f " % (t0,tf))
print( "#   th0 = %.4f,  j0 = %.4f " % (th0,j0))
#print( "# Extra Functions %s " % (extras))
print( "#------------------------------------------------------")
#--------------------------------------------------------------
# !! imports given by user 
#
method = importlib.import_module(meth)
der    = importlib.import_module(syst)
#---------------------------------------------------------------
# Initial conditions & Initilizations
dt     = (tf - t0 ) / steps
xstart = np.array([th0,j0])
x      = np.zeros(NEQ)
x      = xstart
t      = t0
#---------------------------------------------------------------
#
# Write initial data to a file
# orbit 
fname = meth +"." + syst+ ".dat"
dat   = open(fname, "w", encoding="utf-8")
dat.write(f"%.{dp}f, %.{dp}f, %.{dp}f\n" %(t0, xstart[0], xstart[1]))
# poincare 
fname2= "poincare.dat"
dat2  = open(fname2,"w", encoding="utf-8")
dat2.write(f"%.{dp}f, %.{dp}f, %.{dp}f\n"%(t0, xstart[0], xstart[1]))
#------------------------------------------------------------------
#
# Calculation
for i in range(1,steps+1):
    t = t0 + i*dt
    x = method.m(t,x,dt)
    # write to file
    dat = open(fname, "a", encoding="utf-8")
    #k   = 1 
    #T   = 2*math.pi/OMEGA
    if(x[0]>=2*math.pi or x[0]<0):
        tanth = math.tan( x[0] ) 
        x[0]  = math.atan(tanth)   
    dat.write(f"%.{dp}f, %.{dp}f, %.{dp}f\n" %(t, x[0], x[1]))   
    if (abs((t%T0)-k)<1e-2 ): 
    	dat2.write(f"%.{dp}f, %.{dp}f, %.{dp}f\n" %(t, x[0], x[1]))
    	k += 1 
   
    
 


