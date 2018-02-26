%% DEFINE PARAMETERS
minAccuracy = 50;
biasPrecision = 0.1;

%% DOWNLOAD DATA
% Download the data (and parameters) from the server
[rawData,params] = downloadData;

%% FORMAT DATA
% Format the data for analyses (add date range to filter subjects)
[payTable, payArray] = paySubjects(rawData,{'December 01, 2014', 'December 31, 2014'});
data = formatData(rawData,{'December 01, 2014', 'December 31, 2014'});
subjIDs = fieldnames(data);
numSubj = length(subjIDs);

% Calculate average pay per complete data
sprintf('The average pay per complete data is: $ %.2f', nansum(payArray)/numSubj)

%% FILTER SUBJECTS
% Calculate the number of trials completed per task
trialsCompleted = nan(numSubj,12);
for s=1:numSubj
    thisSubj = subjIDs{s};
    trialsCompleted(s,1) = length(unique(data.(thisSubj).calibColor.trialNum));
    trialsCompleted(s,2) = length(unique(data.(thisSubj).calibColor2.trialNum));
    trialsCompleted(s,3) = length(unique(data.(thisSubj).calibFace.trialNum));
    trialsCompleted(s,4) = length(unique(data.(thisSubj).calibFace2.trialNum));
    trialsCompleted(s,5) = length(unique(data.(thisSubj).primeColorLong.trialNum));
    trialsCompleted(s,6) = length(unique(data.(thisSubj).primeColorLong2.trialNum));
    trialsCompleted(s,7) = length(unique(data.(thisSubj).primeFaceLong.trialNum));
    trialsCompleted(s,8) = length(unique(data.(thisSubj).primeFaceLong2.trialNum));
    trialsCompleted(s,9) = length(unique(data.(thisSubj).workingMemoryColor.trialNum));
    trialsCompleted(s,10) = length(unique(data.(thisSubj).workingMemoryColor2.trialNum));
    trialsCompleted(s,11) = length(unique(data.(thisSubj).workingMemoryFace.trialNum));
    trialsCompleted(s,12) = length(unique(data.(thisSubj).workingMemoryFace2.trialNum));
end
% Extract subjects that completed less than the correct number of trials
incompleteSessions = sum(~(trialsCompleted == repmat([15*ones(1,4) 30*ones(1,8)],numSubj,1)),2);
% incompleteSubjects = subjIDs(incompleteSessions~=0);
% for s=1:length(incompleteSubjects)
%     data = rmfield(data,incompleteSubjects{s});
% end
% subjIDs = fieldnames(data);
% numSubj = length(subjIDs);

% Calculate the average accuracy per task
averageAccuracy = nan(numSubj,12);
for s=1:numSubj
    thisSubj = subjIDs{s};
    averageAccuracy(s,1) = nanmean(data.(thisSubj).calibColor.accuracy);
    averageAccuracy(s,2) = nanmean(data.(thisSubj).calibColor2.accuracy);
    averageAccuracy(s,3) = nanmean(data.(thisSubj).calibFace.accuracy);
    averageAccuracy(s,4) = nanmean(data.(thisSubj).calibFace2.accuracy);
    averageAccuracy(s,5) = nanmean(data.(thisSubj).primeColorLong.accuracy);
    averageAccuracy(s,6) = nanmean(data.(thisSubj).primeColorLong2.accuracy);
    averageAccuracy(s,7) = nanmean(data.(thisSubj).primeFaceLong.accuracy);
    averageAccuracy(s,8) = nanmean(data.(thisSubj).primeFaceLong2.accuracy);
    averageAccuracy(s,9) = nanmean(data.(thisSubj).workingMemoryColor.accuracy);
    averageAccuracy(s,10) = nanmean(data.(thisSubj).workingMemoryColor2.accuracy);
    averageAccuracy(s,11) = nanmean(data.(thisSubj).workingMemoryFace.accuracy);
    averageAccuracy(s,12) = nanmean(data.(thisSubj).workingMemoryFace2.accuracy);
end
% Extract subjects that had less than minimum accuracy
poorAccuracy = any(averageAccuracy<minAccuracy,2);
% poorAccuracySubjects = subjIDs(poorAccuracy);
% for s=1:length(poorAccuracySubjects)
%     data = rmfield(data,poorAccuracySubjects{s});
% end
% subjIDs = fieldnames(data);
% numSubj = length(subjIDs);


%% RUN THE REAL ANALYSIS!!!
addpath('./jv10')% Pre-allocate variables for the parameters of interest
calibColorP = nan(numSubj,3);
calibFaceP = nan(numSubj,3);
workingMemoryColorP = nan(numSubj,3);
workingMemoryFaceP = nan(numSubj,3);
primeColorLongP = nan(numSubj,3);
primeColorLongB = nan(numSubj,3);
primeFaceLongP = nan(numSubj,3);
primeFaceLongB = nan(numSubj,3);

% Pre-allocate variables for the log-likelihood fits
calibColor_fitLL = nan(numSubj,3);
calibFace_fitLL = nan(numSubj,3);
workingMemoryColor_fitLL = nan(numSubj,3);
workingMemoryFace_fitLL = nan(numSubj,3);
primeColorLong_fitLL = nan(numSubj,3);
primeFaceLong_fitLL = nan(numSubj,3);

% Extract relevant parameters per subject
for s=1:numSubj
    display(['Analyzing subject: ' num2str(s)]);    
    thisSubj = subjIDs{s};
    
    % CalibColor
    [calibColorP(s,:), calibColor_fitLL(s,:)] = extractFits(data.(thisSubj).calibColor.targetVal,data.(thisSubj).calibColor.responseVal,data.(thisSubj).calibColor2.targetVal,data.(thisSubj).calibColor2.responseVal);
    % CalibFace
    [calibFaceP(s,:), calibFace_fitLL(s,:)] = extractFits(data.(thisSubj).calibFace.targetVal,data.(thisSubj).calibFace.responseVal,data.(thisSubj).calibFace2.targetVal,data.(thisSubj).calibFace2.responseVal);
    % WorkingMemoryColor
    [workingMemoryColorP(s,:), workingMemoryColor_fitLL(s,:)] = extractFits(data.(thisSubj).workingMemoryColor.targetVal,data.(thisSubj).workingMemoryColor.responseVal,data.(thisSubj).workingMemoryColor2.targetVal,data.(thisSubj).workingMemoryColor2.responseVal);
    % WorkingMemoryFace
    [workingMemoryFaceP(s,:), workingMemoryFace_fitLL(s,:)] = extractFits(data.(thisSubj).workingMemoryFace.targetVal,data.(thisSubj).workingMemoryFace.responseVal,data.(thisSubj).workingMemoryFace2.targetVal,data.(thisSubj).workingMemoryFace2.responseVal);
    % PrimeColor
    [primeColorLongB(s,:), primeColorLongP(s,:), primeColorLong_fitLL(s,:)] = extractFitsWithBias(biasPrecision,data.(thisSubj).primeColorLong.targetVal,data.(thisSubj).primeColorLong.responseVal,data.(thisSubj).primeColorLong.adaptor,data.(thisSubj).primeColorLong2.targetVal,data.(thisSubj).primeColorLong2.responseVal,data.(thisSubj).primeColorLong2.adaptor);
    % PrimeFace
    [primeFaceLongB(s,:), primeFaceLongP(s,:), primeFaceLong_fitLL(s,:)] = extractFitsWithBias(biasPrecision,data.(thisSubj).primeFaceLong.targetVal,data.(thisSubj).primeFaceLong.responseVal,data.(thisSubj).primeFaceLong.adaptor,data.(thisSubj).primeFaceLong2.targetVal,data.(thisSubj).primeFaceLong2.responseVal,data.(thisSubj).primeFaceLong2.adaptor);
    
end

%{
allLLfits = [calibColor_fitLL(:,3) calibFace_fitLL(:,3) workingMemoryColor_fitLL(:,3) workingMemoryFace_fitLL(:,3) primeColorLong_fitLL(:,3) primeFaceLong_fitLL(:,3)];
poorfit_or_incompletedata_or_pooraccuracy = any([poorAccuracy incompleteSessions any(allLLfits<-50,2)],2);

subjIDs = subjIDs(incompleteSessions==0);
numSubj = length(subjIDs);
calibColorP=calibColorP(incompleteSessions==0,:);calibColor_fitLL=calibColor_fitLL(incompleteSessions==0,:);
calibFaceP=calibFaceP(incompleteSessions==0,:);calibFace_fitLL=calibFace_fitLL(incompleteSessions==0,:);
workingMemoryColorP=workingMemoryColorP(incompleteSessions==0,:);workingMemoryColor_fitLL=workingMemoryColor_fitLL(incompleteSessions==0,:);
workingMemoryFaceP=workingMemoryFaceP(incompleteSessions==0,:);workingMemoryFace_fitLL=workingMemoryFace_fitLL(incompleteSessions==0,:);
primeColorLongB=primeColorLongB(incompleteSessions==0,:);primeColorLongP=primeColorLongP(incompleteSessions==0,:);primeColorLong_fitLL=primeColorLong_fitLL(incompleteSessions==0,:);
primeFaceLongB=primeFaceLongB(incompleteSessions==0,:);primeFaceLongP=primeFaceLongP(incompleteSessions==0,:);primeFaceLong_fitLL=primeFaceLong_fitLL(incompleteSessions==0,:);

subjs2Include = and(incompleteSessions==0,~any([calibColor_R2', calibFace_R2', primeColorLong_R2', primeFaceLong_R2', workingMemoryColor_R2', workingMemoryFace_R2']<0.5,2));
subjIDs = subjIDs(subjs2Include);
numSubj = length(subjIDs);
calibColorP=calibColorP(subjs2Include,:);calibColor_fitLL=calibColor_fitLL(subjs2Include,:);
calibFaceP=calibFaceP(subjs2Include,:);calibFace_fitLL=calibFace_fitLL(subjs2Include,:);
workingMemoryColorP=workingMemoryColorP(subjs2Include,:);workingMemoryColor_fitLL=workingMemoryColor_fitLL(subjs2Include,:);
workingMemoryFaceP=workingMemoryFaceP(subjs2Include,:);workingMemoryFace_fitLL=workingMemoryFace_fitLL(subjs2Include,:);
primeColorLongB=primeColorLongB(subjs2Include,:);primeColorLongP=primeColorLongP(subjs2Include,:);primeColorLong_fitLL=primeColorLong_fitLL(subjs2Include,:);
primeFaceLongB=primeFaceLongB(subjs2Include,:);primeFaceLongP=primeFaceLongP(subjs2Include,:);primeFaceLong_fitLL=primeFaceLong_fitLL(subjs2Include,:);

%}

% Fit analysis:
% Plot individual fits with the mixture modelling and Von Mises
% distribution, together with log-likelihood values
plot_fits;
subjIDs_completesessions_r2greaterthan05 = and(incompleteSessions==0,all([calibColor_R2' calibFace_R2' workingMemoryColor_R2' workingMemoryFace_R2' primeColorLong_R2' primeFaceLong_R2']>0.5,2));

% Individual differences analysis:
% Plot scatter plots together with calculated correlation values for each
% pair of measures of interest
plot_results;

plot_results_filtered;