clc
clear
r = 1; % initializations
L = 1;
perturbation=1*rand(1,2);
X = [1 0]+perturbation;
U = [];
Z = [];
Time = [0];
u=[0.5];
u1 = [0.672];
u2 = 0.5;
L = 200*10^-6;    %200μH
R = [0.2];    %RL=0.2Ω
vs = [15];    %15V
c = [22*10^-6];        %C=22μF
I_load = [0.2];       %Iload=0.2A
tinterval=1;

%the equilibrium point is [1;0], and with input ueq=0.97478

hold on
for i=1:length(u)
    tspan = tinterval*[(i-1) i];
    x0 = X(end,:);
    [t,x]=ode45(@(t,x) nonlinear_example(t,x,u(i)),tspan,x0);
    X=[X;x];
    U=[U; u(i)*ones(length(t),1)];
    Time=[Time;t];
end
% plot(Time,X(:,1),'LineWidth',2) %visualization
% plot(Time,X(:,2),'LineWidth',2)
% legend('x_1', 'x_2', 'x_3')
% xlabel('time(sec)')
% grid on
% box on
% figure
% plot(X(:,1),X(:,2),'-k','LineWidth',2)
% hold on
% xlabel('x_1')
% ylabel('x_2')
% box on
% 
Y=sin(X(:,1));



%linearized - system
A=[0 1;-8 -6];
B=[0;1];
C=[0.5403 0];
D=[0];

sys=ss(A,B,C,D)

N=100;
tgrid=linspace(0,5,N)

[ylin,tlin,xlin]=lsim(sys,0*tgrid,tgrid,perturbation')

y_eq=0.84147
ylin=ylin+y_eq
 
%figure
plot(Y,'LineWidth',2)
hold on
plot(ylin,'LineWidth',2)
title('nonlinear vs linearized output time response')

figure
hold on
plot(Time,X(:,1),'LineWidth',2) %visualization
plot(tlin,xlin(:,1)+1,'LineWidth',2)
title('nonlinear vs linearized state 1 response')

figure
hold on
plot(Time,X(:,2),'LineWidth',2) %visualization
plot(tlin,xlin(:,2),'LineWidth',2)
title('nonlinear vs liearized state 2 response')




function dxdt = nonlinear_example(~,x,u)

%dxdt=[0 (u2/c);(-u2/L) (-R/L)]*[x1;x2]+[0 0;(vs/L) 0]*[u1;u2]+[(-I_load/c);0]
dxdt=zeros(2,1);
%dxdt(1) = ((u2*x1)/c)+((I_load)/c);
%dxdt(2) = (((-u2*x1)/L)+((-R*x2)/L))+((vs*u1)/L);
dxdt(1) = ((0.5*x(1))/(22*10^-6))+((0.2)/(22*10^-6));
dxdt(2) = (((-0.5*x(1))/(200*10^-6))+((-0.2*x(2))/(200*10^-6)))+((15*0.672)/(200*10^-6));

end


%u1 = [0.672];
%u2 = 0.5;
%L = 200*10^-6;    %200μH
%R = [0.2];    %RL=0.2Ω
%vs = [15];    %15V
%c = [22*10^-6];        %C=22μF
%I_load = [0.2];       %Iload=0.2A
