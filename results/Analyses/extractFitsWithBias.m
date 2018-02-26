function [bias, P, fitLL] = extractFitsWithBias(precisionDeg,targets1,resps1,adaptorOffset1,targets2,resps2,adaptorOffset2)

checkBias = -10:precisionDeg:20;

P = nan(1,3);
fitLL = nan(1,3);
bias = nan(1,3);

%% FIRST BLOCK
targetVal=wrap(targets1*pi/180);
respVal=wrap(resps1*pi/180);
errorVal = wrap(respVal-targetVal);
errorCorrected = nan(size(errorVal));
errorCorrected(adaptorOffset1<0) = errorVal(adaptorOffset1<0);
errorCorrected(adaptorOffset1>0) = -errorVal(adaptorOffset1>0);

% Identify the bias
allLL = nan(size(checkBias));
for i=1:length(checkBias)
    [~, allLL(i)] = JV10_fit(errorCorrected, deg2rad(ones(size(errorCorrected))*checkBias(i)), deg2rad(ones(size(errorCorrected))*(-45)));
    if i>1
        if allLL(i)<allLL(i-1)
            %break;
        end
    end
end
[~,biasIdx] = max(allLL);
bias(1) = checkBias(biasIdx);

% Calculate precision and fit log-likelihood
[B, LL] = JV10_fit(errorCorrected, deg2rad(ones(size(errorCorrected))*bias(1)), deg2rad(ones(size(errorCorrected))*(-45)));
P(1) = 1/k2sd(B(1));
fitLL(1) = LL;

%% SECOND BLOCK
targetVal=wrap(targets2*pi/180);
respVal=wrap(resps2*pi/180);
errorVal = wrap(respVal-targetVal);
errorCorrected = nan(size(errorVal));
errorCorrected(adaptorOffset2<0) = errorVal(adaptorOffset2<0);
errorCorrected(adaptorOffset2>0) = -errorVal(adaptorOffset2>0);

% Identify the bias
allLL = nan(size(checkBias));
for i=1:length(checkBias)
    [~, allLL(i)] = JV10_fit(errorCorrected, deg2rad(ones(size(errorCorrected))*checkBias(i)), deg2rad(ones(size(errorCorrected))*(-45)));
    if i>1
        if allLL(i)<allLL(i-1)
            %break;
        end
    end
end
[~,biasIdx] = max(allLL);
bias(2) = checkBias(biasIdx);

% Calculate precision and fit log-likelihood
[B, LL] = JV10_fit(errorCorrected, deg2rad(ones(size(errorCorrected))*bias(2)), deg2rad(ones(size(errorCorrected))*(-45)));
P(2) = 1/k2sd(B(1));
fitLL(2) = LL;

%% COMBINED BLOCKS
targetVal=[wrap(targets1*pi/180); wrap(targets2*pi/180)];
respVal=[wrap(resps1*pi/180); wrap(resps2*pi/180)];
adaptorOffsetBOTH = [adaptorOffset1; adaptorOffset2];
errorVal = wrap(respVal-targetVal);
errorCorrected = nan(size(errorVal));
errorCorrected(adaptorOffsetBOTH<0) = errorVal(adaptorOffsetBOTH<0);
errorCorrected(adaptorOffsetBOTH>0) = -errorVal(adaptorOffsetBOTH>0);

% Identify the bias
allLL = nan(size(checkBias));
for i=1:length(checkBias)
    [~, allLL(i)] = JV10_fit(errorCorrected, deg2rad(ones(size(errorCorrected))*checkBias(i)), deg2rad(ones(size(errorCorrected))*(-45)));
    if i>1
        if allLL(i)<allLL(i-1)
            %break;
        end
    end
end
[~,biasIdx] = max(allLL);
bias(3) = checkBias(biasIdx);

% Calculate precision and fit log-likelihood
[B, LL] = JV10_fit(errorCorrected, deg2rad(ones(size(errorCorrected))*bias(3)), deg2rad(ones(size(errorCorrected))*(-45)));
P(3) = 1/k2sd(B(1));
fitLL(3) = LL;