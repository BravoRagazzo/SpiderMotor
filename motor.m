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

sys = ss(A,B,C,D);

eig(A)

%%