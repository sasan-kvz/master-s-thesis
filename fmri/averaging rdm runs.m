directory_path = 'E:\proje\data\1Heydari\fMRI\MR\rdm it heydari';

% Initialize a sum matrix with zeros (assuming each matrix is 30x30)
sum_matrix = zeros(30, 30);

% List all .mat files in the directory
mat_files = dir(fullfile(directory_path, '*.mat'));

% Loop through each .mat file to compute the sum
for i = 1:length(mat_files)
    % Construct the full file path
    file_path = fullfile(directory_path, mat_files(i).name);
    
    % Load the matrix from the .mat file
    loaded_data = load(file_path);
    
    % Assuming the variable name containing the matrix is 'matrix_data'
    % Adjust accordingly if your variable name is different
    sum_matrix = sum_matrix + loaded_data.correlation_matrix;
end

% Compute the average matrix
average_matrix = sum_matrix / length(mat_files);

% If you want to save the average_matrix to a .mat file
save(fullfile(directory_path, 'it_rdm_heydari.mat'), 'average_matrix');

figure;  % Create a new figure window
imagesc(average_matrix);  % Display the matrix as a heatmap
colorbar;
