% run_newtons_method_analysis.m
% This script applies Newton's method to find the root of f(x) = x^2 - 2.
% It calculates and displays the error at each step to numerically
% demonstrate the method's quadratic convergence.

% --- Setup ---
% Function f(x) = x^2 - 2, for which the positive root is sqrt(2)
f = @(x) x^2 - 2;
df = @(x) 2*x; % The derivative, f'(x)

x0 = 1.5; % Initial guess
true_root = sqrt(2);
max_iterations = 5;

% Print a formatted header for the output table
fprintf('Iteration |      x_n      |      Error      | Ratio e(n+1)/e(n)^2\n');
fprintf('---------------------------------------------------------------------\n');

% --- Iteration and Calculation ---
x_n = x0;
previous_error = abs(x_n - true_root);
fprintf('%9d | %13.10f | %15.12f |\n', 0, x_n, previous_error);

for n = 1:max_iterations
    % Newton's method formula
    x_n_plus_1 = x_n - f(x_n) / df(x_n);
    
    % Calculate the error of the new approximation
    current_error = abs(x_n_plus_1 - true_root);
    
    % Calculate the ratio to show quadratic convergence
    % This should approach a constant value
    ratio = current_error / (previous_error^2);
    
    fprintf('%9d | %13.10f | %15.12f | %15.12f\n', n, x_n_plus_1, current_error, ratio);
    
    % Update variables for the next loop iteration
    x_n = x_n_plus_1;
    previous_error = current_error;
end