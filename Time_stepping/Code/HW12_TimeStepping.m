clear;clc;close all;
%% Initialization

% Define start and stop times, set an h to keep outputs at constant time
% interval. You should only change h for different requirements.
t = 0;
tfinal = 3;
h = 0.02; % seconds
tspan = t:h:tfinal;

% Initialize state and contact mode
q = [0.2;1];
dq = [0;0];

% Initialize arrays for logging data
xout = []; % collection of state vectors at each time
lambdaout = []; % collection of contact forces at each time

% Initialize contact mode
oldContactMode = zeros(0,1);
disp(['Initialize in mode {', num2str(oldContactMode'), '}.']);
%% Main Loop

for i =  1:length(tspan)

    % Solve for new state and contact forces
    % Your code here
    [qn,dqn,lambda] = solveEOM2(q,dq,h);
    
    % Log state and contact forces
    % Your code here
    xout = [xout; qn' dqn'];
    lambdaout = [lambdaout; lambda'];
    
    % Check new contact mode and determine if there has been a transition
    % Your code here, and display the following message when appropriate
    contactMode = find([(-lambda(1)>0);(-lambda(2)>0)]);
    if(~isequal(contactMode,oldContactMode))
        transition = {oldContactMode,contactMode};
        disp(['Transition from mode {', num2str(oldContactMode'), '} to mode {', num2str(contactMode'), '} at t = ', num2str(tspan(i+1)), '.']);
    end
    % Reset data
    % Your code here
    oldContactMode = contactMode;
    q = qn;
    dq = dqn;
end

disp(['Terminate in mode {', num2str(oldContactMode'), '} at t = ', num2str(tfinal), '.']);

% This function shows animation for the simulation, don't modify it
animateHW12(xout, h);
figure
plot(tspan, -lambdaout);
xlabel('t (s)')
ylabel('U(\lambda)')
legend('U(\lambda_1)','U(\lambda_2)',  'location', 'northeast')
