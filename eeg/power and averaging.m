% Calculate power for each time point for each epoch
power_data = abs(concatenated_epochs).^2; % Squared magnitude of complex numbers

% Convert power values to decibels
power_data_dB = 10 * log10(power_data);

% Original unique event types
unique_event_types = unique({cleaned_events.type}); 

% Define the desired order of event types
unique_event_types = {
    'S  1'	'S  2'	'S  3'	'S  4'	'S  5'	'S  6'	'SNew  1'	'SNew  2'	'SNew  3'	'SNew  4'	'SNew  5'	'SNew  6'	'SNew  7'	'SNew  8'	'SNew  9'	'SNew 10'	'SNew 11'	'SNew 12'	'S 67'	'S 68'	'S 70'	'S 71'	'S 80'	'S 81'	'S 82'	'S 85'	'S 89'	'S 91'	'S 92'	'S 95'	'other'
};

avg_power_for_conditions = cell(length(unique_event_types), 2); % Column 1: Event type, Column 2: Average power

for i = 1:length(unique_event_types)
    % Find indices in cleaned_events that match the current unique event type
    indices = find(strcmp({cleaned_events.type}, unique_event_types{i}));
    
    % Extract power data for epochs corresponding to the current unique event type
    condition_power_data = power_data_dB(:, :, indices);
    
    % Compute average power across epochs (3rd dimension)
    avg_power = mean(condition_power_data, 3);
    
    % Store the event type and its corresponding average power in the cell array
    avg_power_for_conditions{i, 1} = unique_event_types{i};
    avg_power_for_conditions{i, 2} = avg_power;
end
