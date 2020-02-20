function [Like, delta, norm, V, CV, aFV, rFV] = nRv_f5_cap2_t20_etaf(offer, resp, fixed, free)
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
                    aaao = max(aao-delta, mn);
                    if FS(envy, aaao, norm(i+1)) > 0                 % a a a a
                        aFV(i) = eta * FS(envy, ao, norm(i+1)) + eta^2 * FS(envy, aao, norm(i+1)) ...
                        + eta^3 * FS(envy, aaao, norm(i+1)) + eta^4 * max(FS(envy, max(aaao-delta, mn), norm(i+1)), 0);
                    else                                                            % a a a r
                        aFV(i) = eta * FS(envy, ao, norm(i+1)) + eta^2 * FS(envy, aao, norm(i+1)) ...
                        + eta^3 * 0 + eta^4 * max(FS(envy, max(aaao+delta, mn), norm(i+1)), 0);
                    end                                      
                else                                                            % a a r
                    aaro = max(aao+delta, mn);
                    if FS(envy, aaro, norm(i+1)) > 0                 % a a r a
                        aFV(i) = eta * FS(envy, ao, norm(i+1)) + eta^2 * 0 ...
                        + eta^3 * FS(envy, aaro, norm(i+1)) + eta^4 * max(FS(envy, max(aaro-delta, mn), norm(i+1)), 0);
                    else                                                            % a a r r
                        aFV(i) = eta * FS(envy, ao, norm(i+1)) + eta^2 * 0 ...
                        + eta^3 * 0 + eta^4 * max(FS(envy, max(aaro+delta, mn), norm(i+1)), 0);
                    end                                      
                end
            
        else                                                                 % a r
                aro = max(ao+delta, mn);                
                if FS(envy, aro, norm(i+1)) > 0                 % a r a
                    arao = max(aro-delta, mn);
                    if FS(envy, arao, norm(i+1)) > 0                 % a r a a
                        aFV(i) = eta * 0 + eta^2 * FS(envy, aro, norm(i+1)) ...
                        + eta^3 * FS(envy, arao, norm(i+1)) + eta^4 * max(FS(envy, max(arao-delta, mn), norm(i+1)), 0);
                    else                                                            % a r a r
                        aFV(i) = eta * 0 + eta^2 * FS(envy, aro, norm(i+1)) ...
                        + eta^3 * 0 + eta^4 * max(FS(envy, max(arao+delta, mn), norm(i+1)), 0);
                    end                    
                else                                                            % a r r
                    arro = max(aro+delta, mn);
                    if FS(envy, arro, norm(i+1)) > 0                 % a r r a
                        aFV(i) = eta * 0 + eta^2 * 0 ...
                        + eta^3 * FS(envy, arro, norm(i+1)) + eta^4 * max(FS(envy, max(arro-delta, mn), norm(i+1)), 0);
                    else                                                            % a r r r
                        aFV(i) = eta * 0 + eta^2 * 0 ...
                        + eta^3 * 0 + eta^4 * max(FS(envy, max(arro+delta, mn), norm(i+1)), 0);
                    end        
                end
        end
        
        
        % FV_reject
        
        ro = max(offer(i)+delta, mn);       % ro = expected offer1 when reject offer0
        
        if FS(envy, ro, norm(i+1)) > 0                          % r a            
                rao = max(ro-delta, mn);                
                if FS(envy, rao, norm(i+1)) > 0                 % r a a
                    raao = max(rao-delta, mn);                
                    if FS(envy, raao, norm(i+1)) > 0                 % r a a a
                        rFV(i) = eta * FS(envy, ro, norm(i+1)) + eta^2 * FS(envy, rao, norm(i+1)) ...
                        + eta^3 * FS(envy, raao, norm(i+1)) + eta^4 * max(FS(envy, max(raao-delta, mn), norm(i+1)), 0);
                    else                                                            % r a a r
                        rFV(i) = eta * FS(envy, ro, norm(i+1)) + eta^2 * FS(envy, rao, norm(i+1)) ...
                        + eta^3 * 0 + eta^4 * max(FS(envy, max(raao+delta, mn), norm(i+1)), 0);
                    end                                                          
                else                                                            % r a r
                    raro = max(rao+delta, mn);                
                    if FS(envy, raro, norm(i+1)) > 0                 % r a r a
                        rFV(i) = eta * FS(envy, ro, norm(i+1)) + eta^2 * 0 ...
                        + eta^3 * FS(envy, raro, norm(i+1)) + eta^4 * max(FS(envy, max(raro-delta, mn), norm(i+1)), 0);
                    else                                                            % r a r r
                        rFV(i) = eta * FS(envy, ro, norm(i+1)) + eta^2 * 0 ...
                        + eta^3 * 0 + eta^4 * max(FS(envy, max(raro+delta, mn), norm(i+1)), 0);
                    end                                                                              
                end            
        else                                                                 % r r
                rro = max(ro+delta, mn);                
                if FS(envy, rro, norm(i+1)) > 0                 % r r a
                    rrao = max(rro-delta, mn);                
                    if FS(envy, rrao, norm(i+1)) > 0                 % r r a a
                        rFV(i) = eta * 0 + eta^2 * FS(envy, rro, norm(i+1)) ...
                        + eta^3 * FS(envy, rrao, norm(i+1)) + eta^4 * max(FS(envy, max(rrao-delta, mn), norm(i+1)), 0);
                    else                                                            % r r a r
                        rFV(i) = eta * 0 + eta^2 * FS(envy, rro, norm(i+1)) ...
                        + eta^3 * 0 + eta^4 * max(FS(envy, max(rrao+delta, mn), norm(i+1)), 0);
                    end                        
                else                                                            % r r r
                    rrro = max(rro+delta, mn);                
                    if FS(envy, rrro, norm(i+1)) > 0                 % r r r a
                        rFV(i) = eta * 0 + eta^2 * 0 ...
                        + eta^3 * FS(envy, rrro, norm(i+1)) + eta^4 * max(FS(envy, max(rrro-delta, mn), norm(i+1)), 0);
                    else                                                            % r r r r
                        rFV(i) = eta * 0 + eta^2 * 0 ...
                        + eta^3 * 0 + eta^4 * max(FS(envy, max(rrro+delta, mn), norm(i+1)), 0);
                    end                                            
                end
        end
                                            
                
        V(i) = CV(i) + (aFV(i) - rFV(i));
        
        Like = Like - log(exp(temp*V(i)*(resp(i)))/(1+exp(temp*V(i))));         
    end    
end
