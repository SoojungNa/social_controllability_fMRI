
%% Plot inputs
load('sample1_fmri_participants\param.mat'); 
data = [param_ic(:, 5) param_nc(:, 5)];

x_tick_labels = {'C','U'};
x_tick = [1 2];
xlim = [0.5 2.5];

y_title = 'Expected influence';
% [sprintf('Self-reported \n perceived control'), ' (%)'];
ylim = [-2 2.1];

% Mean line
design.s1.color = black;
design.s1.linewidth = 1.5;

% SEM patch
design.s2.color = black;
design.s2.fa = 0.3;

% Individual lines
design.s3.color = grey_light;           % black
design.s3.fa = 0.3; %0.3

% Draw plot
plot_lines08(data, ...
    x_tick_labels, x_tick, xlim, ...
    y_title, ylim, ...
    design);
