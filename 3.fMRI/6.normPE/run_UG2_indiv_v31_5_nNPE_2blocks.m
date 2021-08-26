function run_UG2_indiv_v31_5_nNPE_2blocks(varargin)

    %rmpath(genpath('C:\Users\SN\Google Drive\z.programs\marsbar-0.44'));

    data_dir = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\3.fMRI\data_preproc';
    output_dir = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\210125_eLife_revision\indiv\v31_5';
    event_dir = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\180422_eta.8\3.event\v1';
    pmod_dir = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\210125_eLife_revision\pmod\v31';

    %% Update!
    pmod_name = 'nNPE'; % for v26 where 'pmod' has substructs with matching field names
    pmod_event = 1; % event_v1: 1=offer, 2=choice submitted, 3=outcome, 4=emotion submitted

    cd(data_dir)
    subdirs = dir('3TB*');

    for i= 1:length(subdirs)  % exclude . and .. folders, but be aware of the hidden files and folders
        subj{i} = subdirs(i).name;
    end

    % execute batch jobs
    for i= 48:length(subj) % 39 3276 / 40 3285 / 41 3286 / 44 3299 / 46 3304
        % 47 3309

        data_path = fullfile(data_dir, subj{i});  
        output_path = fullfile(output_dir, subj{i});                  
        mkdir(output_path);

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
        UG2_indiv_t1_2blocks_1pmod_event;


        cd ..
        clear matlabbatch;

    end
end