function [next_offer] = offer_controllable(offer, resp)

    mn = 1;
    mx = 9;

    offer_change = randi(3) - 1; %[0 1 2], uniform distribution

    if resp == 1
        next_offer = offer - offer_change;
    elseif resp == 0
        next_offer = offer + offer_change;
    end
    
    next_offer = max(min(next_offer, mx), mn);
end