% Your first vector
first_vector = target_tag;

% Your second vector of indexes
second_vector = A;

% Replace ones with 100
first_vector(first_vector == 1) = 100;

% Find the indices where 'first' is 0
zero_indices = find(first_vector == 0);

% Replace zeros with corresponding values from the second vector
for i = 1:numel(zero_indices)
    if i <= numel(second_vector)
        first_vector(zero_indices(i)) = second_vector(i);
    end
end




