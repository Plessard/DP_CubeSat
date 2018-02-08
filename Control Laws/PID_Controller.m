clear all;
clc

syms s;

% G=1/(s^2+3s+1)

num=1;
den=sym2poly(s^2+3*s+1);

G=tf(num,den);

H=1;

Kp=140;
Ki=100;
Kd=35;
Tf=0;
Ts=0;

C=pid(Kp,Ki,Kd,Tf,Ts);

T=feedback(C*G,H);

step(T);

