clear
load('static_norm_cap2_t20_30trials_ic.mat')
static_ic = BIC;

load('static_norm_cap2_t20_30trials_nc.mat')
static_nc = BIC;

load('bic.mat')
nRv_ic = bic_ic(:,4);
nRv_nc = bic_nc(:,4);

dic = [static_ic nRv_ic static_nc nRv_nc];
dic_m = mean(dic);
dic_sd = std(dic);

[h,p,ci,stat] = ttest(dic(:,1), dic(:,2));
[h2,p2,ci2,stat2] = ttest(dic(:,3), dic(:,4));