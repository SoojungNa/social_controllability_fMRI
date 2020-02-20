function run_UG2_indiv_v1_xV(varargin)

data_dir = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\3.fMRI\data_preproc';
output_dir = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\180422_eta.8\5.indiv\v1_xV';
event_dir = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\180422_eta.8\3.event\v1';
pmod_dir = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\180422_eta.8\4.pmod\v1';

cd(data_dir)
subdirs = dir('3TB*');

for i= 1:length(subdirs)  % exclude . and .. folders, but be aware of the hidden files and folders
    subj{i} = subdirs(i).name;
end


% execute batch jobs
for i= 1:length(subj)
    
    data_path = fullfile(data_dir, subj{i});  
    output_path_ic = fullfile(output_dir, 'IC', subj{i});  
    output_path_nc = fullfile(output_dir, 'NC', subj{i});  
    mkdir(output_path_ic);
    mkdir(output_path_nc);
    
    cd(data_path)
    sw1 = dir('*UG1*.nii');
    sw1 = strcat(sw1.folder, '\', sw1.name);
    
    sw2 = dir('*UG2*.nii');
    sw2 = strcat(sw2.folder, '\', sw2.name);
    
    rp1 = dir('*UG1*.txt');
    rp1 = strcat(rp1.folder, '\', rp1.name);
    
    rp2 = dir('*UG2*.txt');
    rp2 = strcat(rp2.folder, '\', rp2.name);
    
   
    %% load event.mat and pmod.mat files
    load(fullfile(event_dir, strcat('event_', subj{i}, '.mat')));        
    load(fullfile(pmod_dir, strcat('pmod_', subj{i}, '.mat')));        
    
    
    %% run analysis    
    if order == 1        
        UG2_indiv_v1_xV_cond1_ic;                
        UG2_indiv_v1_xV_cond1_nc; 
    elseif order == 2        
        UG2_indiv_v1_xV_cond2_ic;
        UG2_indiv_v1_xV_cond2_nc;
    end

    
    cd ..
    clear matlabbatch;

end
