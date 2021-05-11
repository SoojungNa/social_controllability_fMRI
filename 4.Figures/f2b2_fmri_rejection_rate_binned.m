%% Rejection rates binned by offer size     ... Line&Errorbar
% 2020/8/4

clear;
addpath(genpath('C:\Users\SN\Google Drive\z.functions\plots'));
load('C:\Users\SN\Google Drive\z.functions\plots\colors.mat');

outdir = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\1.beh\001.UG2beh_ICvNC';
outfile = 'plot_bin_rejection_rates.pdf';


%% Input files
indir = 'C:\Users\SN\Google Drive\p1.UG2_fMRI\1.beh\001.UG2beh_ICvNC';
infile = 'results.mat';
load(fullfile(indir, infile));


%% Plot inputs 
nP = length(ID);
x = [1 2 3];

yic = M(:, [5 7 9]) * 100;
ync = M(:, [6 8 10]) * 100;

eic = nanstd(yic)/sqrt(nP);
enc = nanstd(ync)/sqrt(nP);

% 5.1. IC errorbar
s_x1 = x;
s_y1 = nanmean(yic);
s_z1 = eic;

% 5.2. NC errorbar
s_x2 = x;
s_y2 = nanmean(ync);
s_z2 = enc;

% 5.3. other settings
s_xTL = {'1-3','4-6', '7-9'};
s_xticks = x;
s_xL = 'Offer size ($)';
s_yL = 'Mean rejection rate (%)';

s_xlim = [0.5 3.5];
s_ylim = [0 100];

s_legend = {'C', 'U'};

s_text1 = 'n.s.';
s_text2 = '***';
s_text3 = '***';
s_text1x = x(1);
s_text2x = x(2);
s_text3x = x(3);
s_text1y = 97; %s_y2(1)+10;
s_text2y = 93; %s_y1(2)+8;
s_text3y = 93; %s_y1(3)+8;


%% Draw

ug_plot_size;

s_1 = errorbar(s_x1, s_y1, s_z1, 'Color', blue_dark, 'MarkerFaceColor', blue_dark);
hold on
s_2 = errorbar(s_x2, s_y2, s_z2, 'Color', grey_dark, 'MarkerFaceColor', grey_dark);
hold on
s_3 = text(s_text1x, s_text1y, s_text1, ...
    'HorizontalAlignment', 'center', 'FontName', 'Arial', 'FontSize', 8);
s_4 = text(s_text2x, s_text2y, s_text2, ...
    'HorizontalAlignment', 'center', 'FontName', 'Arial', 'FontSize', 8);
s_5 = text(s_text3x, s_text3y, s_text3, ...
        'HorizontalAlignment', 'center', 'FontName', 'Arial', 'FontSize', 8);
   
set([s_1, s_2], 'Marker', 's', 'MarkerEdgeColor', 'none', 'MarkerSize', 5, 'CapSize', 5)

xlabel(s_xL);
ylabel(s_yL);
ytickformat('%3.0f');
legend([s_1 s_2], s_legend, 'Location', 'Southwest', 'box', 'off');
set(gca, 'box', 'off', 'fontname', 'Arial', 'fontsize', 8, ...
    'xlim', s_xlim, 'ylim', s_ylim, ...        
    'TickLength', [0 0], 'xtick', s_xticks, 'xticklabel', s_xTL);

% Save
cd(outdir);
saveas(F, outfile);