spm('defaults', 'FMRI');
spm_jobman('initcfg');
spm_mat_dir = 'E:\proje\data\1Heydari\fMRI\MR\Series 12-ep2d_Run10\Run10_nii\1_first_level';
spm_mats = dir(fullfile(spm_mat_dir, 'SPM.mat'));

contrasts = eye(30); % Assuming you have 30 contrasts with identity matrix
for i = 1:numel(spm_mats)
    spm_mat_path = fullfile(spm_mat_dir, spm_mats(i).name);
    matlabbatch = [];
    matlabbatch{1}.spm.stats.con.spmmat = {spm_mat_path};
    matlabbatch{1}.spm.stats.con.delete = 0;

    for j = 1:size(contrasts, 1)
        matlabbatch{1}.spm.stats.con.consess{j}.tcon.name = ['Contrast_', num2str(j)];
        matlabbatch{1}.spm.stats.con.consess{j}.tcon.weights = contrasts(j, :);
        matlabbatch{1}.spm.stats.con.consess{j}.tcon.sessrep = 'none';
    end
    
    spm_jobman('run', matlabbatch);
end
