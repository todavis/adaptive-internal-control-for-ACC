function [fig] = plotFrequencyEstimate(time, theta, freq, k_max)
%PLOTFREQUENCYESTIMATE
%   plot each frequency component estimate error over time
%   theta_err = cos(freq_ij) - theta_j

    fig = figure;
    legend_label = {};
    
    for i = 1:size(freq, 2)
        plot(time, cos(freq(i)) * ones(k_max, 1) - theta(:, i), ...
             'LineWidth', 2);
        hold on
        legend_label{i} = "${cos(\omega_" + num2str(i) + ...
                          ") - \theta_" + num2str(i) + "(k)}$";
    end
    
    t = title('$\bf{cos(\omega) - \theta(k)}$');
    labelx = xlabel('${Timestep (k)}$');
    leg = legend(legend_label);
    
    set(leg,'Interpreter', 'Latex', 'fontsize', 15)
    set(t,'Interpreter', 'Latex', 'fontsize', 15);
    set(labelx,'Interpreter', 'Latex', 'fontsize', 15);
    
end

