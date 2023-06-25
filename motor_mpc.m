function u = motor_mpc(A,B,Q,R,S,u_max,u_min,x_max,x_min,yref,N,x)
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

x_ub = [x_max(1);x_max(2)];
x_lb = [x_min(1);x_min(2)];
X_M = repmat(x_ub-yref,N,1);
X_m = repmat(x_lb-yref,N,1);

A_constr = [Bsig; -Bsig];
b_constr = [(X_M - Asig*x); -(X_m - Asig*x)];

%% Define input and status constraints 
lb = repmat(u_min,N,1);
ub = repmat(u_max,N,1);

%% Solve the opt problem using quadprog
options = optimset('Algorithm', 'interior-point-convex','Diagnostics','off',...
    'Display','off');

U = quadprog(H,f,A_constr,b_constr,[],[],lb,ub,[],options);
if isempty(U)
    disp("Unconstrained")
    U = quadprog(H,f, [],[],[],[],lb,ub,[],options);
else disp("Constrained")
end
%% Apply receding horizon principle
u = U(1);
end