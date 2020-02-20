function [Like, norm, Q] = nRv_MF_t20_etaf(offer, resp, fixed, free)

    n = length(offer);
    Like = 0;

    % parameters
    % norm0 = fixed(1);
    % norm_k = fixed(2);
    %delta_k = fixed(3);
    %delta0 = fixed(4);
    eta = fixed(4);
    
    FREE = num2cell(1./(1+exp(- free)));
    [temp, envy, norm0, normAdapt, ~, ~, ~, ~, alpha] = deal(FREE{:});
    norm0 = 20 * norm0;
    temp = 20*temp;
        

    % norm update (RW)
    norm = RW(norm0, normAdapt, offer);
    
    
    % initial Q: assuming the horizon is effectively infinite & no FS
    Q = repmat([1:9]'/(1-eta),1,2);
 
    
    % value function / choice prob
    for i = 1:n               
        if i>1
            if resp(i-1) == 1
                Q(offer(i-1), 1) = Q(offer(i-1), 1) + alpha*(FS(envy, offer(i-1), norm(i+1)) + eta*(max(Q(offer(i), 1:2))) - Q(offer(i-1), 1));
            elseif resp(i-1) == 0
                Q(offer(i-1), 2) = Q(offer(i-1), 2) + alpha*(0 + eta*(max(Q(offer(i), 1:2))) - Q(offer(i-1), 2));
            end
        end
        
        V(i) = Q(offer(i), 1) - Q(offer(i), 2); %Qaccept - Qreject
        
        Like = Like - log(exp(temp*V(i)*(resp(i)))/(1+exp(temp*V(i))));         
    end    
end
