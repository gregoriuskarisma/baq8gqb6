% run_error_correction.m
% This script demonstrates a simple error correction scheme using
% polynomials. It encodes a message, introduces an error, detects the
% error's location using a discrete derivative, and corrects the message.

% --- 1. Encoding ---
% Message M = [2, -3, 5] corresponds to P(x) = 2x^2 - 3x + 5
message_coeffs = [2, -3, 5];
P = @(x) polyval(message_coeffs, x);

% Evaluate at x = 0, 1, 2, 3, 4 to create the codeword
x_points = 0:4;
codeword = P(x_points);

fprintf('Original Codeword: %s\n', mat2str(codeword));

% --- 2. Error Introduction ---
% Corrupt the 3rd data point (at x=2)
received_word = codeword;
error_val = 5;
error_pos = 3;
received_word(error_pos) = received_word(error_pos) + error_val;

fprintf('Received Word (with error): %s\n', mat2str(received_word));

% --- 3. Error Detection using Calculus Concept ---
% The second finite difference is the discrete analog of the second derivative.
% For a quadratic, this should be constant. An error creates spikes.
first_diff = diff(received_word);
second_diff = diff(first_diff);

fprintf('Second Finite Difference of Received Word: %s\n', mat2str(second_diff));

% The error is at the index of the first major spike + 1.
% We find the index where the value deviates most from the mean.
[~, error_idx] = max(abs(second_diff - mean(second_diff)));
error_location = error_idx + 1;

fprintf('Calculus-based detection indicates an error at index %d\n', error_location);

% --- 4. Correction ---
% Assuming only one error, we find the subset of n-1 points that
% perfectly fits a polynomial of the correct degree.
num_points_needed = length(message_coeffs);
num_received = length(received_word);
all_indices = 1:num_received;
correct_indices = setdiff(all_indices, error_location); % Remove the detected error location

% Fit a polynomial to the remaining (assumed correct) points
x_subset = x_points(correct_indices);
y_subset = received_word(correct_indices);

% polyfit finds the coefficients of the polynomial of best fit
corrected_coeffs = polyfit(x_subset, y_subset, num_points_needed - 1);

fprintf('Recovered Polynomial Coefficients: %s\n', mat2str(round(corrected_coeffs)));
fprintf('Original Coefficients:           %s\n', mat2str(message_coeffs));