clear;
addpath(genpath('C:\Users\SN\Google Drive\z.functions\plots'));
load('C:\Users\SN\Google Drive\z.functions\plots\colors.mat');

outdir = cd;
outfile = 'plot_lines07_pc_grey.pdf';


%% Plot inputs
load('C:\Users\SN\Google Drive\p22.UG2_covid\200403_t1\2.model\pc.mat');
data = [pc_ic pc_nc];

x_tick_labels = {'C','U'};
x_tick = [1 2];
xlim = [0.5 2.5];

y_title = [sprintf('Self-reported \n controllability'), ' (%)'];
ylim = [0 100];


% Mean line
design.s1.color = black;
design.s1.linewidth = 1.5;

% SEM patch
design.s2.color = black;
design.s2.fa = 0.3;

% Individual lines
design.s3.color = grey_light;           % black
% design.s3.color_up = '';        % blue2
% design.s3.color_down = '';      % red2
% design.s3.color_stay = '';      % black
% design.s3.colormap = 'jet';     % 'jet', 'parula'
design.s3.fa = 0.3; %0.3


% Draw plot
F = plot_lines07(data, ...
    x_tick_labels, x_tick, xlim, ...
    y_title, ylim, ...
    design);

%ytickformat('%3.0f');

% Save
cd(outdir);
saveas(F, outfile);