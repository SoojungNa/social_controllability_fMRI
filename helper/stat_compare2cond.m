function results = stat_compare2cond(Ycond1, Ycond2, Ynames)
%% Comparison between two conditions (within subject)
% F-test for variance
% paired t-test for mean
% t-test for mean --- unequal variance

% Ynames    1 x nY cell
% Y1        nP x nY doub
% Y2        nP x nY doub

    results.columns = Ynames;
    results.rows = {'h', 'df1', 'df2', 'f/t', 'p'}'; 

    for y = 1:length(Ynames)
        % F-test for variance 
        [h1,p1, ~, stats1] = vartest2(Ycond1(:, y), Ycond2(:, y));
        results.f_var(:,y) = [h1, stats1.df1, stats1.df2, stats1.fstat, p1]';

        % T-test for mean -- assuming equal variance
        [h2,p2, ~, stats2] = ttest(Ycond1(:, y), Ycond2(:, y));
        results.pt_mean(:,y) = [h2, stats2.df, [], stats2.tstat, p2]';   

        % T-test for mean -- assuming unequal variance
        [h3,p3, ~, stats3] = ttest2(Ycond1(:, y), Ycond2(:, y),'Vartype','unequal');
        results.t_mean_uneqvar(:,y) = [h3, stats3.df, [], stats3.tstat, p3]';   
    end
end