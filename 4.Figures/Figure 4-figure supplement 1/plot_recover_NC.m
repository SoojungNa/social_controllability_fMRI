close all
clear;
addpath(genpath('C:\Users\SN\Google Drive\z.functions'));


%% Input files
indir = 'C:\Users\SN\Google Drive\p22.UG2_covid\200403_t1\2.model';
infile = 'recover_nRv_f3_cap2_t20_etaf_NC.mat'; % param_est, param_tru, R, P


%% Output file
oDir = indir;
oFile = 'plot_recover_NC.pdf';


%% parameter
poi{1} = sprintf('\n inverse temperature');
poi{2} = sprintf('\n sensitivity to norm PE'); %sprintf('envy');
poi{3} = sprintf('\n initial norm');
poi{4} = sprintf('\n adaptation rate');
poi{5} = sprintf('\n expected influence');
%poi{6} = sprintf('\n future thinking weight');

col = [1 2 3 4 5]; % column #

pMin = [0 0 0 0 -2];
pMax = [20 1 20 1 2];


%% Load input files
load(fullfile(indir, infile));


%% %%%%%%%%%%%%%%%%%%%%%%%%%% PLOT INPUTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Subplots                  ... Correl dots with x=y line
for i = 1:length(poi)
    
    x{i} = param_tru(:, col(i));
    y{i} = param_est(:, col(i));
    
    xL{i} = ['True ', poi{i}];
    yL{i} = ['Recovered ' , poi{i}];

    xlim{i} = [pMin(i) pMax(i)];
    ylim{i} = xlim{i};

    xT{i} = [pMin(i) pMax(i)];
    yT{i} = xT{i};

end

correlresults = [R; P];   

%% %%%%%%%%%%%%%%%%%%%%%%%%%% Graphic settings %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Color
% c = uisetcolor
Blue0 = [0.6 0.8 1];    %153 204 255    light
Blue1 = [.27 .47 .78];  %70 120 200     dark
Grey0 = [.67 .67 .67];  %170 170 170    light
Grey1 = [.4 .4 .4];     %102 102 102    dark

%% Dot size
dsz = 5;        % dot size


%% Size & Position
w = 120;    % chart width
h = 125;    % chart height

gap = 45;
gapw = 80;  % gap including ylabel
gaph = gapw;  % gap including xlabel

Fw = w*3 + gapw*3 + gap;
Fh = h*2 + gaph*2 + gap;
F = figure('Position', [300 100 Fw Fh]);

pos{1} = [gapw/Fw (2*gaph+h)/Fh w/Fw h/Fh];
pos{2} = [(2*gapw+w)/Fw (2*gaph+h)/Fh w/Fw h/Fh];
pos{3} = [(3*gapw+2*w)/Fw (2*gaph+h)/Fh w/Fw h/Fh];
pos{4} = [gapw/Fw gaph/Fh w/Fw h/Fh];
pos{5} = [(2*gapw+w)/Fw gaph/Fh w/Fw h/Fh];
pos{6} = [(3*gapw+2*w)/Fw gaph/Fh w/Fw h/Fh];



%% %%%%%%%%%%%%%%%%%%%%%%%%%% Draw Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:length(poi)
    subplot('Position', pos{i}) 

    s22 = scatter(x{i}, y{i}, dsz, Grey1, 'filled');
    s22.MarkerFaceAlpha = 0.3;
    
    %line(xlim{i}, ylim{i}, 'lineWidth', .2, 'Color', 'k');
    %line([-2 2], [0 0], 'lineWidth', .1, 'Color', 'k');
    %line([0 0], [-2 2], 'lineWidth', .1, 'Color', 'k');

    xlabel(xL{i});
    ylabel(yL{i});
    ytickformat('%3.0f');
    xtickformat('%3.0f');
    set(gca, 'box', 'off', 'FontName', 'Arial', 'FontSize', 8, ...
        'xLim', xlim{i}, 'yLim', ylim{i}, ...
        'TickLength', [0 0], 'xtick', xT{i}, 'ytick', yT{i});
   
    
end



cd(oDir);

saveas(F, oFile);


