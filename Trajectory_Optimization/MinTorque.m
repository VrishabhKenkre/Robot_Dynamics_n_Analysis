function cost = MinTorque(x)
    % Extract torques from decision variables
    tau = x(:, 5:6); % Columns 5 and 6 are torques
    % Initialize the objective value
    cost = 0;
    dt = 0.02;
    % Apply trapezoidal rule for integration using tau and tau transpose
    for i = 1:length(x)-1
        % Sum the squared torques at current and next timestep
        cost = cost + (dt / 2) * (tau(i, :)*tau(i,:)' + tau(i+1,:)*tau(i+1,:)');
    end
end
