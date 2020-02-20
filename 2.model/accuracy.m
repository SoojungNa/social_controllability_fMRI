clear;
cd('C:\Users\SN\Google Drive\p1.UG2_fMRI\180422_eta.8\2.model')

%% IC
load('nRv_6models_cap2_t20_30trials_IC.mat') % RESP 48x1 cell
load('recover_nRv_f3_cap2_t20_etaf_IC.mat') %Rsim 48x1 cell
for i = 1:length(RESP)
    match{i} = RESP{i}' == Rsim{i};
    accuracyRate(i,1) = sum(match{i}==1)/length(match{i});
end
ic.RESP = RESP;
ic.Rsim = Rsim;
ic.match = match;
ic.accuracyRate = accuracyRate;
ic.accuracyRate_mean = mean(ic.accuracyRate);

%% NC
load('nRv_6models_cap2_t20_30trials_NC.mat') % RESP 48x1 cell
load('recover_nRv_f3_cap2_t20_etaf_NC.mat') %Rsim 48x1 cell
for i = 1:length(RESP)
    match{i} = RESP{i}' == Rsim{i};
    accuracyRate(i,1) = sum(match{i}==1)/length(match{i});
end
nc.RESP = RESP;
nc.Rsim = Rsim;
nc.match = match;
nc.accuracyRate = accuracyRate;
nc.accuracyRate_mean = mean(nc.accuracyRate);

save('accuracy.mat', 'ic', 'nc')