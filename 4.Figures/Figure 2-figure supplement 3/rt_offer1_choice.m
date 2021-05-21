%% RT = offer1 ~ choice(button press)

% 1) why chose offer1 (when the offers were first revealed) 
% instead of offer2 (when the buttons were supposed to be activated)

% --> Too many button press b/w offer1 and offer2 
%       647(683-36) trials out of 4560 trials = 57 subj * 80 trials)

% 2) Button press before offer1 
%       (36 trials; of which 18 trials are in the first 5 rounds of IC)

% --> Re-coded to 0 instead of neg RT     


clear
wd = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\210125_eLife_revision';
cd('C:\Users\SN\Google Drive\1.Tasks\old\UG2_fMRI_2016\3.Data\beh');
beh_files = dir('UG_*');

% t_data 
% column3 offer1 onset
% column4 offer2 onset (1sec after offer1)
% column5 choice submission 
% column6 reward onset
% rt = column5 - column3
rt0_col = 3; % offer1 column
rt1_col = 5; % choice column

nP = length(beh_files);
subj = cell(nP,1);
rt_ic = nan(nP, 40);
rt_nc = nan(nP, 40);

for i = 1:nP
    filename = beh_files(i).name;
    load(filename)
    x = strsplit(filename, {'_', '.'});
    subj{i,1} = x{2};

    if cond == 1
        ic_row = 1:40;
        nc_row = 81:120;
        
    elseif cond == 2
        nc_row = 1:40;
        ic_row = 81:120;        
    end
        
    rt_ic(i,:) = [t_data(ic_row, rt1_col) - t_data(ic_row, rt0_col)]';
    rt_nc(i,:) = [t_data(nc_row, rt1_col) - t_data(nc_row, rt0_col)]';   
    
end

neg_rt_ic = find(rt_ic<0);
neg_rt_nc = find(rt_nc<0);

rt_ic(neg_rt_ic) = 0;
rt_nc(neg_rt_nc) = 0;

cd(wd)
save('rt_offer1_choice.mat', 'subj', 'rt_ic', 'rt_nc', 'neg_rt_ic', 'neg_rt_nc')
clear
