
load('sample1_fmri_participants\accuracy.mat');

data = ic.accuracyRate;

Blue0 = [0.6 0.8 1];    %153 204 255    light -- for bar1
Blue1 = [.27 .47 .78];  %70 120 200     dark -- for dot1
Grey0 = [.67 .67 .67];  %170 170 170    light -- for bar2
Grey1 = [.4 .4 .4];     %102 102 102    dark -- for dot2

Green = [0.3922    0.8314    0.0745];
White = [1 1 1];
Black = [0 0 0];
% mymap = [Green; White; Black]; % for colormap


%% Draw charts

bin_edges = 0:0.1:1;
H = histogram(data, 'BinEdges', bin_edges, 'FaceColor', Blue0, ...
    'FaceAlpha', 1, 'EdgeColor', White);

%H = image(data);
%colormap(mymap);
set(gca, 'box', 'off', 'FontName', 'Arial', 'FontSize', 8,  ...
    'XLim', [0 1], 'YLim', [0 40], ...
    'XTick', [0 0.5 1], 'XTickLabel', [0 0.5 1], ...    
    'YTick', [20 40], 'YTickLabel', [20 40]); %, 'GridVisible', 'off');

%H = imagesc(data);
% set(gca, 'FontName', 'Arial', 'FontSize', 8);
% set(gca, 'YTick', [1 24 48], 'YTickLabel', [1 24 48])
xlabel('Accuracy rate');
ylabel('Number of participants');
colorbar off;
    %'xLim', xlim, 'yLim', ylim, 'TickLength', [0 0], 'xtick', [-2 0 2], 'ytick', [0 5 10]);

