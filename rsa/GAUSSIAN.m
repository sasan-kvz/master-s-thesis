% Create an array of 250 values between -5 and 5 (adjust as needed)
x = linspace(-5, 5, 250);

% Set parameters for the asymmetric Gaussian function
mu_initial = -2.5;
sigma_left_initial = 1.5;
sigma_right_initial = 2.5;
amplitude_initial = 1.6;

% Generate Gaussian values using asymmetricGaussian function
y = asymmetricGaussian(x, mu_initial, sigma_left_initial, sigma_right_initial, amplitude_initial);
y = y + 0.1 ;
% Plot the asymmetric Gaussian function
figure
plot( y);
title('Asymmetric Gaussian Function');
xlabel('X-axis');
ylabel('Y-axis');
grid on;

% Define the asymmetric Gaussian function
function y = asymmetricGaussian(x, mu, sigma_left, sigma_right, amplitude)
    % x: input values
    % mu: mean
    % sigma_left: standard deviation on the left side of the peak
    % sigma_right: standard deviation on the right side of the peak
    % amplitude: amplitude of the Gaussian curve
    
    % Calculate Gaussian values using normpdf for left and right sides
    left_side = amplitude * normpdf(x, mu, sigma_left);
    right_side = amplitude * normpdf(x, mu, sigma_right);
    
    % Combine the left and right sides
    y = left_side + right_side;
end
