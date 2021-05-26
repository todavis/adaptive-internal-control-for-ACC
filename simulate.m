function [x, y, compensator, theta] = simulate(sys, k_max, n, x_0, eta_0, theta_0, dist, distStruct, distFunc)
%SIMULATE
%   Simulate the time evolution of a discrete state space model with the
%   given initial conditions, disturbance, and disturbance rejection method
%   
%   PARAMETERS
%   ----------
%   sys:            Discrete-time state-space model
%   k_max:          (int) number of iterations to simulate
%   n:              (int) dimension of state
%   x_0:            (1 x n) initial condition of state
%   eta_0:          initial condition of compensation eta
%   theta_0:        initial condition
%   dist:           (k_max x 1) disturbance time array
%   distStruct:     (struct) disturbance information given to compensator
%   distFunc:       (function) rejection method (Tomei theorem)
%  
%   OUTPUTS
%   ------
%   x:              (k_max x n) state
%   y:              (k_max x 1) measurement/output 
%   compensator:    (k_max x 1) disturbance + control input
%   theta:          (k_max x M) cos(frequency) estimate for M unknown freq
    
    % initialize arrays for state, input, output, compensator
    x = zeros(k_max, n); x(1,:) = x_0;
    y = zeros(k_max, 1);
    u = zeros(k_max, 1);
    eta = zeros(k_max, distStruct.dim_eta); eta(1, :) = eta_0;
    theta = zeros(k_max, distStruct.dim_theta); theta(1, :) = theta_0;
    
    for k = 1:k_max - 1 

        x(k + 1,:) = sys.A * x(k,:)' + sys.B * (u(k) + dist(k));
        [eta(k + 1, :), u(k + 1), theta(k + 1, :)] = distFunc(eta(k, :), y(k), theta(k, :), distStruct);
        y(k + 1) = sys.C * x(k + 1,:)' + sys.D * (u(k + 1) + dist(k + 1));
        
    end
    
    compensator = u + dist;
    time = linspace(1, k_max, k_max);
    fig = plotTwoState(time, x, dist, u, func2str(distFunc));
    saveas(fig, "output/" + func2str(distFunc) + ".png"); 
end

