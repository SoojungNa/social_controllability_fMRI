% 2019.10.4
% pmod: (1) norm(2) normPE (3) aversion (alpha*())
% Model: f3_cap2_t20_etaf

outdir = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\180422_eta.8\4.pmod\v6';
mkdir(outdir);
% outfile = pmod_3TB0000.mat'

pmod = struct('name', [], 'block1', [], 'block2', []); 

pmod.name = {'norm', 'normPE', 'aversion', ...    
    };


% idmatch file (to convert from beh id to scan id)
load('C:\Users\SN\Google Drive\p1.UG2_fMRI\180416\4.fMRI\idmatch.mat');

% for checking ID and order
load('C:\Users\SN\Google Drive\p1.UG2_fMRI\180416\1.data\beh02_clean.mat');

% model directory
addpath(genpath('C:\Users\SN\Google Drive\z.functions\models'));
addpath 'C:\Users\SN\Google Drive\p1.UG2_fMRI\180422_eta.8\2.model';


%% IC
indir = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\180422_eta.8\2.model';
ICfile = 'nRv_6models_cap2_t20_30trials_IC.mat';
load(fullfile(indir, ICfile));

ID_ic = ID;

for i = 1:length(ID)
    [IC_norm{i}, IC_normPE{i}, IC_aversion{i}] = ...
        pmod_nRv_norm(OFFER{i}, param(i,:,4));        
end



%% NC
NCfile = 'nRv_6models_cap2_t20_30trials_NC.mat';
load(fullfile(indir, NCfile));

ID_nc = ID;

for i = 1:length(ID)
    [NC_norm{i}, NC_normPE{i}, NC_aversion{i}] = ...
        pmod_nRv_norm(OFFER{i}, param(i,:,4));        
end


%%  Assign values to pmod struct
for i = 1:length(A)  
    
    % Check if ID matches       
    if strcmp(ID_ic{i}, ID_nc{i})==0     
        disp('?')
        break
    end
    
        
    % beh ID -> scan ID    
    ID{10} = 'B4S7T';   %10 'B4S7Tb' 
    ID{25} = 'G67HJ';   %25 'G67HJb'
    [~, idx] = ismember(ID{i}, idmatch(:, 1));  % vlookup
    id = idmatch{idx, 2};
    
    
    if A(i).order == 1    % IC first, NC second

            pmod.block1 = {IC_norm{i}, IC_normPE{i}, IC_aversion{i}};
            pmod.block2 = {NC_norm{i}, NC_normPE{i}, NC_aversion{i}};

        elseif A(i).order == 2    % NC first, IC second

            pmod.block1 = {NC_norm{i}, NC_normPE{i}, NC_aversion{i}};
            pmod.block2 = {IC_norm{i}, IC_normPE{i}, IC_aversion{i}};

    end
    
    save(fullfile(outdir, ['pmod_', id, '.mat']), 'pmod');
    
end
    
clear;