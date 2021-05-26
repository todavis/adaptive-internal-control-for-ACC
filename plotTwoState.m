function [fig] = plotTwoState(time, x, dist, control, plot_title)
%PLOTTWOSTATE 
%   Plot state variables of state system, disturbance, control input,
%   and compensator

    if size(x, 2) == 1
        fig = figure;
        
        subplot(2,2,1)
        plot(time, x(:,1), 'LineWidth', 2)
        t = title('$\bf{x_1(k)}$');
        set(t,'Interpreter', 'Latex', 'fontsize', 15);
        %-------------------------

        subplot(2,2,4)
        plot(time, dist, 'LineWidth', 2)
        t = title('$\textbf{Disturbance, d(k)}$');
        set(t,'Interpreter', 'Latex', 'fontsize', 15);

        subplot(2,2,2)
        plot(time, control, 'LineWidth', 2)
        t = title('$\textbf{Control input, u(k)}$');
        set(t,'Interpreter', 'Latex', 'fontsize', 15);

        subplot(2,2,3)
        plot(time, control + dist, 'LineWidth', 2)
        t = title('$\textbf{Compensator, u(k) + d(k)}$');
        set(t,'Interpreter', 'Latex', 'fontsize', 15);
    else
        fig = figure;
        subplot(3,2,1)
        plot(time, x(:,1), 'LineWidth', 2)
        t = title('$\bf{x_1(k)}$');
        set(t,'Interpreter', 'Latex', 'fontsize', 15);

        subplot(3,2,2)
        plot(time, x(:,2), 'LineWidth', 2)
        t = title('$\bf{x_2(k)}$');
        set(t,'Interpreter', 'Latex', 'fontsize', 15);

        %-------------------------

        subplot(3,2,5)
        plot(time, dist, 'LineWidth', 2)
        t = title('$\textbf{Disturbance, d(k)}$');
        set(t,'Interpreter', 'Latex', 'fontsize', 15);

        subplot(3,2,3)
        plot(time, control, 'LineWidth', 2)
        t = title('$\textbf{Control input, u(k)}$');
        set(t,'Interpreter', 'Latex', 'fontsize', 15);

        subplot(3,2,4)
        plot(time, control + dist, 'LineWidth', 2)
        t = title('$\textbf{Compensator, u(k) + d(k)}$');
        set(t,'Interpreter', 'Latex', 'fontsize', 15);
        
    %--------------------------
    % Give common xlabel, ylabel and title to your figure
    han=axes(fig,'visible','off'); 
    han.Title.Visible='on';
    han.XLabel.Visible='on';
    
    labelx = xlabel('${Timestep (k)}$');
    set(labelx,'Interpreter', 'Latex', 'fontsize', 15);
    
    title(han, plot_title);
end

