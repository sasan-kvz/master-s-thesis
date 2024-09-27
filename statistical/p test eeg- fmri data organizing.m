% Define the directory containing the .mat files
inputDir = 'E:\proje\data\1Heydari\EEG\EEG\session2_cleared\after ica bandpass\power average';

% Get a list of all .mat files in the directory
matFiles = dir(fullfile(inputDir, '*.mat'));

% Initialize a cell array to store the concatenated data
concatenatedData = cell(length(matFiles), 250);

% Loop through each .mat file
for i = 1:length(matFiles)
    % Load the .mat file
    load(fullfile(inputDir, matFiles(i).name));
    
    % Access the cell data from the loaded .mat file
    cellData = averaged_rdms;  % Replace 'your_loaded_variable' with the appropriate variable name
    
    % Concatenate the cell data vertically
    concatenatedData(i, :) = cellData;
end

% Now 'concatenatedData' contains the desired 9*250 cell array
% Initialize a cell array to store the results
resultData = cell(size(concatenatedData));

% Loop through each cell in concatenatedData
for i = 1:size(concatenatedData, 1)
    for j = 1:size(concatenatedData, 2)
        % Access the matrix in the current cell
        matrix = concatenatedData{i, j};
        
        % Extract the lower triangular part of the matrix
        lower_triangular_matrix = matrix - triu(matrix);
        
        % Extract non-zero values from the lower triangular matrix
        non_zero_values_matrix = lower_triangular_matrix(lower_triangular_matrix ~= 0);
        
        % Store the result in resultData
        resultData{i, j} = non_zero_values_matrix;
    end
end

% Now resultData contains the result of the procedure applied to all cells in concatenatedData
% Initialize a 3D matrix to store the reshaped data
reshapedData = zeros(size(resultData, 1), size(resultData, 2), numel(resultData{1, 1}));

% Loop through each cell in resultData
for i = 1:size(resultData, 1)
    for j = 1:size(resultData, 2)
        % Access the vector in the current cell
        vector = resultData{i, j};
        
        % Reshape and store the vector in the 3D matrix
        reshapedData(i, j, :) = reshape(vector, [1, 1, numel(vector)]);
    end
end

% Now reshapedData contains the reshaped data in a 3D matrix format


%%%%%%%%%%%%%%%% fmri matrix
        % Access the matrix in the current cell
        
        matrix = average_matrix;
        % Extract the lower triangular part of the matrix
        lower_triangular_matrix = matrix - triu(matrix);
        
        % Extract non-zero values from the lower triangular matrix
        non_zero_values_matrix = lower_triangular_matrix(lower_triangular_matrix ~= 0);
        
        % Store the result in resultData
        original_fmri_vector = non_zero_values_matrix;