function [best, DIC, param] = fit_6models(offer, resp)

    nTr = length(resp);

    %% Model setting
    Model = {'nRv_MF_t20_etaf'
             'nRv_f0_t20'
             'nRv_fD_cap2_t20_etaf'
             'nRv_f3_cap2_t20_etaf'
             'nRv_f4_cap2_t20_etaf'
             'nRv_f5_cap2_t20_etaf'};                        % Candidate models { 'xx' ; 'xx'}
    nM = length(Model);                          % nM = #candidate models

    fixedName = {'norm0', 'norm_BS_k', 'delta_BS_k', 'eta'};
    fixed = [10 4 4 0.8];

    freeName = {'temp', 'envy', 'norm0', 'norm_RW_Adapt', 'delta', 'delta0', 'delta_RW_Adapt', 'eta', 'alpha'};
    freeID = [1 1 1 1 0 0 0 0 1
              1 1 1 1 0 0 0 0 0
              1 1 1 1 1 0 0 0 0
              1 1 1 1 1 0 0 0 0
              1 1 1 1 1 0 0 0 0
              1 1 1 1 1 0 0 0 0
                ];        

    nx = sum(freeID,2);       % # free param by model
    [~, nX] = size(freeID);   % max # free param

    DIC = zeros(1, nM);                    % Calculate BIC
    L =1000+DIC;                             % Calculate Likelihoods
    X = zeros(nX, nM);               % x (=free parameter) values returned by the optimization
    param = X;


    %% Free param starting points
    free0 = cell(nM,1);
    xIndex = cell(nM,1);
    for m = 1:nM
        set = permn(-1:1,nx(m));   % permn(V,N) = permutations of N elements taken from the vector V, with repetitions
        free0{m} = zeros(length(set), nX);    
        xIndex{m} = find(freeID(m,:));
        free0{m}(:,xIndex{m}) = set;   
    end  

    errorPoint = [0 0];   % skip this combination


    %% Model fitting
    options =optimset('TolFun',10^(-4),'TolX',10^(-4),'Largescale','off', ...
          'DerivativeCheck','off','GradObj','off','MaxFunEvals',20000, ...
          'MaxIter',20000, 'Display', 'off');

     for m = 1:nM             
        
        ff = str2func(Model{m});                      

        for s =1:length(free0{m})                           % try multiple starting points
            index = [m s];   
            if  ismember(index, errorPoint, 'rows')      % fminunc errors for these combinations                   
            else
                x = free0{m}(s,:);                
                [x, Likeold, ~, ~, ~, ~] = fminunc(@(x) ff(offer,resp,fixed,x), x, options);
                if (L(m) > Likeold)
                    L(m) = Likeold;
                    X(:,m) = x;
                end
            end
        end        
        DIC(m) = L(m) + nx(m)/2*(log(nTr)-log(2*pi)); 
        param(xIndex{m},m) = 1./(1+exp(-X(xIndex{m},m)));
     end

    %% param transformation
    param(1,:) = 20*param(1,:);             % temp
    param(3,:) = 20*param(3,:);             % norm0
    param(5,3:6) = 4*param(5,3:6)-2;          % delta
    
    
    best = DIC == min(DIC);
    best = best / sum(best);

end