A=[[0 22700];[-2500 -1000]];
B=[[0 18181];[75 -10^5]];
P=[-2064+1000j -2064-1000j];
K=place(A,B,P);
C=[1 0];
D=[0 0];
x_eq=[[20];[0.4]];
u_eq=[[0.672];[0.5]];
[num,den]=ss2tf(A,B,C,D,1);
sys1=tf(num,den);
t=0:0.00001:0.02;
length(t);
u=0.5*(ones(length(t),1));
sys_ss1=ss(sys1);
y1=lsim(sys1,u,t);


figure
A_new=[[-1818.1 -935.3];[-352.5 -2422.5]];
[num,den]=ss2tf(A_new,B,C,D,1);
sys2=tf(num,den);
sys_ss2=ss(sys2);
y2=lsim(sys,u,t);

plot(t,y1,t,y2)
legend('Open loop','Closed loop')
xlabel('Time (seconds)')
ylabel('Amplitude')

figure
step(sys_ss1,sys_ss2)
legend('Open loop','Closed loop')
