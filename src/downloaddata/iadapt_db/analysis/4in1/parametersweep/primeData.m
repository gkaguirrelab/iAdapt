function [precisionRad, biasRad, probGuess, probPrime, errorDeg, percentCloserToTargetThanPrime] = primeData(dataStructure,subjIDs)

addpath('./jv10');

dataDeg = cell(length(subjIDs),1);
precisionRad = nan(length(subjIDs),1);
biasRad = nan(length(subjIDs),1);
probGuess = nan(length(subjIDs),1);
probPrime = nan(length(subjIDs),1);
percentCloserToTargetThanPrime = nan(length(subjIDs),1);
errorDeg = [];
for s = 1:length(subjIDs)
    thisID = subjIDs(s);
    subjData = ismember(dataStructure.userID,thisID);
    if isnumeric(dataStructure.responseGiven(subjData,:))
        responseGiven = dataStructure.responseGiven(subjData,:);
    else
        responseGiven = str2double(cellstr(dataStructure.responseGiven(subjData,:)));
    end
    correctResp = dataStructure.correctResp(subjData,:);
    primeShift = dataStructure.primeShift(subjData,:);
    
    % Shift arrays to correct range
    X = wrap(responseGiven/180*pi);
    T = wrap(correctResp/180*pi);
    E = wrap(X-T);
    
    % Identify if this user matched primes more than targets
    T2 = wrap((correctResp+primeShift)/180*pi);
    E2 = wrap(X-T2);
    percentCloserToTargetThanPrime(s) = sum(abs(E)<abs(E2))/sum(subjData);
    
    % Mixture modelling to infer guesses and non-target responses
    B = JV10_fit(X(~isnan(E)), T(~isnan(E)), T2(~isnan(E)));
    probPrime(s) = B(3);
    probGuess(s) = B(4);
    
    % Mirror errors according to the relative position of the prime
    E(primeShift>0) = -E(primeShift>0);
    
    % Model bias and precision
    [P, B] = JV10_error(wrap(E));
    
    % Save to output arrays
    errorDeg = [errorDeg; E];
    precisionRad(s) = P;
    biasRad(s) = B;
end


