
load('sample3_online_participants\param_20t.mat'); 
data1 = param_ic{4}(:, 5); %x = data1

load('sample3_online_participants\offer.mat'); 
data2 = offer_ic; %y = data2



%% !UPDATE! Labels
xL = 'Expected influence (C)';
yL = 'Mean offer (C)';


%% Statistics
[r, p] = corrcoef(data1, data2, 'rows', 'pairwise'); % r = .76, p<.001
rr = sprintf('%.2f', r(2));
pp = sprintf('%.10f', p(2));
disp(['r = ', rr, ', p = ', pp]);


%% !UPDATE! Axis Limit
xlim = [-2 2];
ylim = [0 10];


%% !UPDATE! Texts
text1 = ['r = ', rr, sprintf('\n p < 10^{-61}')];
text1x = -1; % center
text1y = 8; % bottom of th efirst line


%% Dots
x = data1;
y = data2;


%% Dot formats (size/color)
% c = uisetcolor
dsz = 2;        % dot size
Blue0 = [0.6 0.8 1];    %153 204 255    light
Blue1 = [.27 .47 .78];  %70 120 200     dark
ic_dot_color = Blue1;  %70 120 200     dark


%% Draw charts
s1 = scatter(x, y, dsz, ic_dot_color, 'filled');
s1.MarkerFaceAlpha = 0.3;
h = lsline;

hold on

xlabel(xL);
ylabel(yL);
ytickformat('%3.0f');
xtickformat('%3.0f');

set(gca, 'box', 'off', 'FontName', 'Arial', 'FontSize', 8, ...
    'xLim', xlim, 'yLim', ylim, 'TickLength', [0 0], 'xtick', [-2 0 2], 'ytick', [0 5 10]);