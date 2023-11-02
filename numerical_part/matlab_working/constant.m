function I=constant(t,th,j,k,OMEGA,omega,v1,n1,m1,v2,n2,m2)
    SIN =@(v,n,m,t,th,j,k,OMEGA) v*n*cos(n*th-m*OMEGA*t)./(m*OMEGA-n*(omega+k*j.^(k-1)));
    Is1 =@(t,th,j) ( (m1*OMEGA-n1*omega)*(m2*OMEGA-n2*omega)*j +(n1*(m2*OMEGA-n2*omega)+n2*(m1*OMEGA-n1*omega))*j.^k/k +n1*n2*k^2*j.^(2*k-1)/(2*k-1) );
    Is2 =@(t,th,j,n1,m1,n2,m2,k,omega,OMEGA) -(m1*OMEGA-n1*(omega+k*j.^(k-1))).*(m2*OMEGA-n2*(omega+k*j.^(k-1)));
    II  =@(t,th,j) Is1(t,th,j) + Is2(t,th,j,n1,m1,n2,m2,k,omega,OMEGA).*( SIN(v1,n1,m1,t,th,j,k,OMEGA)+SIN(v2,n2,m2,t,th,j,k,OMEGA) );
    I   = II(t,th,j);
    s=SIN(0.0001,4,6,2*pi,pi/2,0.25,k,OMEGA)
    i=Is2(2*pi,pi/2,0.25,4,6,3,6,2,1,1)
end