% Input directory
input_directory = 'E:\proje\data\0Hemmati\EEG\Analyzer\hemmati gif video power';

% List all GIF files in the input directory
gif_files = dir(fullfile(input_directory, '*.gif'));

% Iterate through each GIF file
for file_index = 1:numel(gif_files)
    % Construct the full path to the current GIF file
    gif_filename = fullfile(input_directory, gif_files(file_index).name);
    
    % Load the GIF
    [gif_data, cmap] = imread(gif_filename, 'Frames', 'all');
    
    % Create a VideoWriter object
    [~, base_name, ~] = fileparts(gif_filename);
    video_filename = fullfile(input_directory, [base_name, '.avi']);
    video_writer = VideoWriter(video_filename, 'Motion JPEG AVI');
    video_writer.FrameRate = 1;  % Set the frame rate (adjust as needed)
    
    % Open the VideoWriter object
    open(video_writer);
    
    % Write each frame to the video
    for i = 1:size(gif_data, 4)
        writeVideo(video_writer, im2frame(gif_data(:, :, :, i), cmap));
    end
    
    % Close the VideoWriter object
    close(video_writer);
end
