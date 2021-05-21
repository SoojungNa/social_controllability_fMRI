clear;
%addpath(genpath('C:\Users\SN\Google Drive\z.functions\plots'));
%load('C:\Users\SN\Google Drive\z.functions\plots\colors.mat');
addpath(genpath(cd))
load('plot_format\colors.mat');

outfile = 'pos_delta_online_offer.pdf';

load('sample3_online_participants\param_20t.mat')
delta_ic = param_ic{4}(:,5);
posd = find(delta_ic>0); % positive delta in C


%% Plot inputs
load('sample3_online_participants\offer.mat'); 
data = [offer_ic(posd) offer_nc(posd)];
[h,p,ci,stat] = ttest(data(:,1), data(:,2));
ttest_result = [stat.df, stat.tstat, p];

x_tick_labels = {'C','U'};
x_tick = [1 2];
xlim = [0.5 2.5];

y_title = 'Mean offer size ($)';
% [sprintf('Self-reported \n perceived control'), ' (%)'];
ylim = [0 10];


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
% design.s3.colormap = 'parula';     % 'jet', 'parula'
design.s3.fa = 0.3; %0.3


% Draw plot
F = plot_lines07(data, ...
    x_tick_labels, x_tick, xlim, ...
    y_title, ylim, ...
    design);

%ytickformat('%3.0f');

% Save
saveas(F, outfile);