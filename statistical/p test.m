% Assuming original_fmri_vector and eeg_vectors are your original data
original_fmri_vector = original_fmri_vector';

eeg_vectors = reshapedData;

% Step 1: Calculate original RSA map
original_rsa_map = zeros(9, 250);
for i = 1:9
    for j = 1:250
        original_rsa_map(i, j) = corr(original_fmri_vector', squeeze(eeg_vectors(i, j, :)));
    end
end

% Step 2: Perform permutation test
num_permutations = 20;
permutation_rsa_maps = zeros(num_permutations, 9, 250);
for k = 1:num_permutations
    shuffled_fmri_vector = original_fmri_vector(randperm(length(original_fmri_vector)));
    shuffled_eeg_vectors = eeg_vectors(:, :, randperm(size(eeg_vectors, 3)));
    for i = 1:9
        for j = 1:250
            permutation_rsa_maps(k, i, j) = corr(shuffled_fmri_vector', squeeze(shuffled_eeg_vectors(i, j, :)));
        end
    end
end

% Step 3: Flatten all RSA maps
flattened_rsa_maps = reshape(permutation_rsa_maps, [], 1);

% Step 4: Create histogram
num_bins = 50;
histogram_data = hist(flattened_rsa_maps, num_bins);

% Step 5: Determine significance level threshold
significance_threshold = prctile(flattened_rsa_maps, 95);

% Print or display the histogram and significance threshold
disp(['Significance Threshold:', num2str(significance_threshold)]);
