% Specify the directory containing the EEG files
input_directory = 'E:\proje\data\0Hemmati\EEG\Analyzer\phase\total band';

% Specify the output directory for saving the final results
output_directory = 'E:\proje\data\0Hemmati\EEG\Analyzer\phase\total band';

% Specify the number of cells and items
num_cells = 10;
num_items = 250;

% Initialize a cell array to store the averaged RDMs
averaged_rdms = cell(1, num_items);

% Loop through each item
for item_idx = 1:num_items
    % Initialize a matrix to store the averaged RDM for the current item
    averaged_rdm = zeros(30, 30);
    
    % Loop through each cell
    for cell_idx = 1:num_cells
        % Load the RDM for the current cell and item
        file_name = ['r' num2str(cell_idx) '_phase_rdm_total.mat'];
        file_path = fullfile(input_directory, file_name);
        load(file_path, 'rdms');
        
        % Extract the RDM for the current item from the current cell
        current_rdm = rdms{item_idx};
        
        % Add the current RDM to the running sum for averaging
        averaged_rdm = averaged_rdm + current_rdm;
    end
    
    % Calculate the average RDM for the current item across all cells
    averaged_rdm = averaged_rdm / num_cells;
    
    % Store the averaged RDM in the final cell array
    averaged_rdms{item_idx} = averaged_rdm;
end

% Save the final averaged RDMs
output_filename = fullfile(output_directory, 'phase_averaged_rdms.mat');
save(output_filename, 'averaged_rdms');
