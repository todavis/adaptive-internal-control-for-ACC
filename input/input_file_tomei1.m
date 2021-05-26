clc; clear;

% Boolean for running each case
constantDistRun = 1;
pureSinRun = 1;
multiSinRun = 1;
unkPureSinRun = 1;
unkMultiSinRun = 1;

% Setup example matrices for 2 D case - first example from Tomei17
A = [0.6 1; -0.05 0];
B = [1  1]';
C = [1  0];
D = 0;

x_0 = [0 0];
Ts  = 1;
n   = 2;

% Disturbance, will be used for each case

Amp = [0 1];
phase = [0];
freq = [0.1];
q = 1;

% Constant disturbance
%   d(k) = A1
constantDistStruct.g = 0.001; % bounded by g*
constantDistStruct.dim_eta = 1;
constantDistStruct.dim_theta = 1;

% Pure sinusoidal disturbance
%   d(k) = A1 * sin(k * w + phi)
pureSinStruct.g = 0.001; % bounded by g*
pureSinStruct.freq = freq(1);

pureSinStruct.dim_eta = 2;
pureSinStruct.dim_theta = 1;
pureSinStruct.eta_0 = [0 0];

% Biased multisinusoidal disturbance
%   d(k) = A0 + sum( Aisin(wi * k + phi) ) // for 1 to q
% CASE A
multiSinStruct.g = 0.001;

% CASE B
%multiSinStruct.g = 0.0004;

multiSinStruct.freq = freq;

multiSinStruct.dim_eta = 1 + 2 * q;
multiSinStruct.dim_theta = 1 + 2 * q;
multiSinStruct.eta_0 = zeros(1, 1 + 2 * q);

% Sinusoidal Disturbance with Unknown Frequency
%   d(k) = A1 * sin(k * w + phi)
% CASE A
unkPureSinStruct.g = 1e-3; % bounded by g*
unkPureSinStruct.epsilon = 1e-6; % bounded by eps*

unkPureSinStruct.freq = freq;
unkPureSinStruct.dim_eta = 2;
unkPureSinStruct.dim_theta = 1;
unkPureSinStruct.eta_0 = [0, 0];
unkPureSinStruct.theta_0 = cos(0.11);

% Biased Multi-Sinusoidal Disturbance with Unknown Frequencie
% CASE A
unkMultiSinStruct.g = 1e-3; % bounded by g*
unkMultiSinStruct.epsilon = 1e-6; % bounded by eps*

unkMultiSinStruct.freq = freq;
unkMultiSinStruct.dim_eta = 1 + 2 * q;
unkMultiSinStruct.dim_theta = q;
unkMultiSinStruct.eta_0 = zeros(1, 1 + 2 * q);
unkMultiSinStruct.theta_0 = [cos(0.11)]; %cos(0.21)]; % cos(0.27)];

save("input/input")