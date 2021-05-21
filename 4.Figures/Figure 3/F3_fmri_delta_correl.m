
load('sample1_fmri_participants\param.mat'); 
data1 = param_nc(:, 5); %x = data1
data2 = param_ic(:, 5); %y = data2


%% !UPDATE! Labels
xL = 'Expected influence (U)';
yL = 'Expected influence (C)';


%% Statistics
[r, p] = corrcoef(data1, data2, 'rows', 'pairwise'); % r = .76, p<.001
rr = sprintf('%.2f', r(2));
pp = sprintf('%.2f', p(2));
disp(['r = ', rr, ', p = ', pp]);


%% !UPDATE! Axis Limit
xlim = [-2 2];
ylim = [-2 2];


%% !UPDATE! Texts
text1 = ['r = ', rr, sprintf('\n p < 0.05')];
text1x = -1;
text1y = -1;


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
    'xLim', xlim, 'yLim', ylim, 'TickLength', [0 0], 'xtick', [-2 0 2], 'ytick', [-2 0 2]);

