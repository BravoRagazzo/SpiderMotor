clc
clear
close all

%% Load parameters 
parameters
constraints

%% Model

A = [-Ra/L -Ke/L; Kt/J1 -fr/J1];
B = [1/L 0]';
C = eye(2);
D = [0 0]';

x0 = [0.2 70.3]';

sys = ss(A,B,C,D);

eig = eig(A);


%% LQR continuous
Q_LQ = eye(2);
R_LQ = 0.001;

[K, S, CLP] = lqr(A,B,Q_LQ,R_LQ);

%% LQR discrete

sysdis = c2d(sys,Ts);

[Kd, Sd, CLPd] = dlqr(sysdis.A,sysdis.B,Q_LQ,R_LQ);








