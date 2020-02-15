% Initialise SPM
%--------------------------------------------------------------------------
spm('Defaults','fMRI');
spm_jobman('initcfg');
%spm_get_defaults('cmdline',1);


% CHANGE WORKING DIRECTORY
%--------------------------------------------------------------------------
clear matlabbatch
matlabbatch{1}.cfg_basicio.cfg_cd.dir = cellstr(output_path_nc);
spm_jobman('run',matlabbatch);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GLM SPECIFICATION, ESTIMATION & INFERENCE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% MODEL SPECIFICATION
%--------------------------------------------------------------------------
clear matlabbatch

matlabbatch{1}.spm.stats.fmri_spec.dir = cellstr(output_path_nc);
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT    = 2;

matlabbatch{1}.spm.stats.fmri_spec.sess(1).scans            = {sw1};



%% block 2
for aa=1:length(event.name)
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(aa).name     = event.name{aa};
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(aa).onset    = event.block1{aa};
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(aa).duration = 0;
end

% norm violation @ choice submission
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).pmod.name = 'normViolation';
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).pmod.param =pmod.block1{1};
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).pmod.poly = 1;


matlabbatch{1}.spm.stats.fmri_spec.sess(1).multi_reg = {rp1};


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  PART 2: Fill in onsets and other condition-specific information  %
%  in the matrix, including (if specified) RT regressors            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

matlabbatch{2}.spm.stats.fmri_est.spmmat = cellstr(fullfile(output_path_nc,'SPM.mat'));

matlabbatch{3}.spm.stats.con.spmmat =  cellstr(fullfile(output_path_nc,'SPM.mat'));

matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'xV_nc';
matlabbatch{3}.spm.stats.con.consess{1}.tcon.convec= [0 0 1 zeros(1,8)];  
matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.delete = 1;   % 1 = delete


save 'v1_batch' matlabbatch;
spm_jobman('run',matlabbatch);
%clear;

