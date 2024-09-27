% Define the directory path
directory_path = 'E:\proje\data\1Heydari\fMRI\MR\Series 3-ep2d_Run1\Run1_nii\1_first_level\run1_tcontrasts';

% List all .nii files in the directory
file_list = dir(fullfile(directory_path, 'lpad_spmT_*.nii'));

% Initialize an empty matrix to store results
results_matrix = [];

% Load the t-map and mask data
v1_mask_path = 'E:\proje\data\1Heydari\fMRI\MR\mask/test_tresh_it_fusiform_heydari.nii';
v1_mask = spm_vol(v1_mask_path);
v1_mask_data = spm_read_vols(v1_mask);

% Loop through each t-value file
for i = 1:length(file_list)
    % Construct the full file path
    t_map_file = fullfile(directory_path, file_list(i).name);
    
    % Load the t-map 
    t_map = spm_vol(t_map_file);
    t_map_data = spm_read_vols(t_map);
    
    % Extract masked values
    masked_t_map_values = t_map_data(v1_mask_data ~= 0);
    
    % Vectorize and store the masked values in the results matrix
    results_matrix(:, i) = masked_t_map_values(:);
end

% Now, results_matrix contains the masked t-value vectors for all 30 files.
% Each column corresponds to a different file.
% Determine the number of columns (vectors) in the results_matrix
num_columns = size(results_matrix, 2);
output_path='E:\proje\data\1Heydari\fMRI\MR\rdm it heydari';

% Initialize a matrix to store correlation coefficients
correlation_matrix = zeros(num_columns, num_columns);

% Loop through each pair of columns to calculate the Spearman’s correlation
for i = 1:num_columns
    for j = 1:num_columns
        % Calculate the Spearman’s correlation between columns i and j
        correlation_matrix(i, j) = 1 -  corr(results_matrix(:, i), results_matrix(:, j), 'Type', 'Spearman');
    end
end

% Now, correlation_matrix contains the Spearman’s correlation coefficients
% for each pair of columns in the results_matrix.
save(fullfile(output_path, 'it_correlation_matrix_run1.mat'), 'correlation_matrix');


