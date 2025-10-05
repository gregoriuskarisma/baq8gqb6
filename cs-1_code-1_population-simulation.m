% run_population_simulation.m
% This script simulates and plots the continuous logistic growth model
% and the discrete logistic map to compare their behaviors.

% --- Continuous Model Simulation ---
r_cont = 2.0;   % Intrinsic growth rate
K = 1000;       % Carrying capacity
P0 = 10;        % Initial population
tspan = [0 10]; % Time span

% Define the differential equation
diffeq = @(t, P) r_cont*P*(1 - P/K);

% Solve the ODE using ode45
[t, P_cont] = ode45(diffeq, tspan, P0);

% --- Discrete Model Simulation ---
r_disc = 2.8; % Discrete growth parameter (set to a stable value)
x0 = 0.01;    % Initial population fraction
N = 50;       % Number of generations
x = zeros(1, N);
x(1) = x0;
for n = 1:N-1
    x(n+1) = r_disc * x(n) * (1 - x(n));
end

% --- Plotting ---
figure;
subplot(1, 2, 1);
plot(t, P_cont, 'b-', 'LineWidth', 2);
title('Continuous Model: Logistic Growth');
xlabel('Time');
ylabel('Population');
grid on;
axis square;

subplot(1, 2, 2);
plot(1:N, x*K, 'r-o', 'LineWidth', 2);
title(['Discrete Model (r = ', num2str(r_disc), '): Stable Equilibrium']);
xlabel('Generation');
ylabel('Population');
grid on;
axis square;