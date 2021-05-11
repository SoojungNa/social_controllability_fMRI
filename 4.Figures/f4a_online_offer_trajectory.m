% Plot: offer trajectories ... Line&Patch
% 2020/8/4

clear;
addpath(genpath('C:\Users\SN\Google Drive\z.functions\plots'));
load('C:\Users\SN\Google Drive\z.functions\plots\colors.mat');

outdir = cd;
outfile = 'plot_offer_trajectory.pdf';


%% Input files
indir = 'C:\Users\SN\Google Drive\p22.UG2_covid\200403_t1\1.beh\000.dataOrg';
infile = 'beh_noFlat_1342.mat';
load(fullfile(indir, infile));


%% Plot inputs 
nP = length(A);

for i = 1:nP
    yic(i,1:30) = A(i).IC.offer';
    ync(i,1:30) = A(i).NC.offer';
end

eic = std(yic)/sqrt(nP);
loic = mean(yic) - eic;
hiic = mean(yic) + eic;

enc = std(ync)/sqrt(nP);
lonc = mean(ync) - enc;
hinc = mean(ync) + enc;

% 1.1. IC line
x1 = 1:30;
y1 = mean(yic);

% 1.2. NC line
x2 = x1;
y2 = mean(ync);

% 1.3. IC patch
x3 = [x1 x1(end:-1:1) x1(1)];
y3 = [loic hiic(end:-1:1) loic(1)];

% 1.4. NC patch
x4 = [x2 x2(end:-1:1) x2(1)];
y4 = [lonc hinc(end:-1:1) lonc(1)];

% 1.5. Other settings
xL = 'Trial number';
yL = 'Offer size ($)';

xlim = [1 30];
ylim = [3 7];

legend_label = {'Controllable (C)', 'Uncontrollable (U)'};


%% Draw

ug_plot_size;

s3 = patch(x3, y3, blue_light);
s4 = patch(x4, y4, grey_light);
set(s3, 'facecolor', blue_light, 'edgecolor', 'none');
set(s4, 'facecolor', grey_light, 'edgecolor', 'none');

hold on
s1 = plot(x1, y1, 'Color', blue_dark);
s2 = plot(x2, y2, 'Color', grey_dark);

xlabel(xL);
ylabel(yL);
ytickformat('%3.0f');
legend([s1 s2], legend_label, 'Location', 'Southwest', 'box', 'off');

set(gca, 'box', 'off', 'FontName', 'Arial', 'FontSize', 8, ...
    'xLim', xlim, 'yLim', ylim, 'TickLength', [0 0]);

% Save
cd(outdir);
saveas(F, outfile);