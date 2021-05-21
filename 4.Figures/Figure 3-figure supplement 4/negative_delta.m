clear
load('C:\Users\SN\Google Drive\p1.UG2_fMRI\180422_eta.8\2.model\param.mat')
delta_ic = param_ic(:,5);
delta_nc = param_nc(:,5);

posd = find(delta_ic>0); % positive delta in C
delta_ic = delta_ic(posd);
delta_nc = delta_nc(posd);

load('C:\Users\SN\Google Drive\p1.UG2_fMRI\1.beh\001.UG2beh_ICvNC\results.mat')
M = M(posd,:);

offer_ic = M(:,1);
offer_nc = M(:,2);

rejL_ic = M(:,5);
rejL_nc = M(:,6);

rejM_ic = M(:,7);
rejM_nc = M(:,8);

rejH_ic = M(:,9);
rejH_nc = M(:,10);

pc_ic = M(:,15);
pc_nc = M(:,16);

x = {'offer', 'rejL', 'rejM', 'rejH', 'pc', 'delta'};
for i = 1:length(x)
    [h,p,ci,stat] = ttest(eval([x{i}, '_ic']), eval([x{i}, '_nc']));
    result(i,:) = [stat.df, stat.tstat, p];
end

[r1,p1] = corrcoef(delta_ic, delta_nc);
[r2,p2] = corrcoef(delta_ic, offer_ic);
[r3,p3] = corrcoef(pc_ic, pc_nc, 'Rows', 'pairwise');
