function [offer, resp] = simulate_0step_ic(free)
% DGP_nRv_f0_t20

    global offer0
    global n    
    
    temp = free(1);
    envy = free(2);    
    norm(1) = free(3);    
    normAdapt = free(4);
    
    offer(1) = offer0;
    
    
    % value function / choice prob    
    for i = 1:n                
        % Norm update
        norm(i+1) = norm(i) + normAdapt*(offer(i) - norm(i));
        
        % Value function
        V(i) = FS(envy, offer(i), norm(i+1));   % net current value (accept - reject)              
        
        prob(i) = 1 ./ (1+exp(-temp * V(i)));
        resp(i) = randsample([1, 0], 1, true, [prob(i); 1-prob(i)]);       

        offer(i+1) = offer_controllable(offer(i), resp(i));        
    end
    offer = offer(1:n); 
end