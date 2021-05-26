function [eta_k1, u_k1, theta_k1] = constantDist(eta_k, y_k, theta_k, distStruct)
%CONSTANT DISTURBANCE FEEDBACK COMPENSATOR
%   Computes the k + 1 update step of the compensator based on the k_th 
%   values for constant disturbances 
%   (Tomei17 Theorem 2.1)
%
%   PARAMETERS
%   ----------
%   eta_k:          (1 x 1) eta(k), current compensator step
%   y_k:            (int) y(k), current output
%   theta_k:        (1 x M) cos(frequency) estimate for M unknown freq
%   distStruct:     (struct) disturbance information given to compensator
%
%   OUTPUT
%   ------
%   eta_k1:         (1 x P) eta(k + 1), next compensator step
%   u_k1:           (int) u(k + 1), next control input
%   theta_k1:       (1 x M) cos(frequency) estimate for M unknown freq,
%                   unused

    eta_k1 = eta_k + distStruct.g * distStruct.sign_gain * y_k;
    u_k1 = - eta_k1;
    theta_k1 = theta_k;
end

