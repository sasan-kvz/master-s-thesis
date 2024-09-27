% Replace this line with your actual heatmap creation
figure;  % Create a new figure window
phase_it_t = power_it';
phase_it_f = flipud(phase_it_t);
imagesc(phase_it_f);  % Display the matrix as a heatmap

% Add colorbar
colorbar;

% Set y-axis labels
freq_band = {'32-36','28-32','24-28','20-24','16-20','12-16','8-12','4-8','1-4'};
yticks(1:9);
yticklabels(freq_band);

% Adjust x-axis for real time
sampling_rate = 250;  % Hz
time_conversion_factor = 1 / sampling_rate;  % Conversion factor to seconds
time_shift = -100 / 1000;  % Shift in seconds (-100 ms converted to seconds)

% Calculate x-axis ticks and labels
num_timepoints = size(phase_it_t, 2);

time_values = {'0','200','400','600','800','895'};
% Set x-axis ticks and labels
xticks(25:49:250);
xticklabels(time_values);

% Adjust other plot properties as needed
title('Power - IT RSA subject1');
xlabel('Time (s)');  % Adjust the x-axis label

ylabel('Frequency Band');

% Colormap setting (you can change 'jet' to other colormaps as desired)
%colormap('');

% Add title to the colorbar
h = colorbar;
set(get(h, 'title'), 'string', 'R Values');

