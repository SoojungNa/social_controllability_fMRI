clear
folder = '210322_100';

cd(folder)
files_ic = dir('*_ic*.mat');
files_nc = dir('*_nc*.mat');

[PARAM_ic, DIC_ic, BEST_ic] = param_dic1(files_ic);
[CM0_ic, CM1_ic, DIC0_ic, DIC1_ic] = inv_temp1(PARAM_ic, DIC_ic, BEST_ic);

[PARAM_nc, DIC_nc, BEST_nc] = param_dic1(files_nc);
[CM0_nc, CM1_nc, DIC0_nc, DIC1_nc] = inv_temp1(PARAM_nc, DIC_nc, BEST_nc);

allcm0_nc = zeros(6,6);
allcm0_nc(DIC0_nc == min(DIC0_nc, [], 2)) = 1;

allcm1_nc = zeros(6,6);
allcm1_nc(DIC1_nc == min(DIC1_nc, [], 2)) = 1;

allcm0_ic = zeros(6,6);
allcm0_ic(DIC0_ic == min(DIC0_ic, [], 2)) = 1;

allcm1_ic = zeros(6,6);
allcm1_ic(DIC1_ic == min(DIC1_ic, [], 2)) = 1;

F = figure();
subplot(2,4,1)
heatmap(CM0_ic)
title('indiv_win_IC: inv temp<1')

subplot(2,4,2)
heatmap(CM1_ic)
title('indiv_win_IC: inv temp>=1')

subplot(2,4,3)
heatmap(allcm0_ic)
title('dic_sum_IC: inv temp<1')

subplot(2,4,4)
heatmap(allcm1_ic)
title('dic_sum_IC: inv temp>=1')


subplot(2,4,5)
heatmap(CM0_nc)
title('indiv_win_NC: inv temp<1')

subplot(2,4,6)
heatmap(CM1_nc)
title('indiv_win_NC: inv temp>=1')

subplot(2,4,7)
heatmap(allcm0_nc)
title('dic_sum_NC: inv temp<1')

subplot(2,4,8)
heatmap(allcm1_nc)
title('dic_sum_NC: inv temp>=1')



% Compile all files
function [PARAM, DIC, BEST] = param_dic1(files)
    PARAM = [];
    DIC = [];
    BEST = [];
    
    for i = 1:length(files)
        
        load(files(i).name)
        
        
        PARAM = [PARAM; param{1}];
        
        dic_cell = cellfun(@(x) x{2}, results,'UniformOutput',false);
        dic = reshape(cell2mat(dic_cell), 48, 6, 6); %indiv, est, simul
        DIC = [DIC; dic];
        
        best_cell = cellfun(@(x) x{1}, results,'UniformOutput',false);
        best = reshape(cell2mat(best_cell), 48, 6, 6); %indiv, est, simul
        BEST = [BEST; best];
    end
end

% split two groups at inverse temperature = 1
function [CM0, CM1, DIC0, DIC1] = inv_temp1(PARAM, DIC, BEST)
    for m = 1:6
        inv_temp = PARAM(:,1,m);
        CM0(m,:) = sum(BEST(inv_temp<1,:,m));
        CM1(m,:) = sum(BEST(inv_temp>=1,:,m));    

        DIC0(m,:) = sum(DIC(inv_temp<1,:,m));
        DIC1(m,:) = sum(DIC(inv_temp>=1,:,m));    
    end
end