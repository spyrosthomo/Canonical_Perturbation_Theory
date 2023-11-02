clear;clc;format compact

figure(1); hold on; xlabel("theta"), ylabel("J") 
T0     = 2*pi
theta0 = pi/2
options = odeset('RelTol',1e-6,'Stats','off');%,'OutputFcn')%,@odeplot)

% parameters - fixed  
k     = 2;
OMEGA = 1;

%parameters - wanna change
%--- 
v1=1e-3; v2=1e-3; 

n1=2
m1=3
n2=1
m2=2
T1=2*pi/(m1*OMEGA)
T2=2*pi/(m2*OMEGA)
T0=3*T1 % or 2*T2
% jreses ==> \bar{omega}==omega
jres1k = 0.25      % jers1k = J^{k-1}_{res} 
jres2k = 0.5     % jers2k = J^{k-1}_{res}
omegabar1 = (m1*OMEGA-n1*k*jres1k)/n1
omegabar2 = (m2*OMEGA-n2*k*jres2k)/n2
omega     = 1 % proxeir o
'----------------------'
% resonance actions -- check again
jres1k = (m1*OMEGA-n1*omega)/(n1*k)
jres2k = (m2*OMEGA-n2*omega)/(n2*k)
jres1  = jres1k^(1/(k-1))
jres2  = jres2k^(1/(k-1))
%---------------------------
for J0 = [0.0:0.01:0.7]
    [t,q]=ode45(@(t,y) dH(t,y,v1,v2,OMEGA,k,n1,m1,n2,m2)  ,[0:T0:1e+3*T0],[J0,theta0],options);
    plot(mod(q(:,2),2*pi), q(:,1), 'k.', 'MarkerSize', 2);
    %[t,q]=ode45(@(t,y) dH(t,y,v1,v2,OMEGA,k,n1,m1,n2,m2)  ,[v1 T0-v1],[J0,theta0],options);
    %plot(mod(q(:,2),2*pi), q(:,1), '-', 'LineWidth', 0.2);%, 'MarkerSize', 2);
end

function CanEq=dH(t,q,v1,v2,OMEGA,k,n1,m1,n2,m2)
    J =q(1,:); theta=q(2,:);
    CanEq = [2*v1*sin(n1*theta-m1*OMEGA*t)+v2*sin(n2*theta-m2*OMEGA*t);1+k*J^(k-1)];
end