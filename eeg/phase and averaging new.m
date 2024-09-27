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
