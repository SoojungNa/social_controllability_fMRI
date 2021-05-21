function [Like, norm, V] = nRv_f0_t20(offer, resp, fixed, free )

    mn = 1;    % not used

    n = length(offer);
    Like = 0;
    
    FREE = num2cell(1./(1+exp(- free)));
    [temp, envy, norm0, normAdapt, ~, ~, ~, ~, ~] = deal(FREE{:});
    norm0 = 20 * norm0;    
    temp = 20 * temp;
   

    % norm update (RW)
    norm = RW(norm0, normAdapt, offer);  

    % value function / choice prob
    for i = 1:n        
        V(i) = FS(envy, offer(i), norm(i+1));   % net current value (accept - reject)              
        
        Like = Like - log(exp(temp*V(i)*(resp(i)))/(1+exp(temp*V(i))));    
        
    end

end