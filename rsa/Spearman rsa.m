
% Load the fMRI matrix (replace 'your_fmri_matrix.mat' with the actual filename)
fmri_matrix_filename = 'E:\proje\data\1Heydari\fMRI\MR\rdm v1 heydari/v1_rdm_heydari.mat';
fmri_matrix = load(fmri_matrix_filename);
fmri_matrix = fmri_matrix.average_matrix;
% Specify the directory containing the averaged RDMs
averaged_rdms_filename = 'E:\proje\data\1Heydari\EEG\EEG\session2_cleared\after ica bandpass\power\32-36/r1_power_rdm_32-36.mat';

% Specify the output directory for saving the correlation results
output_directory = 'E:\proje\data\1Heydari\rsa 2d\power v1';

% Load the averaged RDMs
averaged_rdms= load(averaged_rdms_filename);
averaged_rdms=averaged_rdms.rdms;
% Specify the number of items
num_items = 250;

% Initialize a vector to store the correlation results
correlation_results = zeros(num_items, 1);

% Loop through each item
for item_idx = 1:num_items
    % Extract the RDM for the current item
     % Extract the lower triangular part of the fmri matrix
    lower_triangular_fmri_matrix = fmri_matrix - triu(fmri_matrix);
    non_zero_values_fmri_matrix = lower_triangular_fmri_matrix(lower_triangular_fmri_matrix ~= 0);
    
    lower_triangular_item_matrix = averaged_rdms{item_idx} - triu(averaged_rdms{item_idx});
    non_zero_values_item_matrix = lower_triangular_item_matrix(lower_triangular_item_matrix ~= 0);
     
    % Calculate Pearson correlation with the fMRI matrix
    correlation_results(item_idx) = corr(non_zero_values_fmri_matrix, non_zero_values_item_matrix,'Type', 'Spearman');
end

% Save the correlation results
RSA = fullfile(output_directory, 'power_v1_32-36_2d.mat');
save(RSA, 'correlation_results'); 
