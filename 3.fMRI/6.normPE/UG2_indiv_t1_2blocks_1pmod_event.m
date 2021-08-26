% Initialise SPM
%--------------------------------------------------------------------------
spm('Defaults','fMRI');
spm_jobman('initcfg');
%spm_get_defaults('cmdline',1);


% CHANGE WORKING DIRECTORY
%--------------------------------------------------------------------------
clear matlabbatch
matlabbatch{1}.cfg_basicio.cfg_cd.dir = cellstr(output_path);
spm_jobman('run',matlabbatch);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GLM SPECIFICATION, ESTIMATION & INFERENCE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% MODEL SPECIFICATION
%--------------------------------------------------------------------------
clear matlabbatch

matlabbatch{1}.spm.stats.fmri_spec.dir = cellstr(output_path);
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT    = 2;

matlabbatch{1}.spm.stats.fmri_spec.sess(1).scans            = {sw1};
matlabbatch{1}.spm.stats.fmri_spec.sess(2).scans            = {sw2};

block{1} = 'block1';
block{2} = 'block2';
% Event
for i = 1:2
    for aa=1:length(event.name)
        matlabbatch{1}.spm.stats.fmri_spec.sess(i).cond(aa).name     = event.name{aa};
        matlabbatch{1}.spm.stats.fmri_spec.sess(i).cond(aa).onset    = event.(block{i}){aa};
        matlabbatch{1}.spm.stats.fmri_spec.sess(i).cond(aa).duration = 0;
    end
end

% Pmod
for i = 1:2
    matlabbatch{1}.spm.stats.fmri_spec.sess(i).cond(pmod_event).pmod.name = pmod_name;
    matlabbatch{1}.spm.stats.fmri_spec.sess(i).cond(pmod_event).pmod.param =pmod.(block{i}).(pmod_name);
    matlabbatch{1}.spm.stats.fmri_spec.sess(i).cond(pmod_event).pmod.poly = 1;
end

matlabbatch{1}.spm.stats.fmri_spec.sess(1).multi_reg = {rp1};
matlabbatch{1}.spm.stats.fmri_spec.sess(2).multi_reg = {rp2};



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  PART 2: Fill in onsets and other condition-specific information  %
%  in the matrix, including (if specified) RT regressors            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

matlabbatch{2}.spm.stats.fmri_est.spmmat = cellstr(fullfile(output_path,'SPM.mat'));

matlabbatch{3}.spm.stats.con.spmmat =  cellstr(fullfile(output_path,'SPM.mat'));

if pmod_event ==1
    convec = [0 1 0];
elseif pmod_event == 2
    convec = [0 0 1];
end

convec_block1 = [convec zeros(1,19)];
convec_block2 = [zeros(1,11) convec zeros(1,8)];

if order == 1
    convec_ic = convec_block1;
    convec_nc = convec_block2;
elseif order == 2
    convec_ic = convec_block2;
    convec_nc = convec_block1;    
end

matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = [pmod_name, '_ic'];
matlabbatch{3}.spm.stats.con.consess{1}.tcon.convec= convec_ic;
matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = [pmod_name, '_nc'];
matlabbatch{3}.spm.stats.con.consess{2}.tcon.convec= convec_nc;
matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{3}.tcon.name = [pmod_name, '_both'];
matlabbatch{3}.spm.stats.con.consess{3}.tcon.convec= [0 0 1 zeros(1,8) 0 0 1 zeros(1,8)];
matlabbatch{3}.spm.stats.con.consess{3}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.delete = 1;   % 1 = delete


save 'batch' matlabbatch;
spm_jobman('run',matlabbatch);
%clear;

