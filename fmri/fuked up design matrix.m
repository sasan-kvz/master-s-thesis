addpath('E:\proje\toolboxes\spm12')

% Directory containing the realignment parameters files
realignment_filename = 'E:\proje\data\1Heydari\fMRI\MR\Series 4-ep2d_Run2\Run2_nii/rp_f97197041901-0004-00001-000001-01.txt';

% Directory containing the scan files
scan_dir = 'E:\proje\data\1Heydari\fMRI\MR\Series 4-ep2d_Run2\Run2_nii\1_first_level\warf';

% Output directory for SPM.mat file
output_dir = 'E:\proje\data\1Heydari\fMRI\MR\Series 4-ep2d_Run2\Run2_nii\1_first_level';

% Load the table
data_table = readtable('E:\proje\data\1Heydari\fMRI\MR\Series 4-ep2d_Run2\Run2_nii/des_mat2.xlsx'); % Assuming your table is saved as a CSV file

% Number of conditions
num_conditions = 32;

% Specify the run
run = 1;

% Load realignment parameters for the specified run
realignment_params = load(realignment_filename);

% Initialize design matrix variables
onsets = cell(num_conditions, 1);
durations = cell(num_conditions, 1);
condition = [1:6,101:112,67,68,70,71, 80,81,82,85,89,91,92,95,100,200];
% Loop through each condition
for i = 1:num_conditions
    % Extract relevant data for the current condition and run
    condition_data = data_table(data_table.stimuli == condition(i), :);
    onsets{i} = condition_data.startReal;
    durations{i} = condition_data.duration;
end

% Create SPM design matrix
SPM = spm_fmri_spm_ui('init');
disp(SPM)
SPM.swd = output_dir; % Specify the output directory for SPM.mat file
SPM.xY.P = cellstr(spm_select('ExtFPList', scan_dir, '.*')); % Specify the scan files
SPM.xBF.UNITS = 'secs';
SPM.xBF.T0 = 16; % Microtome onset
SPM.xBF.T = 31; % Microtome resolution
SPM.xBF.dt = 3; % Interval scan
SPM = spm_fmri_spm_ui('defregs', SPM);
SPM = spm_fmri_spm_ui('specify', SPM, onsets, durations);
SPM = spm_fmri_spm_ui('estimate', SPM);
