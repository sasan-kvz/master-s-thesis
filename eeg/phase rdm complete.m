% Specify the directory containing the EEG files
input_directory = 'E:\proje\data\1Heydari\EEG\EEG\session2_cleared\after ica bandpass';

% Specify the output directory for saving the results
output_directory = 'E:\proje\data\0Hemmati\EEG\Analyzer\phase\total band';

% Specify the file names for the 10 EEG files
file_names = {
    'r1 pruned with ICA_total.set',
    'r2 pruned with ICA_total.set',
    'r3 pruned with ICA_total.set',
    'r4 pruned with ICA_total.set',
    'r5 pruned with ICA_total.set',
    'r6 pruned with ICA_total.set',
    'r7 pruned with ICA_total.set',
    'r8 pruned with ICA_total.set',
    'r9 pruned with ICA_total.set',
    'r10 pruned with ICA_total.set',
};


for file_idx = 1:length(file_names)
    % Load the EEG data for the current file
    EEG = pop_loadset('filename', file_names{file_idx}, 'filepath', input_directory);
    
    Stim_Eve = cell(96, 1);
    for i = 1:96
        Stim_Eve{i} = sprintf('S%3d', i);
    end
    % Initialize an empty array to store indices of events to keep
    indices_to_keep = [];

    % Loop through all events
    for j = 1:length(EEG.event)
        % Check if the type of the j-th event matches any value in Stim_Eve
        if any(strcmp(EEG.event(j).type, Stim_Eve))
            indices_to_keep = [indices_to_keep, j];  % Store the index of the event to keep
        end
    end

    % Extract only the events that match the criteria
    cleaned_events = EEG.event(indices_to_keep);

    % Update EEG structure with the cleaned events
    EEG.event = cleaned_events;

    % If you also want to remove any associated data epochs that do not have matching events,
    % you can filter the EEG.data accordingly, but be cautious about aligning data and events.
    % Depending on your specific requirements and dataset structure, further adjustments might be needed.
    % Create a mapping table based on the provided information
    mapping_table = {
        'S  1', 1;
        'S  2', 2;
        'S  3', 3;
        'S  4', 4;
        'S  5', 5;
        'S  6', 6;
        'SNew  1', [7;8;9;10;11];
        'SNew  2', [12;13;14;15;16];
        'SNew  3', [17;18;19;20;21];
        'SNew  4', [22;23;24;25;26];
        'SNew  5', [27;28;29;30;31];
        'SNew  6', [32;33;34;35;36];
        'SNew  7', [38;39;45];
        'SNew  8', [53;54;55];
        'SNew  9', [61;62;66];
        'SNew 10', [37;40;44];
        'SNew 11', [51;52;56];
        'SNew 12', [63;64;65];
        'S 67', 67;
        'S 68', 68;
        'S 70', 70;
        'S 71', 71;
        'S 80', 80;
        'S 81', 81;
        'S 82', 82;
        'S 85', 85;
        'S 89', 89;
        'S 91', 91;
        'S 92', 92;
        'S 95', 95;
        'other', [41;42;43;46;47;48;49;50;57;58;59;60;69;72;73;74;75;76;77;78;79;83;84;86;87;88;90;93;94;96]
    };
%%
    % Loop through each event and update its type based on the mapping table
    for j = 1:length(EEG.event)
        % Extract the numeric portion from the event type (assuming it's always in the format 'S XX')
        numeric_value = str2double(EEG.event(j).type(3:end));

        % Find the corresponding new type based on the mapping table
        new_type_found = false;
        for k = 1:size(mapping_table, 1)
            if ismember(numeric_value, mapping_table{k, 2})
                EEG.event(j).type = mapping_table{k, 1};  % Update the type to the new category
                new_type_found = true;
                break;
            end
        end

        % If the old type did not match any specific new category, update it to 'other'
        if ~new_type_found
            EEG.event(j).type = 'other';
        end
    end

    cleaned_events = EEG.event;


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

%%
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
    normalized_epochs = concatenated_epochs ./ abs(concatenated_epochs);

    % Original unique event types
    unique_event_types = unique({cleaned_events.type}); 

    % Define the desired order of event types
    unique_event_types = {
        'S  1' 'S  2' 'S  3' 'S  4' 'S  5' 'S  6' 'SNew  1' 'SNew  2' 'SNew  3' 'SNew  4' 'SNew  5' 'SNew  6' 'SNew  7' 'SNew  8' 'SNew  9' 'SNew 10' 'SNew 11' 'SNew 12' 'S 67' 'S 68' 'S 70' 'S 71' 'S 80' 'S 81' 'S 82' 'S 85' 'S 89' 'S 91' 'S 92' 'S 95' 'other'
    };
    avg_normalized_phase_for_conditions = cell(length(unique_event_types), 2);

    for i = 1:length(unique_event_types)
        indices = find(strcmp({cleaned_events.type}, unique_event_types{i}));

        % Extract normalized data for epochs corresponding to the current unique event type
        condition_data = normalized_epochs(:, :, indices);

        % Compute average of normalized complex values across epochs (3rd dimension)
        avg_complex_value = mean(condition_data, 3);

        normalized_avg_complex_value = avg_complex_value ./ abs(avg_complex_value);

        % Extract real and imaginary components
        real_components = real(normalized_avg_complex_value);
        imag_components = imag(normalized_avg_complex_value);

        % Concatenate all real components and all imaginary components separately
        concatenated_real_imag = [real_components; imag_components];

        % Store the event type and its corresponding concatenated components in the cell array
        avg_normalized_phase_for_conditions{i, 1} = unique_event_types{i};
        avg_normalized_phase_for_conditions{i, 2} = concatenated_real_imag;
    end

    % The resulting cell array avg_normalized_phase_for_conditions now contains
    % the desired format with concatenated real and imaginary components for each stimulus.
    avg_normalized_phase_for_conditions(end, :) = [];
    num_timepoints = size(avg_normalized_phase_for_conditions{1, 2}, 2); % Number of time points

    % Initialize a cell array to store the RDMs
    rdms = cell(1, num_timepoints);

    for t = 1:num_timepoints
        % Initialize a matrix to store the RDM for the current time point
        rdm = zeros(length(avg_normalized_phase_for_conditions), length(avg_normalized_phase_for_conditions));

        % Compute the RDM based on Pearson's correlation
        for i = 1:length(avg_normalized_phase_for_conditions)
            for j = 1:length(avg_normalized_phase_for_conditions)
                % Extract power values for the current time point
                phase_values_i = avg_normalized_phase_for_conditions{i, 2}(:, t);
                phase_values_j = avg_normalized_phase_for_conditions{j, 2}(:, t);

                % Compute Pearson's correlation between power values
                r = corrcoef(phase_values_i, phase_values_j);

                % Store the correlation coefficient in the RDM
                rdm(i, j) = 1 - r(1, 2);
            end
        end

        % Store the RDM for the current time point
        rdms{t} = rdm;
    end
    
    % Save the RDMs for the current file
    output_filename = fullfile(output_directory, ['r' num2str(file_idx) '_phase_rdm_total.mat']);
    save(output_filename, 'rdms');
end
% check the output saving name with input and output directory last file