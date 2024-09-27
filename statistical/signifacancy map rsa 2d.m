% Assuming original_rsa_map is your original RSA map from real data
% Assuming significance_threshold is the threshold obtained from the permutation test

significance_threshold = 0.075;
% Determine significant values in the original RSA map
original_rsa_map = power_it;
significant_indices = original_rsa_map > significance_threshold;

% Create a binary mask indicating significant values
significant_map = zeros(size(original_rsa_map));
significant_map(significant_indices) = 1;

% Optionally, you can display the significant map or perform further analysis.
% For example:
% imshow(significant_map);

% Replace this line with your actual heatmap creation
figure;  % Create a new figure window
significant_map_t = significant_map';
significant_map_f = flipud(significant_map_t);
imagesc(significant_map_f);  % Display the matrix as a heatmap



% Set y-axis labels
freq_band = {'32-36','28-32','24-28','20-24','16-20','12-16','8-12','4-8','1-4'};
yticks(1:9);
yticklabels(freq_band);

% Adjust x-axis for real time
sampling_rate = 250;  % Hz
time_conversion_factor = 1 / sampling_rate;  % Conversion factor to seconds
time_shift = -100 / 1000;  % Shift in seconds (-100 ms converted to seconds)

% Calculate x-axis ticks and labels
num_timepoints = size(significant_map_t, 2);

time_values = {'0','200','400','600','800','895'};
% Set x-axis ticks and labels
xticks(25:49:250);
xticklabels(time_values);

% Adjust other plot properties as needed
title('Power - IT RSA signifacny');
xlabel('Time (s)');  % Adjust the x-axis label

ylabel('Frequency Band');

% Colormap setting (you can change 'jet' to other colormaps as desired)
%colormap('');

