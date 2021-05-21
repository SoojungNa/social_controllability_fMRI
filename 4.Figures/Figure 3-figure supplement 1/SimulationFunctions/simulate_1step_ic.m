function [offer, resp] = simulate_1step_ic(free)
    % nRv_fD_cap2_t20_etaf
    
    global offer0
    global n    
    global eta
    
    mn = 1;        
    
    temp = free(1);
    envy = free(2);    
    norm(1) = free(3);    
    normAdapt = free(4);
    delta = free(5);
   
    offer(1) = offer0;    

    % value function / choice prob
    for i = 1:n       
        
        % Norm update
        norm(i+1) = norm(i) + normAdapt*(offer(i) - norm(i));        
        
        CV(i) =FS(envy, offer(i), norm(i+1));
        FVa(i) = max(0, FS(envy,  max(offer(i)-delta, mn), norm(i+1)));
        FVr(i) = max(0, FS(envy,  max(offer(i)+delta, mn), norm(i+1)));
        V(i) = CV(i) + eta * ( FVa(i) - FVr(i) );
        
        prob(i) = 1 ./ (1+exp(-temp * V(i)));
        resp(i) = randsample([1, 0], 1, true, [prob(i); 1-prob(i)]);
        
        offer(i+1) = offer_controllable(offer(i), resp(i));                
    end    
    
    offer = offer(1:n); 
end