% Assuming your 1x250 cell array is named 'all_matrices'
rdms = averaged_rdms;
num_matrices = length(rdms);

% Create a GIF file
gif_filename = 'E:\proje\data\0Hemmati\EEG\Analyzer\power\total band/run_eeg_rdm.gif';

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
    stimuli = {'S  1', 'S  2', 'S  3', 'S  4', 'S  5', 'S  6', 'SNew  1', 'SNew  2', 'SNew  3', 'SNew  4', 'SNew  5', 'SNew  6', 'SNew  7', 'SNew  8', 'SNew  9', 'SNew 10', 'SNew 11', 'SNew 12', 'S 67', 'S 68', 'S 70', 'S 71', 'S 80', 'S 81', 'S 82', 'S 85', 'S 89', 'S 91', 'S 92', 'S 95'};

    % Set x-axis labels
    xticks(1:length(stimuli));
    xticklabels(stimuli);
    xtickangle(45);  % Rotate x-axis labels for better readability

    % Set y-axis labels
    yticks(1:length(stimuli));
    yticklabels(stimuli);

    % Capture the current figure as an image
    frame = getframe(gcf);
    im = frame2im(frame);
    
    % Convert the image to an indexed image for the GIF
    [imind, cm] = rgb2ind(im, 256);
    
    % Write the image to the GIF file
    if i == 1
        imwrite(imind, cm, gif_filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.3);
    else
        imwrite(imind, cm, gif_filename, 'gif', 'WriteMode', 'append', 'DelayTime', 1);
    end
    
    close(gcf);  % Close the current figure
end
