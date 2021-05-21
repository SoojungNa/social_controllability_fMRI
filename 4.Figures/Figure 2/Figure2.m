clear
close all
addpath(genpath(cd))
load('colors.mat')

% plot
width = 125;
height = 125;
blank = 80;

ncol = 3;
nrow = 2;

Fw = (width+blank)*ncol;
Fh = (height+blank)*nrow;

%ratios
w = width/Fw;
h = height/Fh;
col1 = blank/4*3/Fw;
col2 = col1 + 1/ncol;
col3 = col2 + 1/ncol;
row2 = blank/4*3/Fh;
row1 = row2 + 1/nrow;

F = figure('Position', [300 100 Fw Fh]); %left, bottom, width, height
pos1 = [col1 row1 w h];
pos2 = [col2 row1 w h];
pos3 = [col3 row1 w h];
pos4 = [col1 row2 w h];
pos5 = [col2 row2 w h];

subplot('Position', pos1)
F2_fmri_offer_trajectory

subplot('Position', pos2)
F2_fmri_mean_offer

subplot('Position', pos3)
F2_fmri_pc

subplot('Position', pos4)
F2_fmri_rejection_rate

subplot('Position', pos5)
F2_fmri_rejection_rate_binned

%set(gcf, 'color', 'none');   
%set(gca, 'color', 'none');
%F.Resolution = 300;
%saveas(F, 'Figure2.tif')


