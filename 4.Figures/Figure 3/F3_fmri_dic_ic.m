
load('sample1_fmri_participants\bic.mat'); 
data1 = bic_ic(:, 1);
data2 = bic_ic(:, 2);
data3 = bic_ic(:, 3);
data4 = bic_ic(:, 4);
data5 = bic_ic(:, 5);
data6 = bic_ic(:, 6);


%% !UPDATE! Labels
yAxisTitle = 'DIC score';
xTickLabels = {'MF','0-step', '1-step', '2-step', '3-step', '4-step'};
% to change the line:
% e.g., [sprintf('Self-reported \n perceived control'), ' (%)']


%% !UPDATE! Axis Limit
xlim = [0.5 6.5];
ylim = [5 25];


%% !UPDATE! Texts
% linex = [1.2 1.8];
% liney = 1.5 * ones(1,2);
% text1 = '**';
% textx = mean(linex);
% texty = 0.1 + liney(1);  % '*' 1.03, 'n.s.' 1.07


%% 1. Bar
x1 = [1 2 3 4 5 6];
y1 = [mean(data1) mean(data2) mean(data3) mean(data4) mean(data5) mean(data6)];


%% Color
% c = uisetcolor
Blue0 = [0.6 0.8 1];    %153 204 255    light -- for bar1
Blue1 = [.27 .47 .78];  %70 120 200     dark -- for dot1
Grey0 = [.67 .67 .67];  %170 170 170    light -- for bar2
Grey1 = [.4 .4 .4];     %102 102 102    dark -- for dot2

    
%% Draw charts
s1 = bar(x1, y1, 0.5, 'FaceColor', 'flat', 'EdgeColor', 'none');
s1.CData(1,:) = Blue0;
s1.CData(2,:) = Blue0;
s1.CData(3,:) = Blue0;
s1.CData(4,:) = Blue0;
s1.CData(5,:) = Blue0;
s1.CData(6,:) = Blue0;

hold on
s2 = errorbar(x1, y1, std(bic_ic)/sqrt(48));
s2.Color = Blue1;                            
s2.LineStyle = 'none'; 

hold on

    
ylabel(yAxisTitle);
ytickformat('%3.0f');
xtickangle(45);
set(gca, 'box', 'off', 'FontName', 'Arial', 'FontSize', 8, ...
    'xLim', xlim, 'yLim', ylim, 'TickLength', [0 0], 'xticklabel', xTickLabels);
