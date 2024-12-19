close all;clear;clc;

% Arm parameters
L = 1;
m = 1;
I = 1/12;

% Traj Opt parameters
dt = 0.02;
tspan = 0:dt:1.5;
N = length(tspan);
options = optimoptions('fmincon','Display', 'iter', 'MaxFunctionEvaluations', 1e5);
x0 = zeros(N,6); % % Initial condition [q1,q2,dq1,dq2,tau1,tau2]

% [M,C,N,Y] = computeDynamicsMatrices(q,dq,tau);

%%%%%%% SETUP AND SOLVE TRAJECTORY OPTIMIZATION HERE %%%%%%%%%
fun = @MinTorque;
%x0 = [-1,2];
A = []; %Used in constraints
b = []; %Used in constraints
Aeq = [];%Used in constraints
beq = [];%Used in constraints
lb = []; %Not for 1.2 % Also Used in constraints
ub = []; %Not for 1.2 % Also Used in constraints
[sol, cost] = fmincon(@MinTorque,x0,[],[],[],[],[],[],@nonlcon,options); 

x = sol(:,1:4); % For q and dq

% X should be of size Nx2 where each column is q1,q2 at that time index
animate13(x,dt);