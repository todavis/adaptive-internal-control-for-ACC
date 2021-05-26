%% Implementation of discrete feedback compensators from Tomei17
%
% Definition 1.1 (Disturbance Rejection Problem). Consider the linear system
%       x(k + 1) = Ax(k) + B[u(k) + d(k)], x(0) = x0
%           y(k) = Cx(k) + D[u(k) + d(k)]
%
%       A is n x n, B is n x 1
%       C is 1 x n, D is 1 x 1
%
% - show that the state vector x(k) and the disturbance compensator error  
%   u(k) + d(k) converge exponentially to zero as k tends to infinity, for 
%   any initial condition (x0, eta0). for the close looped system

%% Define example system

clear; close all; clc

% Load input file for model and disturbance settings
load("input/input.mat")

% Create state space model and transfer function
SYS = ss(A, B, C, D, Ts);
P = tf(SYS);
P_zpk = zpk(P);
[Z, gain] = zero(P);

%% Constant disturbances (Theorem 2.1)
% d(k) = d_0

if constantDistRun
    
    % Simulate model for k_max iterations
    k_max = 1000;
    constant_dist_arr = Amp(1) * ones(k_max, 1);

    constantDistStruct.g = 0.1;
    constantDistStruct.sign_gain = sign(gain);
    
    [x, y, ud, theta] = simulate(SYS, k_max, n, x_0, 0, 0, ...
                                 constant_dist_arr, constantDistStruct, ...
                                 @constantDist);
end

%% Pure Sinusoidal Disturbance (Theorem 2.2)
% d(k) = A * sin(k * w + phi)

if pureSinRun

    % Simulate model for k_max iterations
    k_max = 1000;
    time = linspace(1, k_max, k_max);
    pure_sin_dist = Amp(2) * sin(time * freq(1) + phase(1));

    % establish disturbance structure
    z_bar = exp(pureSinStruct.freq(1) * 1i);
    P_at_zbar = evalfr(P, z_bar);
    
    pureSinStruct.caseA = (imag(P_at_zbar) ~= 0);
    pureSinStruct.caseB = (real(P_at_zbar) ~= 0);

    pureSinStruct.Iw = sign(imag(P_at_zbar));
    pureSinStruct.Rw = sign(real(P_at_zbar));

    [x, y, ud, theta] = simulate(SYS, k_max, n, x_0, pureSinStruct.eta_0, 0, ...
                                 pure_sin_dist', pureSinStruct, ...
                                 @pureSinDist);
end
                  
%% Biased multi-frequency disturbances (Theorem 3.1)

if multiSinRun

    % Simulate model for k_max iterations
    k_max = 1000;
    time = linspace(1, k_max, k_max)';
    multi_sin_dist = Amp(1) + sum(Amp(2:end) .* sin(freq .* repmat(time, 1, size(freq, 2)) + phase), 2);

    % establish disturbance structure
    z_bar = exp(multiSinStruct.freq * 1i);
    P_at_zbar = squeeze(freqresp(P, z_bar)).';
    
    multiSinStruct.caseA = (sum(imag(P_at_zbar) == 0) == 0); % not 0 for all i
    multiSinStruct.caseB = (sum(real(P_at_zbar) == 0) == 0); % not 0 for all i

    multiSinStruct.Iw = sign(imag(P_at_zbar));
    multiSinStruct.Rw = sign(real(P_at_zbar));
    multiSinStruct.R0 = sign(gain);

    [x, y, ud, theta] = simulate(SYS, k_max, n, x_0, multiSinStruct.eta_0, 0, ...
                                 multi_sin_dist, multiSinStruct, ...
                                 @multiSinDist);
end

%% Sinusoidal Disturbance with Unknown Frequency (Theorem 4.1)
% d(k) = A1 * sin(k * w + phi)

if unkPureSinRun

    % Simulate model for k_max iterations
    k_max = 2000;
    time = linspace(1, k_max, k_max);
    pure_sin_dist = Amp(2) * sin(time * freq(1) + phase(1));

    % establish disturbance structure - frequency is not passed
    z_bar = exp(unkPureSinStruct.freq(1) * 1i);
    P_at_zbar = evalfr(P, z_bar);

    unkPureSinStruct.caseA = (imag(P_at_zbar) ~= 0);
    unkPureSinStruct.caseB = (real(P_at_zbar) ~= 0);

    unkPureSinStruct.Iw = sign(imag(P_at_zbar));
    unkPureSinStruct.Rw = sign(real(P_at_zbar));

    [x, y, ud, theta] = simulate(SYS, k_max, n, x_0, ...
                                 unkPureSinStruct.eta_0, unkPureSinStruct.theta_0, ...
                                 pure_sin_dist', unkPureSinStruct, ...
                                 @unkPureSinDist);
                             
    fig = plotFrequencyEstimate(time, theta, unkPureSinStruct.freq(1), k_max);
    saveas(fig, "output/pureSinEstimate.png"); 
    
end
%% Biased Multi-Sinusoidal Disturbance with Unknown Frequencies (Theorem 4.2)

if unkMultiSinRun
    % disturbance
    
    % Simulate model for k_max iterations
    k_max = 10000;
    time = linspace(1, k_max, k_max)';

    multi_sin_dist = Amp(1) + sum(Amp(2:end) .* sin(freq .* repmat(time, 1, size(freq, 2)) + phase), 2);
    
    % establish disturbance structure
    z_bar = exp(unkMultiSinStruct.freq * 1i);
    P_at_zbar = squeeze(freqresp(P, z_bar)).';
    
    unkMultiSinStruct.caseA = (sum(imag(P_at_zbar) == 0) == 0); % not 0 for all i
    unkMultiSinStruct.caseB = (sum(real(P_at_zbar) == 0) == 0);

    unkMultiSinStruct.Iw = sign(imag(P_at_zbar));
    unkMultiSinStruct.Rw = sign(real(P_at_zbar));
    unkMultiSinStruct.R0 = sign(gain);

    [x, y, ud, theta] = simulate(SYS, k_max, n, x_0, ...
                                 unkMultiSinStruct.eta_0, unkMultiSinStruct.theta_0, ...
                                 multi_sin_dist, unkMultiSinStruct, ...
                                 @unkMultiSinDist);

    fig = plotFrequencyEstimate(time, theta, unkMultiSinStruct.freq, k_max);
    saveas(fig, "output/multiSinEstimate.png"); 
end


 
