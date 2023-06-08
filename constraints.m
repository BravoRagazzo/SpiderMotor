
%% State constraint
% i [-2;2] A
x1_max = 2;     
x1_min = -2;

% n [-150; 150] rad/s
x2_max = 150;
x2_min = -150;

x_max = [x1_max;x2_max];
x_min = [x1_min;x2_min];

%% Control contraints
% v [0;12] V
u_max = 12;
u_min = 0;