clear
close all
addpath(genpath(cd))
load('colors.mat')

% plot
width = 125;
height = 125;
blank = 80;

ncol = 3;
nrow = 3;

Fw = (width+blank)*ncol;
Fh = (height+blank)*nrow;

%ratios
w = width/Fw;
h = height/Fh;
col1 = blank/4*3/Fw;
col2 = col1 + 1/ncol;
col3 = col2 + 1/ncol;
row3 = blank/4*3/Fh;
row2 = row3 + 1/nrow;
row1 = row2 + 1/nrow;

F = figure('Position', [300 0 Fw Fh]); %left, bottom, width, height
pos1 = [col1 row1 w h];
pos2 = [col2 row1 w h];
pos3 = [col3 row1 w h];
pos4 = [col1 row2 w h];
pos5 = [col2 row2 w h];
pos6 = [col3 row2 w h];
pos7 = [col1 row3 w h];

subplot('Position', pos1)
F4_online_offer_trajectory

subplot('Position', pos2)
F4_online_rejection_rate_binned

subplot('Position', pos3)
F4_online_pc

subplot('Position', pos4)
F4_online_delta

subplot('Position', pos5)
F4_online_delta_correl

subplot('Position', pos6)
F4_online_pc_correl

subplot('Position', pos7)
F4_online_delta_offer_correl
