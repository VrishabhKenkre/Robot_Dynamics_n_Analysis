function [qn,dqn,lambda] = solveEOM2(q,dq,h)

syms xn yn dxn dyn real
syms lambda_1 lambda_2 real

qn = [xn;yn];
dqn = [dxn;dyn];
lambda = [lambda_1;lambda_2];

M = eye(2);
N = [0.0;9.8];
upsilon = [0.0;0.0];
C = zeros(2);
a = compute_a(qn);
A = computeA(qn);

eq1 = M*(dqn-dq) + h*(C*dq + N - upsilon) + A'*lambda;
eq2 = (qn-q) -h*dqn;
eq3 = a.*lambda;

in1 = a>=0;
in2 = lambda<=0;

eqs = [eq1;eq2;eq3;in1;in2];
vars = [qn;dqn;lambda];

sol = solve(eqs,vars);

qn = double([sol.xn(1);sol.yn(1)]);
dqn = double([sol.dxn(1);sol.dyn(1)]);
lambda = double([sol.lambda_1;sol.lambda_2]);


