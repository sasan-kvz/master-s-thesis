%bandpass filtering
% Assuming your EEG data is stored in the 'EEG' structure
EEG = pop_loadset('filename', 'r10_ica.set', 'filepath', 'E:\proje\data\0Hemmati\EEG\Analyzer\after ica\total band');
% Define frequency bands
frequency_bands = [1 4; 4 8; 8 12; 12 16; 16 20; 20 24; 24 28; 28 32;32 36];

output_directory= 'E:\proje\data\0Hemmati\EEG\Analyzer\after ica';
% Loop through each frequency band and apply bandpass filtering
for band_idx = 1:size(frequency_bands, 1)
    low_cutoff = frequency_bands(band_idx, 1);
    high_cutoff = frequency_bands(band_idx, 2);

    % Create a copy of the original EEG structure
    EEG_filtered = EEG;

    % Apply bandpass filter to the copied EEG structure
   EEG_filtered = pop_eegfiltnew(EEG_filtered, low_cutoff, high_cutoff)


    % Rename the dataset to indicate the frequency band
    EEG_filtered.setname = [EEG_filtered.setname '_Band' num2str(band_idx)];

    % Save the filtered data
    output_filename = fullfile(output_directory, [EEG_filtered.setname '.set']);
    pop_saveset(EEG_filtered, output_filename);

end


