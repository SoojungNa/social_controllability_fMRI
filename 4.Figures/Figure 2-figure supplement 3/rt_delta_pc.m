clear
% pc
load('C:\Users\SN\Google Drive\p1.UG2_fMRI\180422_eta.8\2.model\pc.mat')

% delta
load('C:\Users\SN\Google Drive\p1.UG2_fMRI\180422_eta.8\2.model\param.mat')
delta_ic = param_ic(:,5);
delta_nc = param_nc(:,5);

% rt
load('C:\Users\SN\Google Drive\p1.UG2_fMRI\210125_eLife_revision\rt_clean.mat')

m_rt_ic = mean(rt_ic, 2);
m_rt_nc = mean(rt_nc, 2);

X_ic = [delta_ic pc_ic m_rt_ic ];
[r1,p1] = corrcoef(X_ic, 'Rows', 'pairwise');

X_nc = [delta_nc pc_nc m_rt_nc];
[r2,p2] = corrcoef(X_nc, 'Rows', 'pairwise');

% xl = {'delta_ic' 'delta_nc' 'pc_ic' 'pc_nc' 'rt_ic' 'rt_nc'};
% yl = xl;
% h = heatmap(xl, yl, r, 'Colormap', jet);
% caxis([-1 1]);

save('rt_delta_pc.mat', 'delta_ic', 'pc_ic', 'm_rt_ic', 'delta_nc', 'pc_nc', 'm_rt_nc')
