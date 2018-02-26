function fitPrior_bootstrap(stimType,outputDir)

checkBias = -20:0.1:20;
addpath(genpath('/data/jet/mattar/mTurk/Scripts/Code'));

% Initialize random seed
rng('shuffle','twister');

%% CHECK INPUTS
if ~exist('outputDir','var')
    outputDir = './output';
end

display(sprintf('Data will be saved to: %s',outputDir));

%% LOAD DATA
subjNum = [];
blockNum = [];
targetVal = [];
responseVal = [];

d1 = load('/data/jet/mattar/mTurk/Scripts/A_colorsAndFaces_101subj.mat');
subjIDs = fieldnames(d1.data);
numSubj1 = length(subjIDs);
for s=1:numSubj1
    thisSubj = subjIDs{s};
    % Block 1
    numTrials = length(d1.data.(thisSubj).(['workingMemory' stimType]).targetVal);
    subjNum = [subjNum; repmat(s,numTrials,1)];
    blockNum = [blockNum; 1*ones(numTrials,1)];
    targetVal = [targetVal; d1.data.(thisSubj).(['workingMemory' stimType]).targetVal];
    responseVal = [responseVal; d1.data.(thisSubj).(['workingMemory' stimType]).responseVal];
    % Block 2
    numTrials = length(d1.data.(thisSubj).(['workingMemory' stimType '2']).targetVal);
    subjNum = [subjNum; repmat(s,numTrials,1)];
    blockNum = [blockNum; 2*ones(numTrials,1)];
    targetVal = [targetVal; d1.data.(thisSubj).(['workingMemory' stimType '2']).targetVal];
    responseVal = [responseVal; d1.data.(thisSubj).(['workingMemory' stimType '2']).responseVal];
end
load('/data/jet/mattar/mTurk/Scripts/B_colorsAndFaces_101subj.mat');
subjIDs = fieldnames(data);
numSubj2 = length(subjIDs);
for s=1:numSubj2
    thisSubj = subjIDs{s};
    % Block 1
    numTrials = length(data.(thisSubj).(['workingMemory' stimType]).targetVal);
    subjNum = [subjNum; repmat(s+numSubj1,numTrials,1)];
    blockNum = [blockNum; 1*ones(numTrials,1)];
    targetVal = [targetVal; data.(thisSubj).(['workingMemory' stimType]).targetVal];
    responseVal = [responseVal; data.(thisSubj).(['workingMemory' stimType]).responseVal];
    % Block 2
    numTrials = length(data.(thisSubj).(['workingMemory' stimType '2']).targetVal);
    subjNum = [subjNum; repmat(s+numSubj1,numTrials,1)];
    blockNum = [blockNum; 2*ones(numTrials,1)];
    targetVal = [targetVal; data.(thisSubj).(['workingMemory' stimType '2']).targetVal];
    responseVal = [responseVal; data.(thisSubj).(['workingMemory' stimType '2']).responseVal];
end


%% CREATE BOOTSTRAP SAMPLE
subjList = unique(subjNum);
numSubj = length(subjList);
bootsample = randi(numSubj,numSubj,1);

% Extract data for this bootstrap sample
targBoot = [];
respBoot = [];
for i=1:numel(bootsample)
    targBoot = [targBoot; targetVal(subjNum==bootsample(i))];
    respBoot = [respBoot; responseVal(subjNum==bootsample(i))];
end
if length(targBoot)~=length(respBoot)
    error('Target and Response array have different lengths');
end


%% RUN ANALYSIS WITH THIS BOOTSTRAP SAMPLE


uniqueTargets = unique(targetVal);
Ponly_P = nan(size(uniqueTargets));
Ponly_LL = nan(size(uniqueTargets));
PandB_B = nan(size(uniqueTargets));
PandB_P = nan(size(uniqueTargets));
PandB_LL = nan(size(uniqueTargets));
for i=1:length(uniqueTargets)
    display(sprintf('Calculating bias and precision for distribution around target=%d deg.',uniqueTargets(i)));
    
    r = wrap(respBoot(targBoot==uniqueTargets(1))*pi/180);
    t = wrap(targBoot(targBoot==uniqueTargets(1))*pi/180);
    e = wrap(t-r);
    
    % Fit precision only
    [B, LL] = JV10_fit(r,t); % B is a vector with [K pT pN pU]
    Ponly_P(i) = 1/k2sd(B(1));
    Ponly_LL(i) = LL;
    
    % Calculate bias
    allLL = nan(size(checkBias));
    for j=1:length(checkBias)
        [~, allLL(j)] = JV10_fit(e, deg2rad(checkBias(j)*ones(size(e))));
    end
    [~,biasIdx] = max(allLL);
    PandB_B(i) = checkBias(biasIdx);
    
    % Calculate precision and fit log-likelihood
    [B, LL] = JV10_fit(e, deg2rad(PandB_B(i)*ones(size(e))));
    PandB_P(i) = 1/k2sd(B(1));
    PandB_LL(i) = LL;
end


%% SAVE OUTPUT
filename = fullfile(outputDir, sprintf('bootstrap_%s.mat', datestr(now,'yyyymmdd_HHMMSS')));
if ~exist(outputDir,'dir')
    mkdir(outputDir);
end
save(filename)

