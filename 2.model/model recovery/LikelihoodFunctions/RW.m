function [prediction] = RW(initialPrediction, adaptationRate, observation)
    % norm adaptation - RW model
    
    n = length(observation);
    
    prediction = zeros(1, n+1);
    prediction(1) = initialPrediction;    
    
    for i = 1:n
        prediction(1+i) = prediction(i) + adaptationRate*(observation(i)-prediction(i));
    end
    
end