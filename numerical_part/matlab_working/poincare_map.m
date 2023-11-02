clear;clc;format compact

%T0     = 2*pi/2
theta0 = pi/2
options = odeset('RelTol',1e-7,'Stats','off');%,'OutputFcn')%,@odeplot)

% parameters - fixed  
k     = 2;
OMEGA = 1;
omega = 1;
%% PARAMETERS
%v1=0;v2=0;
v1=1e-3;v2=1e-3;
%v1=1;v2=1;
n1=3
m1=6
n2=4
m2=6
T1=2*pi/(m1*OMEGA)
T2=2*pi/(m2*OMEGA)
T0=m1*T1 %or T0=2*T2
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
%% ---- width
% 1e-3: - res1:    line([1.048,1.048],[0.46376,0.53671],'LineWidth',2)
%       - res2:    line([3.9263,3.9263],[0.2274,0.27419],'LineWidth',2)
% 1e-4: - res1:    line([1.048,1.048],[0.48838, 0.5125],'LineWidth',2)
% 1e-4: - res2:    line([3.9263,3.9263],[0.24309,0.2571],'LineWidth',2)
G1    = n1*n1*k*(k-1)*jres1^(k-2) 
DJmax1=2*n1*sqrt(2*v1/G1)
G2    = n2^2*k*(k-1)*jres2^(k-2) 
DJmax2=2*n2*sqrt(2*v2/G2)
%% POINCARE
i=0;
%col=['r','y','m', 'm','b'];
%col  =['r','b','g','r','b','g','r','g','b','r','b','g','r','b','g'];
col =['k','k','k','k','k','k','k','k','k','k','k'];
jmin =0.28;%0.15;
jmax = 0.5;%0.7;
figure(1); hold on; xlabel("\theta"), ylabel("J") ; xlim([0,2*pi]);ylim([jmin-0.05,jmax+0.05])
for theta0=[1.0:2:6]%[1.56 4.67 3.17 2.18 4.13]%theta0=[ 3*pi/2,pi/2, pi]%, 3*pi/2, 2*pi]
    i=i+1
    for J0 = [jmin:0.1:jmax]
        %for tf=[1e-6:T0:10*T0]
            [t,q]=ode45(@(t,y) dH(t,y,v1,v2,OMEGA,k,n1,m1,n2,m2)  ,[0:T0:1000*T0],[J0,theta0],options);
            plot(mod(q(:,2),2*pi), q(:,1), string(strcat(col(i),'.')), 'MarkerSize', 1);
    %[t,q]=ode45(@(t,y) dH(t,y,v1,v2,OMEGA,k,n1,m1,n2,m2)  ,[v1 T0-v1],[J0,theta0],options);
    %plot(mod(q(:,2),2*pi), q(:,1), '-', 'LineWidth', 0.2);%, 'MarkerSize', 2);
        %end
    end
end
%% CONCSTANT OF MOTION I
% t=T0; 
% [th,j] = meshgrid([0:0.005:2*pi],[-2:0.05:2]);
% COS =@(v,n,m,t,th,j) v*n*cos(n*th-m*OMEGA*t)./(m*OMEGA-n*(omega+k*j.^(k-1)));
% Is1 =@(t,th,j) ( (m1*OMEGA-n1*omega)*(m2*OMEGA-n2*omega)*j +(n1*(m2*OMEGA-n2*omega)+n2*(m1*OMEGA-n1*omega))*j.^k/k +n1*n2*k^2*j.^(2*k-1)/(2*k-1) );
% II  =@(t,th,j) Is1(t,th,j) -(m1*OMEGA-n1*(omega+k*j.^(k-1))).*(m2*OMEGA-n2*(omega+k*j.^(k-1))).*((COS(v1,n1,m1,t,th,j))+COS(v2,n2,m2,t,th,j));
% SIN =@(v,n,m,t,th,j,k,OMEGA) v*n*cos(n*th-m*OMEGA*t)./(m*OMEGA-n*(omega+k*j.^(k-1)));
% Is1 =@(t,th,j) ( (m1*OMEGA-n1*omega)*(m2*OMEGA-n2*omega)*j +(n1*(m2*OMEGA-n2*omega)+n2*(m1*OMEGA-n1*omega))*j.^k/k +n1*n2*k^2*j.^(2*k-1)/(2*k-1) );
% Is2 =@(t,th,j,n1,m1,n2,m2,k,omega,OMEGA) -(m1*OMEGA-n1*(omega+k*j.^(k-1))).*(m2*OMEGA-n2*(omega+k*j.^(k-1)));
% II  =@(t,th,j) Is1(t,th,j) + Is2(t,th,j,n1,m1,n2,m2,k,omega,OMEGA).*( SIN(v1,n1,m1,t,th,j,k,OMEGA)+SIN(v2,n2,m2,t,th,j,k,OMEGA) );
% figure(2)
% xlabel("\theta"),ylabel("J"),zlabel("I")  
% mesh(th,j,II(t,th,j))
% 
% figure(3)
% xlabel("\theta"),ylabel("J")
% contour(th,j,II(T0,th,j),60)%[0:0.1:10])
%% FUNCTIONs
function CanEq=dH(t,q,v1,v2,OMEGA,k,n1,m1,n2,m2)
    J =q(1,:); theta=q(2,:);
    CanEq = [2*v1*sin(n1*theta-m1*OMEGA*t)+v2*sin(n2*theta-m2*OMEGA*t);1+k*J^(k-1)];
end