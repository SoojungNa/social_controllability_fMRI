clear;
addpath(genpath(cd));
load('plot_format\colors.mat');

load('sample1_fmri_participants\param.mat')
delta_ic = param_ic(:,5);
posd = find(delta_ic>0); % positive delta in C

outfile = 'pos_delta_fmri_pc.pdf';


%% Plot inputs
load('sample1_fmri_participants\pc.mat');
data = [pc_ic(posd) pc_nc(posd)];
[h,p,ci,stat] = ttest(data(:,1), data(:,2));
ttest_result = [stat.df, stat.tstat, p];

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
saveas(F, outfile);