function u = motor_mpc_unconstrained(A,B,Q,R,S,u_max,u_min,N,x)
%% Compute calligraphic Q and R matrices            
Qsig = blkdiag(kron(eye(N-1),Q),S); 
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
H = Bsig'*Qsig*Bsig + Rsig;
F = Asig'*Qsig*Bsig;
f = F'*x;
%% Define input and status constraints 
lb = repmat(u_min,N,1);
ub = repmat(u_max,N,1);

%% Solve the opt problem using quadprog
options = optimset('Algorithm', 'interior-point-convex','Diagnostics','off',...
    'Display','off');

U = quadprog(H,f,[],[],[],[],lb,ub,[],options);

%% Apply receding horizon principle
u = U(1);
end