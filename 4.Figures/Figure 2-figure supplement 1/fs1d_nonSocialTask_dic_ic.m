close all
clear;
addpath(genpath('C:\Users\SN\Google Drive\z.functions'));

%% !UPDATE! Ouput
outdir = 'C:\Users\SN\Google Drive\p3.UG2_computer_beh\2.model';
outfile = fullfile(outdir, 'plot_compare_dic_ic_sem.pdf');  % cut 390x370


%% !UPDATE! Data [nP x 1]
load('C:\Users\SN\Google Drive\p3.UG2_computer_beh\2.model\bic.mat'); 
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

%% 2. Dot1
ditv = 0.05;    % dot interval
dsz = 2;        % dot size

y2 = sort(data1);
y2(isnan(y2)) = [];
x2 = plotDotsX(y2, ditv);

%% 3. Dot2
y3 = sort(data2);
y3(isnan(y3)) = [];        
x3 = plotDotsX(y3, ditv) + 1;

%% 4. Dot3
y4 = sort(data3);
y4(isnan(y4)) = [];        
x4 = plotDotsX(y4, ditv) + 2;

%% 4. Dot4
y5 = sort(data4);
y5(isnan(y5)) = [];        
x5 = plotDotsX(y5, ditv) + 3;

%% 4. Dot5
y6 = sort(data5);
y6(isnan(y6)) = [];        
x6 = plotDotsX(y6, ditv) + 4;

%% 4. Dot6
y7 = sort(data6);
y7(isnan(y7)) = [];        
x7 = plotDotsX(y7, ditv) + 5;


%% Color
% c = uisetcolor
Blue0 = [0.6 0.8 1];    %153 204 255    light -- for bar1
Blue1 = [.27 .47 .78];  %70 120 200     dark -- for dot1
Grey0 = [.67 .67 .67];  %170 170 170    light -- for bar2
Grey1 = [.4 .4 .4];     %102 102 102    dark -- for dot2


%% Size & Position
w = 120;    % chart width
h = 125;    % chart height
blank = 20;
xlabelspace = 15;
ylabelspace = 30;
Fw = w + 2*blank + ylabelspace;
Fh = h + 2*blank + xlabelspace;
F = figure('Position', [500 300 Fw Fh]); % left BOTTOM width height

subplot('Position', ...
    [(blank+ylabelspace)/Fw (blank+xlabelspace)/Fh w/Fw h/Fh]) 
    % left TOP width height

    
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

saveas(F, outfile);