function [Like, delta, norm, V, CV, aFV, rFV] = nRv_f4_cap2_t20_etaf(offer, resp, fixed, free)
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
        
        CV(i) = FS(envy, offer(i), norm(i+1));   % net current value (accept - reject)        
        
        
        % FV_accept        
        
        ao = max(offer(i)-delta, mn);       % ao = expected offer1 when accept offer0
        
        if FS(envy, ao, norm(i+1)) > 0                          % a a            
                aao = max(ao-delta, mn);                
                if FS(envy, aao, norm(i+1)) > 0                 % a a a
                    aFV(i) = eta * FS(envy, ao, norm(i+1)) + eta^2 * FS(envy, aao, norm(i+1)) ...
                        + eta^3 * max(FS(envy, max(aao-delta, mn), norm(i+1)), 0);
                else                                                            % a a r
                    aFV(i) = eta * FS(envy, ao, norm(i+1)) + eta^2 * 0 ...
                        + eta^3 * max(FS(envy, max(aao+delta, mn), norm(i+1)), 0);
                end
            
        else                                                                 % a r
                aro = max(ao+delta, mn);                
                if FS(envy, aro, norm(i+1)) > 0                 % a r a
                    aFV(i) = eta * 0 + eta^2 * FS(envy, aro, norm(i+1)) ...
                        + eta^3 * max(FS(envy, max(aro-delta, mn), norm(i+1)), 0);
                else                                                            % a r r
                    aFV(i) = eta * 0 + eta^2 * 0 ...
                        + eta^3 * max(FS(envy, max(aro+delta, mn), norm(i+1)), 0);
                end
        end
        
        
        % FV_reject
        
        ro = max(offer(i)+delta, mn);       % ro = expected offer1 when reject offer0
        
        if FS(envy, ro, norm(i+1)) > 0                          % r a            
                rao = max(ro-delta, mn);                
                if FS(envy, rao, norm(i+1)) > 0                 % r a a
                    rFV(i) = eta * FS(envy, ro, norm(i+1)) + eta^2 * FS(envy, rao, norm(i+1)) ...
                        + eta^3 * max(FS(envy, max(rao-delta, mn), norm(i+1)), 0);
                else                                                            % r a r
                    rFV(i) = eta * FS(envy, ro, norm(i+1)) + eta^2 * 0 ...
                        + eta^3 * max(FS(envy, max(rao+delta, mn), norm(i+1)), 0);
                end
            
        else                                                                 % r r
                rro = max(ao+delta, mn);                
                if FS(envy, rro, norm(i+1)) > 0                 % r r a
                    rFV(i) = eta * 0 + eta^2 * FS(envy, rro, norm(i+1)) ...
                        + eta^3 * max(FS(envy, max(rro-delta, mn), norm(i+1)), 0);
                else                                                            % r r r
                    rFV(i) = eta * 0 + eta^2 * 0 ...
                        + eta^3 * max(FS(envy, max(rro+delta, mn), norm(i+1)), 0);
                end
        end
                                            
                
        V(i) = CV(i) + (aFV(i) - rFV(i));
        
        Like = Like - log(exp(temp*V(i)*(resp(i)))/(1+exp(temp*V(i))));         
    end    
end
