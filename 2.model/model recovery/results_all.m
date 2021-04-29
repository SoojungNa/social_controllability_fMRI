clear

folder = {'210331_100'};

files_ic = {};
files_nc = {};

for f = 1:length(folder)
    cd(folder{f})
    dir_ic = dir('*_ic*.mat');
    dir_nc = dir('*_nc*.mat');
    for i = 1:length(dir_ic)
        a = {[folder{f}, '/', dir_ic(i).name]};
        files_ic = [files_ic, a];
    end
    for i = 1:length(dir_nc)
        b = {[folder{f}, '/', dir_nc(i).name]};
        files_nc = [files_nc, b];
    end
    cd ..
end


% Compile all the result files
[cm_ic, dic_ic, time_ic] = compileAll(files_ic, 1);
[cm_nc, dic_nc, time_nc] = compileAll(files_nc, 0);

% show only MF, 0-step, and 2-step
[cm3_ic, dic3_ic] = show3models(dic_ic);
[cm3_nc, dic3_nc] = show3models(dic_nc);

% show only MF, 0-step, 1-step, and 2-step
[cm4_ic, dic4_ic] = show4models(dic_ic);
[cm4_nc, dic4_nc] = show4models(dic_nc);

label3 = {'MF', '0-step', '2-step'};
label6 = {'MF', '0-step', '1-step', '2-step', '3-step', '4-step'};

F = figure();
subplot(2,2,1)
h = heatmap(cm3_ic/100);
%h.CellLabelFormat = '%f';
h.XData = label3;
h.YData = label3;
title('3 models_IC')

subplot(2,2,2)
h = heatmap(cm3_nc./100);
h.XData = label3;
h.YData = label3;
title('3 models_NC')

subplot(2,2,3)
h = heatmap(cm_ic./100);
h.XData = label6;
h.YData = label6;
title('6 models_IC')

subplot(2,2,4)
h = heatmap(cm_nc./100);
h.XData = label6;
h.YData = label6;
h.CellLabelFormat = '%0.2f';
title('6 models_NC')

saveas(F,'heatmap.pdf')

% Compile all the result files
function [cm, dic, time] = compileAll(file_paths, t)    
    cm = zeros(6, 6);
    dic = [];
    time = nan(length(file_paths), 1);
    for i = 1:length(file_paths)        
        load(file_paths{i})        
        cm = cm + CM;        
        dic = [dic, dic_avg];
        if t == 1
            time(i) = tTotal/length(tEnd);        
        end
    end
end



% show only MF, 0-step, and 2-step
function [cm, dic] = show3models(dic_6models)
    cm = zeros(3,3);
    nIter = length(dic_6models);
    dic = cell(1, nIter);
    for i = 1:nIter
        dic_new_this_iter = dic_6models{i}([1 2 4], [1 2 4]);
        winners = dic_new_this_iter == min(dic_new_this_iter, [], 2);
        best = winners ./ sum(winners, 2);
        cm = cm + best;
        dic{i} = dic_new_this_iter;
    end
end

function [cm, dic] = show4models(dic_6models)
    cm = zeros(4,4);
    nIter = length(dic_6models);
    dic = cell(1, nIter);
    for i = 1:nIter
        dic_new_this_iter = dic_6models{i}([1 2 3 4], [1 2 3 4]);
        winners = dic_new_this_iter == min(dic_new_this_iter, [], 2);
        best = winners ./ sum(winners, 2);
        cm = cm + best;
        dic{i} = dic_new_this_iter;
    end
end