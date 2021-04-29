clear;
outdir = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\180422_eta.8\4.pmod\v28';
mkdir(outdir);
% outfile = pmod_3TB0000.mat'

pmod = struct('name', [], 'block1', [], 'block2', []); 

pmod.name = {'offer', 'pre_norm', 'post_norm', ...
    'nPE', 'weighted_nPE', ...
    'norm_violation', 'aversion', ...
    'xV', 'Vgap', 'V_accept'};


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
OFFER_ic = OFFER;
RESP_ic = RESP;
X_ic = X(:,:,2); % f0


%% NC
NCfile = 'nRv_6models_cap2_t20_30trials_NC.mat';
load(fullfile(indir, NCfile));
ID_nc = ID;
OFFER_nc = OFFER;
RESP_nc = RESP;
X_nc = X(:,:,2); % f0


%%  Assign values to pmod struct

for i = 1:length(A)  
    
    ic = nRv_f0_t20_pmod_z(OFFER_ic{i}, RESP_ic{i}, fixed, X_ic(i,:));
    nc = nRv_f0_t20_pmod_z(OFFER_nc{i}, RESP_nc{i}, fixed, X_nc(i,:));    
    
    if A(i).order == 1    % IC first, NC second

            pmod.block1 = ic;
            pmod.block2 = nc;

        elseif A(i).order == 2    % NC first, IC second

            pmod.block1 = nc;
            pmod.block2 = ic;
    end
    
    IC(i) = ic;
    NC(i) = nc;
    
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
            
    
    save(fullfile(outdir, ['pmod_', id, '.mat']), 'pmod');
    
end

save('pmod_v28_f0_normalized.mat', 'IC', 'NC', 'idmatch');
clear;
