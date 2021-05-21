
load('sample1_fmri_participants\bic.mat'); 
data1 = bic_nc(:, 1);
data2 = bic_nc(:, 2);
data3 = bic_nc(:, 3);
data4 = bic_nc(:, 4);
data5 = bic_nc(:, 5);
data6 = bic_nc(:, 6);


%% !UPDATE! Labels
yAxisTitle = 'DIC score';
xTickLabels = {'MF','0-step', '1-step', '2-step', '3-step', '4-step'};


%% !UPDATE! Axis Limit
xlim = [0.5 6.5];
ylim = [5 25];


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
s1.CData(1,:) = Grey0;
s1.CData(2,:) = Grey0;
s1.CData(3,:) = Grey0;
s1.CData(4,:) = Grey0;
s1.CData(5,:) = Grey0;
s1.CData(6,:) = Grey0;

hold on
s2 = errorbar(x1, y1, std(bic_nc)/sqrt(48));
s2.Color = Grey1;                            
s2.LineStyle = 'none'; 

hold on

    
ylabel(yAxisTitle);
ytickformat('%3.0f');
xtickangle(45);
set(gca, 'box', 'off', 'FontName', 'Arial', 'FontSize', 8, ...
    'xLim', xlim, 'yLim', ylim, 'TickLength', [0 0], 'xticklabel', xTickLabels);
