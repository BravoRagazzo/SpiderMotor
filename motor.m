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
%% LQR continuous
Q_LQ = eye(2);
R_LQ = 1;

[K, S, CLP] = lqr(sys,Q_LQ,R_LQ);

%% LQR discrete

sysdis = c2d(sys,Ts);

B_tilda = [sysdis.B(1) Bw_bar(1,1) Bw_bar(1,2); sysdis.B(2) Bw_bar(2,1) Bw_bar(2,2)];
D_tilda = [0 0 0 ; 0 0 0];


Q_LQ = eye(2);
R_LQ = 1;
Q_LQ1 = 10*eye(2);
R_LQ1 = 1;
Q_LQ2 = 1000*eye(2);
R_LQ2 = 1;
Q_LQ3 = eye(2);
R_LQ3 = 100;

[Kd, Sd, CLPd] = dlqr(sysdis.A,sysdis.B,Q_LQ,R_LQ);
[Kd1, Sd1, CLPd1] = dlqr(sysdis.A,sysdis.B,Q_LQ1,R_LQ1);
[Kd2, Sd2, CLPd2] = dlqr(sysdis.A,sysdis.B,Q_LQ2,R_LQ2);
[Kd3, Sd3, CLPd3] = dlqr(sysdis.A,sysdis.B,Q_LQ3,R_LQ3);

%% Computing uBar and yBar
nref = 100;

uBar = -(A(1,1)*(-A(2,2)*nref/A(2,1)) + A(1,2)*nref)*L;
iref = -A(2,2)*nref/A(2,1);

yref = [iref nref]';

%% Unconstrained MPC

N = 10;

%% change prediction horizon N
N1 = 5;
Q1 = Q_LQ; %optimal Q
R1 = R_LQ;
S1 = Sd; 

N2 = 100;
Q2 = Q_LQ; %optimal Q
R2 = R_LQ
S2 = Sd;

% using the final weight equal to infinite horizon Riccati matrix the
% prediction horizon does not affect the performance

%% change prediction horizon N without LQ final weight
N1 = 5;
S1 = Q_LQ;

N2 = 100;
S2 = Q_LQ;


%% 
N1=5;
S1=zeros(2);

N2=100;
S2=zeros(2); 

%% state constraints

N = 10;
