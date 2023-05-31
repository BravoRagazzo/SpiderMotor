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
Q_LQ = [1 0; 0 1];
%Q_LQ = 100*eye(2);
R_LQ = 1;

[K, S, CLP] = lqr(sys,Q_LQ,R_LQ);

%% LQR discrete

sysdis = c2d(sys,Ts);

B_tilda = [sysdis.B(1) Bw_bar(1,1) Bw_bar(1,2); sysdis.B(2) Bw_bar(2,1) Bw_bar(2,2)];
D_tilda = [0 0 0 ; 0 0 0];


Q_LQ = [1 0;0 1];
R_LQ = 1;

[Kd, Sd, CLPd] = dlqr(sysdis.A,sysdis.B,Q_LQ,R_LQ);



%% Computing uBar and yBar
nref = 100;

uBar = -(A(1,1)*(-A(2,2)*nref/A(2,1)) + A(1,2)*nref)*L;
iref = -A(2,2)*nref/A(2,1);

yref = [iref nref]';

%% Unconstrained MPC

N = 10;


