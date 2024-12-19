function [c,ceq] = nonlcon(x)

%Getting the variable values
q = x(:,1:2);
dq = x(:,3:4);
tau = x(:,5:6);

q1 = q(:,1);
q2 = q(:,2);
dq1 = dq(:,1);
dq2 = dq(:,2);
tau1 = tau(:,1);
tau2 = tau(:,2);

N = size(x,1);

%Constraints
L = 1;
dt = 0.02;

q0 = [-pi/2,0];
qf = [pi/2,0];
dq0 = [0,0];
dqf = [0,0];
qmax = 3*pi/4;
qmin = -qmax;

%Boundary Conditions
%boundmatrix = vertcat(q(1,:)'-q0, dq(1,:)' - dq0,q(end,:)'-qf, dq(end,:)' - dqf);
boundmatrix = [
    q(1,:)' - q0';    % Initial position constraint
    dq(1,:)' - dq0';  % Initial velocity constraint
    q(end,:)' - qf';  % Final position constraint
    dq(end,:)' - dqf' % Final velocity constraint
];                  

%Accelaration Dynamics
ddq = [];
for i = 1:length(x)
    [Mbar,Cbar,Nbar,Y] = computeDynamicMatrices(q(i,:)',dq(i,:)',tau(i,:)'); 
    ddq(i,:) = (Mbar\(Y-Cbar*dq(i,:)'-Nbar))';
    jointLimits(i,:) = [q1(i) - qmax, -q1(i) + qmin, q2(i) - qmax, -q2(i) + qmin];
end


% %Collocation Constraints
firstorderCollocation = zeros(N-1,2);
secondOrderCollocation = zeros(N-1,2);

for i = 1:length(x)-1
    firstorderCollocation(i,:) = 0.5*dt*( dq(i+1,:)+dq(i,:) )-( q(i+1,:)-q(i,:) );
    secondOrderCollocation(i,:) = 0.5*dt*( ddq(i+1,:)+ddq(i,:) )-( dq(i+1,:)-dq(i,:) );
end

ceq = [boundmatrix;firstorderCollocation(:);secondOrderCollocation(:)];
%c = [jointLimits];
c = [];

end










