
hilbert_transformed_data = hilbert(EEG.data);

pre_stimulus_samples = 25;
post_stimulus_samples = 225;

% Initialize a structure to store epochs
epochs_data = cell(1, length(cleaned_events));

for i = 1:length(cleaned_events)
    % Find the corresponding index in the EEG.data based on the event latency
    event_latency = cleaned_events(i).latency;
    
    % Calculate indices for epoch extraction
    epoch_start_index = event_latency - pre_stimulus_samples;
    epoch_end_index = event_latency + post_stimulus_samples - 1; % -1 to account for MATLAB indexing
    
    % Check if the epoch indices are within the data range
    if epoch_start_index > 0 && epoch_end_index <= size(EEG.data, 2)
        % Extract the epoch for all channels
        epoch_data = hilbert_transformed_data(:, epoch_start_index:epoch_end_index);
        
        % Store the epoch data in the cell array
        epochs_data{i} = epoch_data;
    else
        % Handle cases where the epoch is out of bounds (optional, based on your requirements)
        disp(['Epoch around event ', num2str(i), ' is out of bounds.']);
    end
end


% Now, epochs_data contains all the epochs extracted based on your criteria.
% Each cell of epochs_data will contain an epoch as a 2D matrix (channels x time points).
% You can further process or analyze these epochs as needed.
% Determine the number of channels and time points based on the first epoch
[num_channels, ~] = size(epochs_data{1});

% Initialize a 3D matrix to store concatenated epochs
concatenated_epochs = zeros(num_channels, pre_stimulus_samples + post_stimulus_samples, length(cleaned_events));

% Loop through each cleaned event to concatenate epochs
for i = 1:length(cleaned_events)
    % Extract the epoch data from the cell array
    epoch_data = epochs_data{i};
    
    % Store the epoch data in the concatenated_epochs matrix
    concatenated_epochs(:, :, i) = epoch_data;
end

% Now, concatenated_epochs contains all epochs as a 3D matrix
% with dimensions (number of channels, number of time points, number of epochs).
