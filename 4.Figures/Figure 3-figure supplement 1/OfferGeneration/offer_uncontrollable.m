function [offer_sequence] = offer_uncontrollable()

    offers = [ones(1,2) 2*ones(1,3) 3*ones(1,3) 4*ones(1,4) 5*ones(1,5) ...
    6*ones(1,4) 7*ones(1,3) 8*ones(1,3) 9*ones(1,2)];

    offers = Shuffle(offers);
    
    offer_sequence = [5 offers];    
    
end