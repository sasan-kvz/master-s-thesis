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
save('E:\proje\data\0Hemmati\EEG\Analyzer\rdms phase/phase_rdm1.mat', 'rdms');