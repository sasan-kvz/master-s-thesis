% Specify the directory containing the EEG files
input_directory = 'E:\proje\data\1Heydari\EEG\EEG\session2_cleared\after ica bandpass';

% Specify the output directory for saving the results
output_directory = 'E:\proje\data\0Hemmati\EEG\Analyzer\real_imag\total band';

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
    
    % Loop through each event and update its type based on the mapping table
    for j = 1:length(EEG.event)
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

        if ~new_type_found
            EEG.event(j).type = 'other';
        end
    end

    cleaned_events = EEG.event;

    hil
