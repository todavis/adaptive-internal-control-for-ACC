function [eta_k1, u_k1, theta_k1] = unkPureSinDist(eta_k, y_k, theta_k, distStruct)
%PURE SINE DISTURBANCE FEEDBACK COMPENSATOR WITH UNKNOWN FREQUENCY
%   Computes the k + 1 update step of the compensator based on the k_th 
%   values for pure sinusoidal disturbances with unknown frequency 
%   (Tomei17 Theorem 4.1)
%
%   PARAMETERS
%   ----------
%   eta_k:          (1 x 2) eta(k), current compensator step
%   y_k:            (int) y(k), current output
%   theta_k:        (1 x M) cos(frequency) estimate for M unknown freq's
%   distStruct:     (struct) disturbance information given to compensator
%
%   OUTPUT
%   ------
%   eta_k1:         (1 x P) eta(k + 1), next compensator step
%   u_k1:           (int) u(k + 1), next control input
%   theta_k1:       (1 x M) cos(frequency) estimate for M unknown freq

    if distStruct.caseA
        eta_k1(1) = eta_k(2) + distStruct.g * distStruct.Iw * y_k;
        eta_k1(2) = - eta_k(1) + 2 * theta_k * eta_k(2) + ...
                    2 * theta_k * distStruct.g * distStruct.Iw * y_k;
        theta_k1 = theta_k + distStruct.epsilon * distStruct.Iw * ...
                    eta_k(1) * y_k;          
        u_k1 = - eta_k1(1);
    
    elseif distStruct.caseB
        eta_k1(1) = eta_k(2) + distStruct.g * distStruct.Rw * theta_k * y_k;
        eta_k1(2) = - eta_k(1) + 2 * theta_k * eta_k(2) - ...
                    distStruct.g * distStruct.Rw * y_k;
        theta_k1 = theta_k + distStruct.epsilon * distStruct.Rw * ...
                    eta_k(1) * y_k;          
        u_k1 = - eta_k1(1) - distStruct.g * distStruct.Rw * y_k ;  
    end
end