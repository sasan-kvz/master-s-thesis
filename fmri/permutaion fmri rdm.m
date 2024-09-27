% Set the number of permutations for the permutation test
num_permutations = 1000;

% Initialize a matrix to store p-values
p_values = zeros(num_columns, num_columns);

% Loop through each pair of columns to calculate p-values
for i = 1:num_columns
    for j = 1:num_columns
        % Calculate observed correlation
        observed_corr = correlation_matrix(i, j);
        
        % Initialize a vector to store permuted correlations
        permuted_corrs = zeros(1, num_permutations);
        
        % Perform permutation test
        for k = 1:num_permutations
            permuted_data = results_matrix(:, j(randperm(num_columns)));
            permuted_corrs(k) = 1 - corr(results_matrix(:, i), permuted_data, 'Type', 'Spearman');
        end
        
        % Calculate p-value based on permutation test
        p_values(i, j) = sum(permuted_corrs >= observed_corr) / num_permutations;
    end
end

% Correct for multiple comparisons (e.g., FDR correction)
p_values_corrected = mafdr(p_values(:), 'BHFDR', true);
p_values_corrected = reshape(p_values_corrected, [num_columns, num_columns]);

% Display the corrected p-values matrix
disp('Corrected p-values matrix:');
disp(p_values_corrected);

figure;
imagesc(p_values_corrected);
colorbar;
title('Corrected p-values Matrix');

% Set the significance threshold (e.g., 0.05)
alpha = 0.05;

% Threshold the matrix based on corrected p-values
significant_correlations = correlation_matrix .* (p_values_corrected <= alpha);

% Display the significant correlations matrix
disp('Significant correlations matrix:');
disp(significant_correlations);

% Visualize the significant correlations matrix
figure;
imagesc(significant_correlations);
colorbar;
title('Significant Correlations Matrix');

% Perform hierarchical clustering
dendrogram_linkage = linkage(1 - correlation_matrix, 'complete');

% Visualize the hierarchical clustering
figure;
dendrogram(dendrogram_linkage, 'Labels', cellstr(num2str((1:num_columns)')), 'Orientation', 'left');
title('Hierarchical Clustering of Conditions');
