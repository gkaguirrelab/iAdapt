function [bias, P, fitLL] = fitPandB(precisionDeg,targets,responses, adaptorOffset)
%leave precision degrees
%add three vectors: targets, responses, offsets
%%
checkBias = -30:precisionDeg:30;

%preallocate outputs
P = nan(1,size(targets,2)+1);
fitLL = nan(1,size(targets,2)+1);
bias = nan(1,size(targets,2)+1);

%% ALL BLOCKS
for j=1:size(targets,2)
    targetVal=wrap(targets(:,j)*pi/180);
    respVal=wrap(responses(:,j)*pi/180);
    errorVal = wrap(respVal-targetVal);
    errorCorrected = nan(size(errorVal));
    errorCorrected(adaptorOffset(:,j)<0) = errorVal(adaptorOffset(:,j)<0);
    errorCorrected(adaptorOffset(:,j)>0) = -errorVal(adaptorOffset(:,j)>0);
    
    % Get rid of NaNs
    errorCorrected = errorCorrected(~isnan(errorCorrected));
    
    % Identify the bias
    allLL = nan(size(checkBias));
    for i=1:length(checkBias)
        display(['Block ' num2str(j) '; Testing fit with bias ' num2str(checkBias(i)) '...']);
        [~, allLL(i)] = JV10_fit(errorCorrected, deg2rad(ones(size(errorCorrected))*checkBias(i)), deg2rad(ones(size(errorCorrected))*(-45)));
        if i>1
            if allLL(i)<allLL(i-1)
                %break;
            end
        end
    end
    [~,biasIdx] = max(allLL);
    bias(j) = checkBias(biasIdx);
    
    % Calculate precision and fit log-likelihood
    [B, LL] = JV10_fit(errorCorrected, deg2rad(ones(size(errorCorrected))*bias(j)), deg2rad(ones(size(errorCorrected))*(-45)));
    P(j) = 1/k2sd(B(1));
    fitLL(j) = LL;
end
%% COMBINED BLOCK
targetVal=wrap(targets(:)*pi/180);
respVal=wrap(responses(:)*pi/180);
adaptorOffsetALL = adaptorOffset(:);
errorVal = wrap(respVal-targetVal);
errorCorrected = nan(size(errorVal));
errorCorrected(adaptorOffsetALL<0) = errorVal(adaptorOffsetALL<0);
errorCorrected(adaptorOffsetALL>0) = -errorVal(adaptorOffsetALL>0);

% Get rid of NaNs
errorCorrected = errorCorrected(~isnan(errorCorrected));

% Identify the bias
allLL = nan(size(checkBias));
for i=1:length(checkBias)
    display(['Block combined; Testing fit with bias ' num2str(checkBias(i)) '...']);
    [~, allLL(i)] = JV10_fit(errorCorrected, deg2rad(ones(size(errorCorrected))*checkBias(i)), deg2rad(ones(size(errorCorrected))*(-45)));
    if i>1
        if allLL(i)<allLL(i-1)
            %break;
        end
    end
end
[~,biasIdx] = max(allLL);
bias(end) = checkBias(biasIdx);

% Calculate precision and fit log-likelihood
[B, LL] = JV10_fit(errorCorrected, deg2rad(ones(size(errorCorrected))*bias(end)), deg2rad(ones(size(errorCorrected))*(-45)));
P(end) = 1/k2sd(B(1));
fitLL(end) = LL;