% Replace this line with your actual heatmap creation
figure;  % Create a new figure window
imagesc(average_matrix);  % Display the matrix as a heatmap

% Set the desired percentiles (e.g., 5th to 95th percentile)
lower_percentile = 3.35;
upper_percentile = 98;

% Calculate the corresponding values for the percentiles
lower_value = prctile(average_matrix(:), lower_percentile);
upper_value = prctile(average_matrix(:), upper_percentile);

% Set the color axis based on percentiles
caxis([lower_value, upper_value]);

% Add colorbar
colorbar;

% Define stimuli names
stimuli = {'S  1', 'S  2', 'S  3', 'S  4', 'S  5', 'S  6', 'SNew  1', 'SNew  2', 'SNew  3', 'SNew  4', 'SNew  5', 'SNew  6', 'SNew  7', 'SNew  8', 'SNew  9', 'SNew 10', 'SNew 11', 'SNew 12', 'S 67', 'S 68', 'S 70', 'S 71', 'S 80', 'S 81', 'S 82', 'S 85', 'S 89', 'S 91', 'S 92', 'S 95'};

stimuli_categ={'human body' , 'human face', 'animal body', 'animal face','natural', 'artificial'};
    
% Set x-axis labels
xticks([3 , 9 , 14 , 17 , 21,27]);
xticklabels(stimuli_categ);
xtickangle(45);  % Rotate x-axis labels for better readability

%Set y-axis labels
yticks([3 , 9 , 14 , 17 , 21,27]);
yticklabels(stimuli_categ);

% Set x-axis labels
%xticks(1:length(stimuli));
%xticklabels(stimuli);
%xtickangle(45);  % Rotate x-axis labels for better readability

% Set y-axis labels
%yticks(1:length(stimuli));
%yticklabels(stimuli);

% Adjust other plot properties as needed
title('fMRI IT RDM subject1');
xlabel('X-axis (Stimuli)');
ylabel('Y-axis (Stimuli)');

%colormap('jet');  % Set the colormap (you can change 'jet' to other colormaps as desired)
