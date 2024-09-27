% Define the path to the V1 mask file
v1_mask_path = 'E:\proje\data\0Hemmati\fMRI\MainData\2019_05_22\Image\rdm it hemmati\it_rdm.mat';

% Load the V1 mask using spm_vol and spm_read_vols
v1_mask = spm_vol(v1_mask_path);
v1_mask_data = spm_read_vols(v1_mask);

% Plot histogram of mask values
figure; % Create a new figure window
histogram(v1_mask_data(:)); % Plot histogram of mask values
title('Histogram of V1 Mask Values'); % Set plot title
xlabel('Mask Value'); % Set x-axis label
ylabel('Frequency'); % Set y-axis label
grid on; % Display grid lines on the plot
ylim([0, 2000]);