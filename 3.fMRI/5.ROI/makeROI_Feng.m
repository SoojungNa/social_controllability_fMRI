addpath(genpath('C:\Users\SN\Google Drive\z.programs\marsbar-0.44'))
addpath('C:\Users\SN\Google Drive\p1.UG2_fMRI\180422_eta.8\7.roi')

outDir = cd;
if ~isfolder(outDir)
    mkdir(outDir);
end

sphereRadius = 8; % mm

coords = [6 52 -16
        ];
%coords = dlmread('200916_VS_independent.txt');

makeROI;
