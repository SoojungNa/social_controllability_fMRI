function [Like, delta, norm, V, CV, FVa, FVr] = nRv_fD_cap2_t20_etaf(offer, resp, fixed, free)
    mn = 1;    
    
    n = length(offer);
    Like = 0;

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
        
        CV(i) =FS(envy, offer(i), norm(i+1));
        FVa(i) = max(0, FS(envy,  max(offer(i)-delta, mn), norm(i+1)));
        FVr(i) = max(0, FS(envy,  max(offer(i)+delta, mn), norm(i+1)));
        V(i) = CV(i) + eta * ( FVa(i) - FVr(i) );
        
        Like = Like - log(exp(temp*V(i)*(resp(i)))/(1+exp(temp*V(i))));         
    end    
end
