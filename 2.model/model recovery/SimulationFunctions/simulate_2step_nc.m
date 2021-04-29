function [offer, resp] = simulate_2step_nc(free)
    % nRv_f3_cap2_t20_etaf
        
    global n    
    global eta
    
    offer = offer_uncontrollable;
    
    mn = 1;        
    
    temp = free(1);
    envy = free(2);    
    norm(1) = free(3);    
    normAdapt = free(4);
    delta = free(5);
   
    % value function / choice prob
    for i = 1:n       
        
        % Norm update
        norm(i+1) = norm(i) + normAdapt*(offer(i) - norm(i));        
        
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
        
        prob(i) = 1 ./ (1+exp(-temp * V(i)));
        resp(i) = randsample([1, 0], 1, true, [prob(i); 1-prob(i)]);       
   
    end       
end