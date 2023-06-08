% Constrained Model Predictive Control Function
% A: A matrix of the linear considered dynamic system
% B: B matrix of the linear considered dynamic system
% Q: status weight into the MPC cost function
% R: inputs weight into the MPC cost function
% S: final state weight (prediction horizon instant time) into the MPC cost function
% N: prediction horizon
% umin: inputs lower limit (scalar)
% umax: inputs upper limit (scalar)
% X: measured status at the current instant time
function u = motor_mpc(A,B,Q,R,S,u_max,u_min,N,x,uBar)

%% Compute calligraphic Q and R matrices 
%prediction horizon                    
Qsig = blkdiag(kron(eye(N-1),Q),S); % Q matrix for Open-Loop MPC (with Q)
Rsig = kron(eye(N),R);

%% Compute calligraphic A and B matrices 
Asig = A;
for i = 2:N
    Asig = [Asig; A^i];
end

% B matrix
Bsig = [];
temp = [];
for i = 1:N
    temp = zeros(size(B,1)*(i-1),1);
    for j = 0:N-i
        temp = [temp; A^(j)*B];
    end
    Bsig = [Bsig temp];
end

%% Compute H, F and derive f
    % H, F and S matrices (with Q)
H = Bsig'*Qsig*Bsig + Rsig;
M = Asig'*Qsig*Asig;
F = Asig'*Qsig*Bsig;
f = F'*x;

X_M = [];
for i=1:N
    X_M = [X_M;2;150];
end

X_m = -X_M;
A_constr = [Bsig; -Bsig];
b_constr = [(X_M - Asig*x - Bsig*repmat(uBar,N,1)) ; -(X_m - Asig*x - Bsig*repmat(uBar,N,1))];

%% Define input and status constraints 

lb = repmat(u_min-uBar,N,1);
ub = repmat(u_max-uBar,N,1);

%% Solve the opt problem using quadprog
options = optimset('Algorithm', 'interior-point-convex','Diagnostics','on', ...
        'Display','on');
[U,FVAL,EXITFLAG] = quadprog(H,f, A_constr,b_constr,[],[],lb,ub,[],options);
% U=[];
    [Ucon,FVAL,EXITFLAG] = quadprog(H,f, [],[],[],[],lb,ub,[],options);
if isempty(U)
    [U,FVAL,EXITFLAG] = quadprog(H,f, [],[],[],[],lb,ub,[],options);
end
var = Bsig*(U+uBar) + Asig*x;
ubvero=max(var(1:2:end));
if ubvero-2 >0.01
    keyboard
end

varcon = Bsig*(Ucon+uBar) + Asig*x;
ubvero=max(varcon(1:2:end));
if ubvero-2 >0.01
   % keyboard
end

%% Apply receding horizon principle
u = U(1);
end