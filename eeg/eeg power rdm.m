avg_power_for_conditions(end, :) = [];
num_timepoints = size(avg_power_for_conditions{1, 2}, 2); % Number of time points

% Initialize a cell array to store the RDMs
rdms = cell(1, num_timepoints);

for t = 1:num_timepoints
    % Initialize a matrix to store the RDM for the current time point
    rdm = zeros(length(avg_power_for_conditions), length(avg_power_for_conditions));
    
    % Compute the RDM based on Pearson's correlation
    for i = 1:length(avg_power_for_conditions)
        for j = 1:length(avg_power_for_conditions)
            % Extract power values for the current time point
            power_values_i = avg_power_for_conditions{i, 2}(:, t);
            power_values_j = avg_power_for_conditions{j, 2}(:, t);
            
            % Compute Pearson's correlation between power values
            r = corrcoef(power_values_i, power_values_j);
            
            % Store the correlation coefficient in the RDM
            rdm(i, j) = 1 - r(1, 2);
        end
    end
    
    % Store the RDM for the current time point
    rdms{t} = rdm;
end
save('E:\proje\data\0Hemmati\EEG\Analyzer\rdms phase/power_rdm1.mat', 'rdms');

