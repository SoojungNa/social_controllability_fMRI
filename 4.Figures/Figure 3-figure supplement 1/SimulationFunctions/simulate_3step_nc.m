function [offer, resp] = simulate_3step_nc(free)
% nRv_f4_cap2_t20_etaf

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
                
        prob(i) = 1 ./ (1+exp(-temp * V(i)));
        resp(i) = randsample([1, 0], 1, true, [prob(i); 1-prob(i)]);       
        
    end        
end