event = struct('name', [], 'block1', [], 'block2', []); 

outdir = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\180422_eta.8\3.event\v1';
mkdir(outdir);
% outfile = event_3TB0000.mat'

event.name = ...
    {'offerOnset', ...
    'choiceSubmission', ...
    'outcomeOnset', ...
    'emoSubmission'};

% t_data
indir = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\180416\1.data\beh_48';

% Responded trials
load('C:\Users\SN\Google Drive\p1.UG2_fMRI\180416\1.data\beh02_clean.mat');

% idmatch file (to convert from beh id to scan id)
load('C:\Users\SN\Google Drive\p1.UG2_fMRI\180416\4.fMRI\idmatch.mat');



cd(indir)
subj = dir('UG_*');

for i = 1:length(subj)
    
    % beh ID -> scan ID
    x = strsplit(subj(i).name, {'_', '.'});
    id_beh = x{2};
    [~, idx] = ismember(id_beh, idmatch(:, 1));  % vlookup
    id = idmatch{idx, 2};
    
    % Check if ID matches b/w t_data and xR data
    if i ~= 10 && i ~= 25   %10 'B4S7Tb', 25 'G67HJb'
        if id_beh ~= A(i).ID
            break
        end
    end
    
    load(subj(i).name);
    
    % In control - responded trials
    Ric = A(i).IC.R.xR;
    Ric = Ric(Ric>5 & Ric<36);  % 30 trials
    
    % No control - responded trials
    Rnc = A(i).NC.R.xR;
    Rnc = Rnc(Rnc>5 & Rnc<36);
    
    % In control - responded trials (& emotion ratings asked)
    Eic = A(i).IC.R.xEA;
    Eic = Eic(Eic>5 & Eic<36);
    
    % No control - responded trials (& emotion ratings asked)
    Enc = A(i).NC.R.xEA;
    Enc = Enc(Enc>5 & Enc<36);
    
    o_c = t_data(Ric, 3)';             
    o_u = t_data(Rnc+80, 3)';   % offer onset

    c_c = t_data(Ric, 5)';             
    c_u = t_data(Rnc+80, 5)';   % choice submission

    r_c = t_data(Ric, 6)';              
    r_u = t_data(Rnc+80, 6)';   % outcome onset 

    e_c = t_data(Eic, 9)';             
    e_u = t_data(Enc+80, 9)';   % emotion submission

    trigger1 = t_data(3,1);     % trigger of block 1
    trigger2 = t_data(5,1);     % trigger of block 2
    
    ev_c = {o_c; c_c; r_c; e_c};    % in control condition events
    ev_u = {o_u; c_u; r_u; e_u};    % no control condition events
    
    if cond == 1    % IC first, NC second
        
        event.block1 = cellfun(@(x) x-trigger1, ev_c, 'UniformOutput',false);
        event.block2 = cellfun(@(x) x-trigger2, ev_u, 'UniformOutput',false);
    
    elseif cond == 2    % NC first, IC second
        
        event.block1 = cellfun(@(x) x-trigger1, ev_u, 'UniformOutput',false);
        event.block2 = cellfun(@(x) x-trigger2, ev_c, 'UniformOutput',false);        
    
    end
    
    order = cond; % cond is function name in spm?
    save(fullfile(outdir, ['event_', id, '.mat']), 'event', 'order');
    
end

clear;