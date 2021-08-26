function group_v31_5_nNPE_nc_t1(varargin)
addpath('C:\Users\SN\Desktop\spm12')

f0 = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\210125_eLife_revision\group\v31_5';
con_name = 'nNPE_nc';
input_dir = fullfile(f0,'input', con_name);
output_dir = fullfile(f0, 'output', [con_name '_t1']);
mkdir(output_dir);

        
%% set model - full factorial design
matlabbatch{1}.spm.stats.factorial_design.dir = cellstr(output_dir);

[input_files, ~] = spm_select('List',input_dir,'.*\.nii$'); 
matlabbatch{1}.spm.stats.factorial_design.des.t1.scans = cellstr(strcat(input_dir,filesep,input_files,',1'));

matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;

% estimate the model
matlabbatch{2}.spm.stats.fmri_est.spmmat = cellstr([output_dir filesep 'SPM.mat']);
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1; 

% set up the contrasts
matlabbatch{3}.spm.stats.con.spmmat =  cellstr([output_dir filesep 'SPM.mat']);
matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = [con_name '+'];
matlabbatch{3}.spm.stats.con.consess{1}.tcon.convec = [1];
matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.spmmat =  cellstr([output_dir filesep 'SPM.mat']);
matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = [con_name '-'];
matlabbatch{3}.spm.stats.con.consess{2}.tcon.convec = [-1];
matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';

cd(output_dir);
save 'batch_v31_5_nNPE_nc_t1' matlabbatch;
spm_jobman('run',matlabbatch);
clear matlabbatch;


clear;
