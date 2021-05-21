function [offer, resp] = simulate_MF_nc(free)
% nRv_MF_t20_etaf

    global n    
    global eta
    
    offer = offer_uncontrollable;
    
    mn = 1;        
    
    temp = free(1);
    envy = free(2);    
    norm(1) = free(3);    
    normAdapt = free(4);    
    alpha = free(9);   
    
    % initial Q: assuming the horizon is effectively infinite & no FS    
    Q = repmat([1:9]'./(1-eta),1,2);
 
    
    % value function / choice prob
    for i = 1:n    
        
        % Norm update
        norm(i+1) = norm(i) + normAdapt*(offer(i) - norm(i));       
        
        if i>1
            if resp(i-1) == 1
                Q(offer(i-1), 1) = Q(offer(i-1), 1) + alpha*(FS(envy, offer(i-1), norm(i+1)) + eta*(max(Q(offer(i), 1:2))) - Q(offer(i-1), 1));
            elseif resp(i-1) == 0
                Q(offer(i-1), 2) = Q(offer(i-1), 2) + alpha*(0 + eta*(max(Q(offer(i), 1:2))) - Q(offer(i-1), 2));
            end
        end
        
        V(i) = Q(offer(i), 1) - Q(offer(i), 2); %Qaccept - Qreject
        
        prob(i) = 1 ./ (1+exp(-temp * V(i)));
        resp(i) = randsample([1, 0], 1, true, [prob(i); 1-prob(i)]);
        
    end            
end