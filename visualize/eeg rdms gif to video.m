% Load the GIF
gif_filename = 'E:\proje\data\0Hemmati\EEG\Analyzer\power\total band/run_eeg_rdm.gif';
[gif_data, cmap] = imread(gif_filename, 'Frames', 'all');

% Create a VideoWriter object
video_filename = 'E:\proje\data\0Hemmati\EEG\Analyzer\power\total band/run_eeg_rdm.avi';
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

