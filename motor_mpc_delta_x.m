function u = motor_mpc_delta_x(A,B,Q,R,S,u_max,u_min,N,x,yref)
%% Compute calligraphic Q and R matrices            
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
F = Asig'*Qsig*Bsig;
f = F'*x;

constr = [2;150] - yref;
X_M = repmat(constr,N,1);
X_m = -X_M;

A_constr = [Bsig; -Bsig];
b_constr = [(X_M - Asig*x); -(X_m - Asig*x)];

%% Define input and status constraints 
lb = repmat(u_min,N,1);
ub = repmat(u_max,N,1);

%% Solve the opt problem using quadprog
options = optimset('Algorithm', 'interior-point-convex','Diagnostics','off',...
    'Display','off');


[U,FVAL,EXITFLAG] = quadprog(H,f,A_constr,b_constr,[],[],lb,ub,[],options);

[Ucon,FVAL,EXITFLAG] = quadprog(H,f,[],[],[],[],lb,ub,[],options);

var = Bsig*(U) + Asig*x;
ubvero=max(var(1:2:end));
if (ubvero-2) > 0.001
    keyboard
end

varcon = Bsig*(Ucon) + Asig*x;
ubvero=max(varcon(1:2:end));
if (ubvero-2) > 0.001
   %keyboard
end

%% Apply receding horizon principle
u = U(1);
end