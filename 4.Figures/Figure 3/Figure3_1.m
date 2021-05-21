clear
close all
addpath(genpath(cd))
load('colors.mat')

% plot
width = 125;
height = 125;
blank = 80;

ncol = 2;
nrow = 1;

Fw = (width+blank)*ncol;
Fh = (height+blank)*nrow;

%ratios
w = width/Fw;
h = height/Fh;
col1 = blank/4*3/Fw;
col2 = col1 + 1/ncol;
col3 = col2 + 1/ncol;
row1 = blank/4*3/Fh;

F = figure('Position', [300 100 Fw Fh]); %left, bottom, width, height
pos1 = [col1 row1 w h];
pos2 = [col2 row1 w h];

subplot('Position', pos1)
F3_fmri_dic_ic

subplot('Position', pos2)
F3_fmri_dic_nc

