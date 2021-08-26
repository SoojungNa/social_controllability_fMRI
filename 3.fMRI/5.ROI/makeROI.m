% Need:
% coords
% sphereRadius
% outDir
for i=1:size(coords,1)
    thisCoord = coords(i,:);
    roiLabel = sprintf('%i_%i_%i', thisCoord(1), thisCoord(2), thisCoord(3));

    sphereROI = maroi_sphere(struct('centre', thisCoord, 'radius', sphereRadius));

    outName = fullfile(outDir, sprintf('%dmmsphere_%s_roi', sphereRadius, roiLabel));

    % save MarsBaR ROI (.mat) file
    saveroi(sphereROI, [outName '.mat']);
end