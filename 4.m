A=[[0 22700];[-2500 -1000]];
B=[[0 18181];[75 -10^5]];
P=[-2064+1000j -2064-1000j];
K=place(A,B,P);
C=[1 0];
D=[0 0];
x_eq=[[20];[0.4]];
u_eq=[[0.672];[0.5]];
t=0:0.00001:0.02;
u_loop=0;
u1=0.672*(ones(length(t),1));
u2=0.5*(ones(length(t),1));

while u_loop<3

if u_loop<1
    u=u1;
end
if u_loop>0
    u=u2;
    figure
end
[num,den]=ss2tf(A,B,C,D,1);
sys1=tf(num,den);
sys_ss1=ss(sys1);

y1=lsim(sys1,u,t);
u_loop=u_loop+1;
A_new=[[-1818.1 -935.3];[-352.5 -2422.5]];    %A_new is for closed loop
[num,den]=ss2tf(A_new,B,C,D,1);
sys2=tf(num,den);
sys_ss2=ss(sys2);
y2=lsim(sys2,u,t);

plot(t,y1,t,y2)
legend('Open loop','Closed loop')
xlabel('Time (seconds)')
ylabel('Amplitude')
if u==0.672
    title('y against t for u = u1 = 0.672')
end
if u==0.5
    title('y against t for u = u2 = 0.5')
end

figure
step(sys_ss1,sys_ss2);
if u==0.672
    title('Step response for u = u1 = 0.672')
    legend('Open loop for u1=0.672','Closed loop for u1=0.672')
end
if u==0.5
    title('Step response for u = u2 = 0.5')
    legend('Open loop for u2=0.5','Closed loop for u2=0.5')
end

u_loop=u_loop+1;

end
