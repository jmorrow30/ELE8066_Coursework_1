clc
clear
r = 1; % initializations
L = 1;
perturbation=1*rand(1,2);
%X = [1 0]+perturbation;
X=[2000 40]+perturbation;
x_eq=[[20];[0.4]];
u_eq=[[0.672];[0.5]];
U = [];
Z = [];
Time = [0];
u=[0.97478];
tinterval=5;

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

dxdt=zeros(2,1);
%dxdt(1) = 0.5*(x(2)+sin(x(2)));
%dxdt(2) = 8*(1-x(1))*x(1)-6*x(2)+0.804*u-exp(-0.25*u);

dxdt(1) = u*(x(1))/(22)+((0.2)/(22));
dxdt(2) = (((-u*x(1))/(200))+((-0.2*x(2))/(200)))+((15*u)/(200));

end
