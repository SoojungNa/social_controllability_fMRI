clear
rng('Shuffle')
addpath(genpath(cd))

nIter = 1;          % number of iterations
nP = 48;
results = cell(nP, 6, nIter);
best_iter = cell(nIter, 1);
CM = zeros(6,6);
param = cell(nIter, 1);

global offer0
global eta
global n

offer0 = 5;
n = 30;             % number of trials
eta = 0.8;          % fixed parameter

tStart = tic;    

for t = 1:nIter  
    
    disp(['iter ' num2str(t)])
    
    dic_sum = zeros(6,6);
    
    for i = 1:nP

        disp(['subject ' num2str(i)])

        % MF
        m = 1;
        x = rand(1,9);
        x(1) = 1;
        x(3) = 20*x(3);
        x(5) = 2*x(5);        
        param{t}(i,:,m) = x;
        [offer, resp] = simulate_MF_ic(x);
        [best, dic, param_est] = fit_6models(offer, resp);
        results{i,m,t} = {best; dic; offer; resp; param_est};        
        dic_sum(m, :) = dic_sum(m, :) + dic;

        % 0step
        m = 2;
        x = rand(1,9);
        x(1) = 1;
        x(3) = 20*x(3);
        x(5) = 2*x(5);        
        param{t}(i,:,m) = x;
        [offer, resp] = simulate_0step_ic(x);
        [best, dic, param_est] = fit_6models(offer, resp);
        results{i,m,t} = {best; dic; offer; resp; param_est};        
        dic_sum(m, :) = dic_sum(m, :) + dic;

        % 1step
        m = 3;
        x = rand(1,9);
        x(1) = 1;
        x(3) = 20*x(3);
        x(5) = 2*x(5);        
        param{t}(i,:,m) = x;
        [offer, resp] = simulate_1step_ic(x);
        [best, dic, param_est] = fit_6models(offer, resp);
        results{i,m,t} = {best; dic; offer; resp; param_est};        
        dic_sum(m, :) = dic_sum(m, :) + dic;

        % 2step
        m = 4;
        x = rand(1,9);
        x(1) = 1;
        x(3) = 20*x(3);
        x(5) = 2*x(5);        
        param{t}(i,:,m) = x;
        [offer, resp] = simulate_2step_ic(x);
        [best, dic, param_est] = fit_6models(offer, resp);
        results{i,m,t} = {best; dic; offer; resp; param_est};     
        dic_sum(m, :) = dic_sum(m, :) + dic;

        % 3step
        m = 5;
        x = rand(1,9);
        x(1) = 1;
        x(3) = 20*x(3);
        x(5) = 2*x(5);        
        param{t}(i,:,m) = x;
        [offer, resp] = simulate_3step_ic(x);
        [best, dic, param_est] = fit_6models(offer, resp);
        results{i,m,t} = {best; dic; offer; resp; param_est};        
        dic_sum(m, :) = dic_sum(m, :) + dic;

        % 4step
        m = 6;
        x = rand(1,9);
        x(1) = 1;
        x(3) = 20*x(3);
        x(5) = 2*x(5);        
        param{t}(i,:,m) = x;
        [offer, resp] = simulate_4step_ic(x);
        [best, dic, param_est] = fit_6models(offer, resp);
        results{i,m,t} = {best; dic; offer; resp; param_est};        
        dic_sum(m, :) = dic_sum(m, :) + dic;

    end
    
    dic_avg{t} = dic_sum./nP;
    winners = dic_avg{t} == min(dic_avg{t}, [], 2);
    best_iter{t} = winners ./ sum(winners, 2);
    
    CM = CM + best_iter{t};
    
    tEnd(t) = toc(tStart);
    disp(['iter ' num2str(t) ': ' num2str(tEnd(t)) ' seconds'])
        
end

tTotal = sum(tEnd);
disp(['Completed : ' num2str(tTotal) ' seconds'])

save('CM_ic.mat', 'results', 'param', 'dic_avg', 'best_iter', 'CM', 'tEnd', 'tTotal');
