close all
clear;
addpath(genpath('C:\Users\SN\Google Drive\z.functions'));


%% !UPDATE! Ouput
folder = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\180422_eta.8';

roi_folder = fullfile(folder,'7.roi', '201025_6_52_-16_Feng2015_8mm');
outfile = fullfile(roi_folder, 'plot', 'plot_correl_gap_vmPFC_ic.pdf');



%% !UPDATE! Data [nP x 1]
load(fullfile(folder, '6.group', 'covariates.mat')); 
data1 = normalize(pc_ic_nan) - normalize(delta_ic);


load(fullfile(roi_folder, 'results', 'f2_v26.mat')); 
data2 = result(:,1); %y = data2



%% !UPDATE! Labels
xL = 'Belief disconnection (C)';
%xL = ['Discrepancy in belief' sprintf('\n controllability (C)')];
yL = 'vmPFC coefficient (C)';
% to change the line:
% e.g., [sprintf('Self-reported \n perceived control'), ' (%)']


%% Statistics
[r, p] = corrcoef(data1, data2, 'rows', 'pairwise'); % r = .76, p<.001
rr = sprintf('%.2f', r(2));
pp = sprintf('%.10f', p(2));
disp(['r = ', rr, ', p = ', pp]);


%% !UPDATE! Axis Limit
xlim = [-5 5];
ylim = [-3 4];



%% !UPDATE! Texts
text1 = ['r = ', rr, '*'];
%text1 = ['r = ', rr, sprintf('\n p < 10^{-9}')];
text1x = -1; % center
text1y = 2; % bottom of th efirst line


%% Dots
x = data1;
y = data2;


%% Dot formats (size/color)
% c = uisetcolor
dsz = 5;        % dot size
Blue1 = [.27 .47 .78];  %70 120 200     dark
Grey1 = [.4 .4 .4];     %102 102 102    dark -- for dot2


%% Size & Position
w = 105;    % chart width 120
h = 110;    % chart height 125
blank = 20;
xlabelspace = 30;   % one line = 15, two lines = 30
ylabelspace = 30;
Fw = w + 2*blank + ylabelspace;
Fh = h + 2*blank + xlabelspace;
F = figure('Position', [500 300 Fw Fh]); % left BOTTOM width height

subplot('Position', ...
    [(blank+ylabelspace)/Fw (blank+xlabelspace)/Fh w/Fw h/Fh]) 
    % left TOP width height
    
        
%% Draw charts
s1 = scatter(x, y, dsz, Blue1, 'filled');
lsline

hold on

% s2 = text(text1x, text1y, text1, ...
%          'HorizontalAlignment', 'center', 'FontName', 'Arial', 'FontSize', 8);

xlabel(xL);
ylabel(yL);
ytickformat('%3.0f');
xtickformat('%3.0f');

set(gca, 'box', 'off', 'FontName', 'Arial', 'FontSize', 8, ...
    'xLim', xlim, 'yLim', ylim, 'TickLength', [0 0], 'xtick', [-5 0 5], 'ytick', [-3 0 4]);

saveas(F, outfile);
