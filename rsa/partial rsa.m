
% Load the fMRI matrix (replace 'your_fmri_matrix.mat' with the actual filename)
fmri_matrix_filename = 'E:\proje\data\0Hemmati\fMRI\MainData\2019_05_22\Image\rdm v1 hemmati/v1_rdm.mat';
fmri_matrix = load(fmri_matrix_filename);
fmri_matrix = fmri_matrix.average_matrix;
%control 
control_matrix_filename = 'E:\proje\data\0Hemmati\fMRI\MainData\2019_05_22\Image\final rdm test tresh it hemmati/tresh_it_rdm.mat';
fmri_control = load(control_matrix_filename);
fmri_control = fmri_control.average_matrix;
% Specify the directory containing the averaged RDMs
averaged_rdms_filename = 'E:\proje\data\0Hemmati\EEG\Analyzer\phase\12-16/band12-16_averaged_rdms.mat';

% Specify the output directory for saving the correlation results
output_directory = 'E:\proje\data\0Hemmati\rsa 2d\phase_it test';

% Load the averaged RDMs
averaged_rdms= load(averaged_rdms_filename);
averaged_rdms=averaged_rdms.averaged_rdms;

% Initialize a vector to store the correlation results
correlation_results1 = zeros(1, numel(averaged_rdms));

% Loop through each item matrix
for item_idx = 1:numel(averaged_rdms)
    % Extract the lower triangular part of the item matrix
    lower_triangular_item_matrix = averaged_rdms{item_idx} - triu(averaged_rdms{item_idx});
    non_zero_values_item_matrix = lower_triangular_item_matrix(lower_triangular_item_matrix ~= 0);
    
    % Extract the lower triangular part of the fmri matrix
    lower_triangular_fmri_matrix = fmri_matrix - triu(fmri_matrix);
    non_zero_values_fmri_matrix = lower_triangular_fmri_matrix(lower_triangular_fmri_matrix ~= 0);
    
        % Extract the lower triangular part of the fmri matrix
    lower_triangular_control_matrix = fmri_control - triu(fmri_control);
    non_zero_values_control_matrix = lower_triangular_control_matrix(lower_triangular_control_matrix ~= 0);
    
    % Calculate partial Pearson's correlation
    correlation_result = partialcorr(non_zero_values_item_matrix, non_zero_values_fmri_matrix,non_zero_values_control_matrix);
    
    % Store the result in the vector
    correlation_results1(item_idx) = correlation_result;
end

% Save the correlation results
RSA = fullfile(output_directory, 'phase_v1_12-16_partial_control_on_it.mat');
save(RSA, 'correlation_results1');
