% Add SPM12 toolbox to the path
addpath('E:\proje\toolboxes\spm12')

% Define file paths
realignment_filename = 'E:\proje\data\1Heydari\fMRI\MR\Series 4-ep2d_Run2\Run2_nii\rp_f97197041901-0004-00001-000001-01.txt';
scan_dir = 'E:\proje\data\1Heydari\fMRI\MR\Series 4-ep2d_Run2\Run2_nii\1_first_level\warf';
output_dir = 'E:\proje\data\1Heydari\fMRI\MR\Series 4-ep2d_Run2\Run2_nii\1_first_level';

% Read design matrix from Excel file
data_table = readtable('E:\proje\data\1Heydari\fMRI\MR\Series 4-ep2d_Run2\Run2_nii\des_mat2.xlsx');

% Define the number of conditions
num_conditions = 32;

% Load realignment parameters for the specified run
realignment_params = load(realignment_filename);

% Define onsets and durations for each condition
onsets = cell(num_conditions, 1);
durations = cell(num_conditions, 1);
condition = [1:6, 101:112, 67, 68, 70, 71, 80, 81, 82, 85, 89, 91, 92, 95, 100, 200];

% Loop through each condition
for i = 1:num_conditions
    % Extract relevant data for the current condition
    condition_data = data_table(data_table.stimuli == condition(i), :);
    onsets{i} = condition_data.startReal;
    durations{i} = condition_data.duration;
end

% Initialize SPM
spm('defaults', 'fmri');
spm_jobman('initcfg');

% Create SPM design matrix
matlabbatch{1}.spm.stats.fmri_spec.dir = {output_dir};
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 3; % Specify the TR here
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 31;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 16;
matlabbatch{1}.spm.stats.fmri_spec.sess.scans = cellstr(spm_select('ExtFPList', scan_dir, '.*'));

% Specify conditions
for i = 1:num_conditions
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(i).name = sprintf('Condition %d', i);
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(i).onset = onsets{i};
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(i).duration = durations{i};
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(i).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(i).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess.cond(i).orth = 1;
end

% Other settings
matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = {realignment_filename}; % Motion regressors
matlabbatch{1}.spm.stats.fmri_spec.sess.hpf = 128;
matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';

% Save and run the job
spm_jobman('run', matlabbatch);
