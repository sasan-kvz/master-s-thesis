input_directory = 'E:\proje\data\0Hemmati\rsa 2d\phase it\new phase it';

% Specify the output directory for saving the results
output_directory = 'E:\proje\data\0Hemmati\rsa 2d\phase it\new phase it';

phase_it = zeros(250, 9);

file_names = {
    'new_phase_it_1-4.mat',
    'new_phase_it_4-8.mat',
    'new_phase_it_8-12.mat',
    'new_phase_it_12-16.mat',
    'new_phase_it_16-20.mat',
    'new_phase_it_20-24.mat',
    'new_phase_it_24-28.mat',
    'new_phase_it_28-32.mat',
    'new_phase_it_32-36.mat'
};
 for file_idx = 1:length(file_names)
    file_path = fullfile(input_directory, file_names{file_idx});
    band_data =load(file_path);
    phase_it(:,file_idx) = band_data.new;
 end

output_filename = fullfile(output_directory, 'phase_it_2d.mat');
save(output_filename, 'phase_it');
