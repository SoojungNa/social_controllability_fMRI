function run_UG2_indiv_v26_f2_nxV_2blocks(varargin)

    rmpath(genpath('C:\Users\SN\Google Drive\z.programs\marsbar-0.44'));

    data_dir = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\3.fMRI\data_preproc';
    output_dir = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\180422_eta.8\5.indiv\v26_f2_nxV_2blocks';
    event_dir = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\180422_eta.8\3.event\v1';
    pmod_dir = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\180422_eta.8\4.pmod\v26';

    %% Update!
    pmod_name = 'nxV'; % for v26 where 'pmod' has substructs with matching field names
    pmod_event = 2; % event_v1: 1=offer, 2=choice submitted, 3=outcome, 4=emotion submitted

    cd(data_dir)
    subdirs = dir('3TB*');

    for i= 1:length(subdirs)  % exclude . and .. folders, but be aware of the hidden files and folders
        subj{i} = subdirs(i).name;
    end

    % execute batch jobs
    for i= 1:length(subj) % 17 3128

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
        UG2_indiv_t1_2blocks_1pmod;


        cd ..
        clear matlabbatch;

    end
end
