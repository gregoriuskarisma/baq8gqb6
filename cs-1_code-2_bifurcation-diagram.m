% generate_bifurcation_diagram.m
% This script generates the bifurcation diagram for the logistic map,
% illustrating how the long-term behavior of the system changes
% as the growth parameter 'r' is varied.

% --- Bifurcation Diagram Calculation ---
r_values = 2.8:0.001:4.0; % Range of r values to test
N_transient = 1000;       % Iterations to discard to let the system settle
N_plot = 200;             % Iterations to plot for each r value
x0 = 0.5;                 % Initial condition

% Pre-allocate arrays for plotting to improve performance
num_points = length(r_values) * N_plot;
all_r = zeros(num_points, 1);
all_x = zeros(num_points, 1);
plot_idx = 1;

fprintf('Generating bifurcation data...\n');
for r = r_values
    x = x0;
    % Discard transient iterations to find the attractor
    for i = 1:N_transient
        x = r * x * (1 - x);
    end
    % Store the long-term behavior (the attractor)
    for i = 1:N_plot
        x = r * x * (1 - x);
        all_r(plot_idx) = r;
        all_x(plot_idx) = x;
        plot_idx = plot_idx + 1;
    end
end
fprintf('Data generation complete.\n');

% --- Plotting ---
figure;
plot(all_r, all_x, '.', 'MarkerSize', 1, 'Color', [0 0.4470 0.7410]);
title('Bifurcation Diagram of the Logistic Map');
xlabel('Growth Parameter (r)');
ylabel('Long-Term Population (x)');
set(gca, 'YLim', [0 1]); % Set y-axis limits from 0 to 1