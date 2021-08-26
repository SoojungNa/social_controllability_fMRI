function group_v31_5_nNPE_ic_nc_pt(varargin)
%   Soojung Na, 10/10/2019

f0 = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\210125_eLife_revision\group\';
version = 'v31_5';
outdir = fullfile(f0, version, 'output', 'nNPE_ic_nc_pt');

mkdir(outdir);

    % set up the model
    input_dir1 = fullfile(f0, version, 'input', 'nNPE_ic'); 
    input_dir2 = fullfile(f0, version, 'input', 'nNPE_nc'); 
    output_dir = outdir;
    
    input1 = dir(fullfile(input_dir1, filesep, 'nNPE_ic*'));
    input2 = dir(fullfile(input_dir2, filesep, 'nNPE_nc*'));        
    nP = length(input1);
    
    %% set model - full factorial design
    matlabbatch{1}.spm.stats.factorial_design.dir = cellstr(output_dir);

%     [input_filenames,dirs] = spm_select('List',input_dir1,'^*subj1.*\.nii$');    % load the *img files for this contrast
%     matlabbatch{1}.spm.stats.factorial_design.des.fd.icell(1).levels = [1 1];
%     matlabbatch{1}.spm.stats.factorial_design.des.fd.icell(1).scans  =  cellstr(strcat(input_dir1,filesep,input_filenames,',1'));
%    
    for i = 1:nP        
        
        matlabbatch{1}.spm.stats.factorial_design.des.pt.pair(i).scans = {            
            char(strcat(input_dir1, filesep, input1(i).name,',1'))            
            char(strcat(input_dir2, filesep, input2(i).name,',1'))            
            };        
    end  

    matlabbatch{1}.spm.stats.factorial_design.des.pt.gmsca = 0;
    matlabbatch{1}.spm.stats.factorial_design.des.pt.ancova = 0;              
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
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = ['ic-nc'];
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.convec = [1 -1];
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
        
    matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = ['nc-ic'];
    matlabbatch{3}.spm.stats.con.consess{2}.tcon.convec = [-1 1];
    matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
        
%     matlabbatch{3}.spm.stats.con.consess{3}.tcon.name = ['C-'];     % invalid contrast
%     matlabbatch{3}.spm.stats.con.consess{3}.tcon.convec = [-1 0];
%     matlabbatch{3}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
%     
%     matlabbatch{3}.spm.stats.con.consess{4}.tcon.name = ['NC-'];
%     matlabbatch{3}.spm.stats.con.consess{4}.tcon.convec = [0 -1];
%     matlabbatch{3}.spm.stats.con.consess{4}.tcon.sessrep = 'none';

%     matlabbatch{3}.spm.stats.con.consess{5}.tcon.name = ['C+'];   % invalid contrast
%     matlabbatch{3}.spm.stats.con.consess{5}.tcon.convec = [1 0];
%     matlabbatch{3}.spm.stats.con.consess{5}.tcon.sessrep = 'none';
%     
%     matlabbatch{3}.spm.stats.con.consess{6}.tcon.name = ['NC+'];  % invalid contrast
%     matlabbatch{3}.spm.stats.con.consess{6}.tcon.convec = [0 1];
%     matlabbatch{3}.spm.stats.con.consess{6}.tcon.sessrep = 'none';

    
    cd(output_dir);
    save 'batch_v31_5_nNPE_ic_nc_pt' matlabbatch;
    spm_jobman('run',matlabbatch);
    clear matlabbatch;


clear;
