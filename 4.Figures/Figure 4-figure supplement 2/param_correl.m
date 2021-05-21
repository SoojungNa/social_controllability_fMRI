clear
addpath('C:\Users\SN\Google Drive\z.functions\plots');

load('C:\Users\SN\Google Drive\p1.UG2_fMRI\180422_eta.8\2.model\param.mat')
param_ic_fmri = param_ic;
param_nc_fmri = param_nc;
param_name = {'Beta', 'Alpha', 'f0', 'Epsilon', 'Delta'};

load('C:\Users\SN\Google Drive\p22.UG2_covid\200403_t1\2.model\param_20t.mat')
param_ic_online = param_ic{4}(:,1:5);
param_nc_online = param_nc{4}(:,1:5);


[r1,p1] = corrcoef(param_ic_fmri);
[r2,p2] = corrcoef(param_nc_fmri);
[r3,p3] = corrcoef(param_ic_online);
[r4,p4] = corrcoef(param_nc_online);
R = [r1 r2 r3 r4];
P = [p1 p2 p3 p4];

%% Figure

w = 150;    % chart width 120
h = 150;    % chart height
blank = 20;
xlabelspace = 15;%15;
ylabelspace = 70;%30;
Fw = w + 2*blank + ylabelspace;
Fh = h + 2*blank + xlabelspace;
F = figure('Position', [500 300 Fw Fh]); % left BOTTOM width height
subplot('Position', ...
[(blank+ylabelspace-40)/Fw (blank+xlabelspace+10)/Fh w/Fw h/Fh]) 

correlmap_name = 'r1.pdf';
h = heatmap(r1);

h.Colormap = jet; % Choose jet or any other color scheme
caxis([-1 1])
h.XDisplayLabels = param_name;
h.YDisplayLabels = param_name;
h.ColorbarVisible = 'on';
h.GridVisible = 'off';
h.CellLabelFormat = '%.2f';
h.FontName = 'Arial';
h.FontSize = 6;

saveas(h, correlmap_name);
