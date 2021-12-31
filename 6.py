A=[[0 22700];[-2500 -1000]];
B=[[0 18181];[75 -10^5]];
P=[-2064+1000j -2064-1000j];
K=place(A,B,P);
Kz=K;
C=[1 0];
D=[0 0];
x_eq=[[20];[0.4]];
u_eq=[[0.672];[0.5]];
t=0:0.00001:0.02;
u_loop=0;
u1=0.672*(ones(length(t),1));
u2=0.5*(ones(length(t),1));
L=[4162;-2389];
while u_loop<3

if u_loop<1
    u=u1;
end
if u_loop>0
    u=u2;
    figure
end
u_loop=u_loop+1;
a_A_new=[[-1818.1 -935.3];[-352.5 -2422.5]];
b_A_new=[[1818.1 23635];[-2147 1422]];
c_A_new=[[0 0];[0 0]];
d_A_new=[[-4162 22727];[-111 -1000]];
A_new=[[a_A_new b_A_new];[c_A_new d_A_new]];    %A_new is for closed loop
B_new=[B;zeros(size(B))];
C_new=[C zeros(size(C))];
[num,den]=ss2tf(A_new,B_new,C_new,D,1);
sys2=tf(num,den);
sys_ss2=ss(sys2);
y2=lsim(sys2,u,t);

plot(t,y2)
xlabel('Time (seconds)')
ylabel('Amplitude')
if u==0.672
    title('y against t for u = u1 = 0.672')
end
if u==0.5
    title('y against t for u = u2 = 0.5')
end

figure
step(sys_ss2);
if u==0.672
    title('Step response for u = u1 = 0.672')
    legend('Closed loop for u1=0.672')
end
if u==0.5
    title('Step response for u = u2 = 0.5')
    legend('Closed loop for u2=0.5')
end

u_loop=u_loop+1;

end
