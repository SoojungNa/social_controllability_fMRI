close all
clear;
addpath(genpath('C:\Users\SN\Google Drive\z.functions'));


roi_folder = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\180422_eta.8\7.roi\201025_6_52_-16_Feng2015_8mm';
%% Input files

% f2
load(fullfile(roi_folder, 'results', 'f2_v26.mat'))
f2_ic = result(:,1);
f2_nc = result(:,2);
% f0
load(fullfile(roi_folder, 'results', 'f0_v28.mat'))
f0_ic = result(:,1);
f0_nc = result(:,2);


%% Output file
oDir = fullfile(roi_folder, 'plot');
oFile = 'plot_f2_f0_nxV_2blocks.pdf';



%% %%%%%%%%%%%%%%%%%%%%%%%%%% PLOT INPUTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Subplot2. offer                  ... Bar&Dot
data1 = f2_ic;
data2 = f2_nc;
data3 = f0_ic;
data4 = f0_nc;


for i = 1:4
    this_data_name = ['data', num2str(i)];
    this_data = eval(this_data_name);
    [H(i), p(i), ci(i,:), stats] = ttest(this_data, 0, 'Tail', 'right');
    t(i) = stats.tstat;
    df(i) = stats.df;
    means(i) = mean(this_data);
    sems(i) = std(this_data)/sqrt(length(this_data));
end

[H2, p2, ci2, stats2] = ttest(f2_ic([1:16,18:end]), f0_ic, 'Tail', 'right');
[H3, p3, ci3, stats3] = ttest(f2_nc([1:16,18:end]), f0_nc, 'Tail', 'right');

% 2.1. Bar
x1 = [1 2 4 5];
y1 = means;
err = sems;

% 2.4. Other settings
xTL = {'C','U','C','U'};
%xTL2 = {};
yL = sprintf('vmPFC coefficient');
%xL = sprintf(' 2-step         0-step ');
% s3yL = [sprintf('Self-reported \n perceived control'), ' (%)'];

xlim = [0 6];
ylim = [-0.1 0.5];



%% %%%%%%%%%%%%%%%%%%%%%%%%%% Graphic settings %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Color
% c = uisetcolor
Blue0 = [0.6 0.8 1];    %153 204 255    light -- for bar1
Blue1 = [.27 .47 .78];  %70 120 200     dark -- for dot1
Grey0 = [.67 .67 .67];  %170 170 170    light -- for bar2
Grey1 = [.4 .4 .4];     %102 102 102    dark -- for dot2


%% Size & Position
w = 140;    % chart width 120
h = 120;    % chart height 125
blank = 20;
xlabelspace = 15;
ylabelspace = 30;
Fw = w + 2*blank + ylabelspace;
Fh = h + 2*blank + xlabelspace;
F = figure('Position', [500 300 Fw Fh]); % left BOTTOM width height

subplot('Position', ...
    [(blank+ylabelspace)/Fw (blank+xlabelspace)/Fh w/Fw h/Fh]) 
    % left TOP width height


%% %%%%%%%%%%%%%%%%%%%%%%%%%% Draw Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s1 = bar(x1, y1, 0.5, 'FaceColor', 'flat', 'EdgeColor', 'none');
s1.CData([1 3],:) = repmat(Blue0, 2, 1);
s1.CData([2 4],:) = repmat(Grey0, 2, 1);

hold on
s2 = errorbar(x1, y1, err);
s2.Color = [0 0 0];
s2.LineStyle = 'none'; 

ylabel(yL);
%xlabel(xL);
%ytickformat('%3.1f');
set(gca, 'box', 'off', 'FontName', 'Arial', 'FontSize', 8, ...
    'xLim', xlim, 'yLim', ylim, 'TickLength', [0 0], ...
    'xticklabel', xTL, 'xtick', [1 2 4 5], 'ytick', [0 0.5]);


cd(oDir);
saveas(F, oFile);


