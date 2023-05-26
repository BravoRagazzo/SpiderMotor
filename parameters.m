
%% Parameters
Ra = 1.203;                 % resistance
L = 0.005584;               % inductance
Ke = 0.08574;               % motor velocity constant
Kt =  1.2006 * Ke;          % torque constant
J1 = 0.000169992;           % motor inertia
fr = 0.000294;              % friction coefficient

%% Parameters uncertanties
w = [1 1]';                 % uncertanties vector        
Ts = 0.001;                 % sampling time
Bw_bar = [-0.0085 -0.0006;  % uncertanties matrix 
          -0.0603 0.0002];