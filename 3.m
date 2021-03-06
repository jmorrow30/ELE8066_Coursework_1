clc
clear all
ts=10*10^(-6);
A=[[0 22727];[-2500 -1000]];
B=[[0 18181];[75000 -10^5]];
C=[1 0];
D=[0 0];
[num,den]=ss2tf(A,B,C,D,1);
t=0:0.000010:0.012;
u=0.5*(ones(length(t),1));
%u=t;
sys=tf(num,den)
y=lsim(sys,u,t);
plot(t,y)
title('y against t')
sys_d=c2d(sys,ts)
%y_ts=lsim(sys_d,u,t);
%plot(t,y_ts)
%title('y against t')

sys=tf(num,den)
sys_ss=ss(sys)
t=0:0.00001:10;
figure
step(sys_ss)

ts=10  %10us
N=0;
y=1;
y_=[];
x_=[];
while N<500
x=(N*ts);
y=(((eye(2))+A*ts)*x)+B*ts*0.5;
N=N+1;
y_norm=norm(y);
y_=[y_,y_norm];
x_=[x_,x];
end
figure
plot(y_,x_)
