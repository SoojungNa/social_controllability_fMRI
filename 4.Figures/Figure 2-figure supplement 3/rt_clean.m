clear;

load('rt_offer1_choice.mat')

% Cleaning
if strcmp(subj{11}, 'B4S7T') &&  strcmp(subj{12}, 'B4S7Tb')
    % B4S7T=NC, B4S7Tb=IC
    rt_nc(11,:) = rt_ic(11,:);
    rt_ic(11,:) = rt_nc(12,:);    
    disp('B4S7T done')
end
 
if strcmp(subj{28}, 'G67HJ') &&  strcmp(subj{29}, 'G67HJb')
    % G67HJ=IC, G67HJb=NC    
    rt_nc(28,:) = rt_ic(29,:);
    disp('G67HJ done')
end

% 48 subj
load('C:\Users\SN\Google Drive\p1.UG2_fMRI\1.beh\000.dataOrg\IDmatch48.mat')
id_beh = IDmatch48(:,1);
nP = length(id_beh);

for i = 1:nP
    [~, idx(i,1)] = ismember(id_beh{i}, subj);  % vlookup        
end

subj = subj(idx);
rt_ic = rt_ic(idx,:);
rt_nc = rt_nc(idx,:);

% GLM
load('C:\Users\SN\Google Drive\p1.UG2_fMRI\1.beh\000.dataOrg\beh02_clean.mat')
for i = 1:nP
    trials_ic = find(A(i).IC.R.xR>5 & A(i).IC.R.xR<36);    
    trials_nc = find(A(i).NC.R.xR>5 & A(i).NC.R.xR<36);
    
    pmod_rt_ic{i,1} = rt_ic(i, trials_ic);
    pmod_rt_nc{i,1} = rt_nc(i, trials_nc);    
end

save('rt_clean.mat', 'subj', 'rt_ic', 'rt_nc', 'pmod_rt_ic', 'pmod_rt_nc')
clear