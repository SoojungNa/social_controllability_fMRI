function [pmod] = nRv_f0_t20_pmod_z(offer, resp, fixed, free )

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
        
        if resp(i) == 1 % accept
            xV(i) = V(i);
            Vgap(i) = V(i) - 0;
        elseif resp(i) == 0 % reject
            xV(i) = 0;
            Vgap(i) = 0 - V(i);
        end
        
    end
    
    pre_norm       = norm(1:end-1); % initial norm @ offer onset        
    post_norm      = norm(2:end);    
    nPE            = offer' - pre_norm;   % normPE updated right after observation
    weighted_nPE   = normAdapt*nPE;    
    norm_violation = max(0, post_norm - offer');
    aversion       = envy*norm_violation; % aversion based on updated norm        
    V_accept        = V;
    V_reject        = zeros(1,n);

        
    pmod = struct('offer_z', normalize(offer'), ...
                    'pre_norm_z', normalize(pre_norm), ...
                    'post_norm_z', normalize(post_norm), ...                    
                    'nPE_z', normalize(nPE), ...
                    'weighted_nPE_z', normalize(weighted_nPE), ...                    
                    'norm_violation_z', normalize(norm_violation), ...
                    'aversion_z', normalize(aversion), ...
                    'V_accept_z', normalize(V_accept), ...
                    'V_reject_z', normalize(V_reject), ...
                    'xV_z', normalize(xV), ...                    
                    'Vgap_z', normalize(Vgap));

end