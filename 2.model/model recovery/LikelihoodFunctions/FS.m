function [V] = FS(envy, offer, norm)

    V = offer - envy * (max(norm - offer, 0));
    
end