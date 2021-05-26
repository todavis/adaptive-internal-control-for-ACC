clc; clear;

% Boolean for running each case
constantDistRun = 0;
pureSinRun = 0;
multiSinRun = 1;
unkPureSinRun = 0;
unkMultiSinRun = 1;

% Setup example matrices for 2 D case - second Tomei
A = [0.5 1; 0 0.5];
B = [0  1]';
C = [1  0];
D = 0;

x_0 = [0 0];
Ts  = 1;
n   = 2;

% Disturbance, will be used for each case
% define yr reference
Amp = [1/2 1/4 -1/2 -1/4];
phase = [0.3 0 0.3];
freq = [0.1 0.2 0.3];
q = 3;

% Constant disturbance
% define gain, g, and dimension of estimators
constantDistStruct.g = 0.001; % bounded by g*
constantDistStruct.dim_eta = 1;
constantDistStruct.dim_theta = 1;

% Pure sinusoidal disturbance
% d(k) = A1 * sin(k * w + phi)
pureSinStruct.g = 0.00004; % bounded by g*
pureSinStruct.freq = freq(1);

pureSinStruct.dim_eta = 2;
pureSinStruct.dim_theta = 1;
pureSinStruct.eta_0 = [0 0];

% Biased multisinusoidal disturbance
% d(k) = A0 + sum( Aisin(wi * k + phi) ) // for 1 to q
multiSinStruct.g = 0.001; % bounded by g*
multiSinStruct.freq = freq;

multiSinStruct.dim_eta = 1 + 2 * q;
multiSinStruct.dim_theta = 1 + 2 * q;
multiSinStruct.eta_0 = zeros(1, 1 + 2 * q);

% Sinusoidal Disturbance with Unknown Frequency
% d(k) = A1 * sin(k * w + phi)
unkPureSinStruct.g = 5e-4; % bounded by g*
unkPureSinStruct.epsilon = 1e-5; % bounded by eps*

unkPureSinStruct.dim_eta = 2;
unkPureSinStruct.dim_theta = 1;
unkPureSinStruct.eta_0 = [0, 0];
unkPureSinStruct.theta_0 = cos(0.11);

% Biased Multi-Sinusoidal Disturbance with Unknown Frequencies
% CASE A (-ve imag signs)
unkMultiSinStruct.g = 1e-3; % bounded by g*
unkMultiSinStruct.epsilon = 4e-4; % bounded by eps*

unkMultiSinStruct.freq = freq;
unkMultiSinStruct.dim_eta = 1 + 2 * q;
unkMultiSinStruct.dim_theta = q;
unkMultiSinStruct.eta_0 = zeros(1, 1 + 2 * q);
unkMultiSinStruct.theta_0 = [cos(0.11) cos(0.23) cos(0.33)];

% define matching disturbance
temp = [-1 2*0.5 -0.5^2];
Amp = [sum(Amp(1) * temp),-Amp(2:end) 2*0.5*Amp(2:end), - 0.5^2*Amp(2:end)];
phase = [phase + 2*freq phase + freq phase];
freq = [freq freq freq];

save("input/input")