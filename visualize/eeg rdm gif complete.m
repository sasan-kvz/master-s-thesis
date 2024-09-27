% Assuming your 1x250 cell array is named 'all_matrices'
input_directory = 'E:\proje\data\0Hemmati\EEG\Analyzer\power\test video';
output_directory = 'E:\proje\data\0Hemmati\EEG\Analyzer\power\test video'; % Define your output directory

% Get a list of all .mat files in the input directory
file_list = dir(fullfile(input_directory, '*.mat'));

% Loop through each file in the directory
for file_idx = 1:numel(file_list)
    file_name = fullfile(input_directory, file_list(file_idx).name);
    
    % Load the data from the file
    rdms = load(file_name);
    rdms=rdms.averaged_rdms ;
    %rdms = struct2cell(rdms); % Convert structure to cell array if necessary
    num_matrices = length(rdms);

    % Create a GIF file
    gif_filename = fullfile(output_directory, ['run_eeg_rdm_' num2str(file_idx) '.gif']);

    for i = 1:num_matrices
        % Replace this line with your actual heatmap creation for each matrix
        figure;
        imagesc(rdms{i});
        title(['EEG RDM at ', num2str(i*0.004)]);

        % Set the desired percentiles (adjust as needed)
        lower_percentile = 3.35;
        upper_percentile = 98;

        % Calculate the corresponding values for the percentiles
        lower_value = prctile(rdms{i}(:), lower_percentile);
        upper_value = prctile(rdms{i}(:), upper_percentile);

        % Set the color axis based on percentiles
        caxis([lower_value, upper_value]);

        % Add colorbar
        colorbar;

        % Adjust other plot properties as needed
        % Define stimuli names
        stimuli_categ={'human body' , 'human face', 'animal body', 'animal face','natural', 'artificial'};
    
        % Set x-axis labels
        xticks([3 , 9 , 14 , 17 , 21,27]);
        xticklabels(stimuli_categ);
        xtickangle(45);  % Rotate x-axis labels for better readability

        %Set y-axis labels
        yticks([3 , 9 , 14 , 17 , 21,27]);
        yticklabels(stimuli_categ);

        % Capture the current figure as an image
        frame = getframe(gcf);
        im = frame2im(frame);

        % Convert the image to an indexed image for the GIF
        [imind, cm] = rgb2ind(im, 256);

        % Write the image to the GIF file
        if i == 1
            imwrite(imind, cm, gif_filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.3);
        else
            imwrite(imind, cm, gif_filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.3);
        end

        close(gcf);  % Close the current figure
    end
end

% Rest of your code for creating the video...
