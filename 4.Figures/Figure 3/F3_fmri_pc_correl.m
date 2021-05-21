
load('sample1_fmri_participants\pc.mat'); 
data1 = pc_nc; %y = data2
data2 = pc_ic;

%% !UPDATE! Labels
xL = ['Self-reported' sprintf('\n controllability (U)')];
yL = ['Self-reported' sprintf('\n controllability (C)')];


%% Statistics
[r, p] = corrcoef(data1, data2, 'rows', 'pairwise'); % r = .76, p<.001
rr = sprintf('%.2f', r(2));
pp = sprintf('%.4f', p(2));
disp(['r = ', rr, ', p = ', pp]);


%% !UPDATE! Axis Limit
xlim = [0 100];
ylim = [0 100];


%% !UPDATE! Texts
text1 = ['r = ', rr, sprintf('\np = 0.26')];
text1x = 25;
text1y = 20;


%% Dots
x = data1;
y = data2;


%% Dot formats (size/color)
% c = uisetcolor
dsz = 5;        % dot size
Blue1 = [.27 .47 .78];  %70 120 200     dark
   
        
%% Draw charts
s1 = scatter(x, y, dsz, 'k', 'filled');
lsline

hold on

xlabel(xL);
ylabel(yL);
ytickformat('%3.0f');
xtickformat('%3.0f');

set(gca, 'box', 'off', 'FontName', 'Arial', 'FontSize', 8, ...
    'xLim', xlim, 'yLim', ylim, 'TickLength', [0 0], 'xtick', [0 50 100], 'ytick', [0 50 100]);
