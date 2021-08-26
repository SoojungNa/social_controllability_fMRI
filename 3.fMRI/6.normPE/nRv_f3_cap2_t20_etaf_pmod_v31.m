function [pmod] = nRv_f3_cap2_t20_etaf_pmod_v31(offer, resp, fixed, free)
    mn = 1;
    %mx = 9;    

    n = length(offer);
    %Like = 0;
    
    xV = zeros(1, n);
    xCV = zeros(1, n);
    xFV = zeros(1, n);        

    % parameters
    % norm0 = fixed(1);
    % norm_k = fixed(2);
    % delta_k = fixed(3);
    eta = fixed(4);
    
    FREE = num2cell(1./(1+exp(- free)));
    [temp, envy, norm0, normAdapt, delta, ~, ~, ~, ~] = deal(FREE{:});
    norm0 = 20 * norm0;
    delta = 4 * delta - 2;  
    temp = 20*temp;
   

    % norm update (RW)
    norm = RW(norm0, normAdapt, offer);
    
   
    % value function / choice prob
    for i = 1:n       
        
        % consider 3 steps
        CV(i) = FS(envy, offer(i), norm(i+1));   % net current value (accept - reject)        
        
        ao = max(offer(i)-delta, mn);
        if FS(envy, ao, norm(i+1)) > 0          % if accept(now) & accept(next)
            aFV(i) = eta * FS(envy, ao, norm(i+1)) + eta^2 * max(FS(envy, max(ao-delta, mn), norm(i+1)), 0);
        else                                                                 % if accept & reject
            aFV(i) = eta^2 * max(FS(envy, max(ao+delta, mn), norm(i+1)), 0);
        end
        
        ro = max(offer(i)+delta, mn);
        if FS(envy, ro, norm(i+1)) > 0        % reject & accept
            rFV(i) = eta * FS(envy, ro, norm(i+1)) + eta^2 * max(FS(envy, max(ro-delta, mn), norm(i+1)), 0);
        else                                                                 % reject & reject
            rFV(i) = eta^2 * max(FS(envy, max(ro+delta, mn), norm(i+1)), 0);
        end
                
        V(i) = CV(i) + (aFV(i) - rFV(i));
        
        
        %% chosen values
        if resp(i) == 1
            xV(i) = CV(i) + aFV(i);            
            xCV(i) = CV(i);
            xFV(i) = aFV(i);
            
        elseif resp(i) == 0
            xV(i) = rFV(i);
            xCV(i) = 0;
            xFV(i) = rFV(i);
        end     
        
    end    
    
        %% norm violation  -- after norm updates
        nPE = offer' - norm(1:end-1);
        NV = max(norm(2:end) - offer',0);        
        
        pmod.nxV = normalize(xV);
        pmod.nxCV = normalize(xCV);
        pmod.nxFV = normalize(xFV);
        pmod.nO = normalize(offer');
        pmod.nN0 = normalize(norm(1:end-1));
        pmod.nN1 = normalize(norm(2:end));
        pmod.nNPE = normalize(nPE);
        pmod.nNV = normalize(NV);
end