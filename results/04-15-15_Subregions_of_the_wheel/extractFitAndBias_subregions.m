function extractFitAndBias_subregions(subjNum,dataFile,numSubRegions,outputDir,biasPrecision)

display(sprintf('Working on subject: %d',subjNum));
display(sprintf('dataFile: %s',dataFile));
display(sprintf('outputDir: %s',outputDir));
display(sprintf('biasPrecision: %.4f \n\n',biasPrecision));

%% CHECK INPUTS
if nargin<5
    biasPrecision = 0.1;
end
if nargin<4
    outputDir = './output';
end
if nargin<3
    numSubRegions = 6;
end

%% LOAD DATAFILE
load(dataFile);
subjIDs = fieldnames(data);

%% RUN THE REAL ANALYSIS!!!
thisSubj = subjIDs{subjNum};

% Create subregion intervals
subregions = 0:(360/numSubRegions):360;
subregions = subregions-0.5;

% Extract relevant parameters per subject
validTrials = min([length(data.(thisSubj).adaptColor1.targetVal), length(data.(thisSubj).adaptColor2.targetVal), length(data.(thisSubj).adaptColor3.targetVal), length(data.(thisSubj).adaptColor4.targetVal),length(data.(thisSubj).adaptColor5.targetVal),length(data.(thisSubj).adaptColor6.targetVal)]);
targets=[data.(thisSubj).adaptColor1.targetVal(1:validTrials), data.(thisSubj).adaptColor2.targetVal(1:validTrials), data.(thisSubj).adaptColor3.targetVal(1:validTrials), data.(thisSubj).adaptColor4.targetVal(1:validTrials),data.(thisSubj).adaptColor5.targetVal(1:validTrials),data.(thisSubj).adaptColor6.targetVal(1:validTrials)];
responses=[data.(thisSubj).adaptColor1.responseVal(1:validTrials), data.(thisSubj).adaptColor2.responseVal(1:validTrials), data.(thisSubj).adaptColor3.responseVal(1:validTrials), data.(thisSubj).adaptColor4.responseVal(1:validTrials),data.(thisSubj).adaptColor5.responseVal(1:validTrials),data.(thisSubj).adaptColor6.responseVal(1:validTrials)];
adaptorOffset=[data.(thisSubj).adaptColor1.adaptor(1:validTrials),data.(thisSubj).adaptColor2.adaptor(1:validTrials),data.(thisSubj).adaptColor3.adaptor(1:validTrials), data.(thisSubj).adaptColor4.adaptor(1:validTrials),data.(thisSubj).adaptColor5.adaptor(1:validTrials),data.(thisSubj).adaptColor6.adaptor(1:validTrials)];

% Separate by subregions of the wheel
targetsCell = cell(1,numSubRegions);
responsesCell = cell(1,numSubRegions);
adaptorOffsetCell = cell(1,numSubRegions);
for i=1:numSubRegions
    theseTrials = and(targets(:)>subregions(i),targets(:)<subregions(i+1));
    targetsCell{i} = targets(theseTrials);
    responsesCell{i} = responses(theseTrials);
    adaptorOffsetCell{i} = adaptorOffset(theseTrials);
end
newTargets = nan(max(cellfun(@length,targetsCell)),numSubRegions);
newResponses = nan(max(cellfun(@length,targetsCell)),numSubRegions);
newAdaptorOffset = nan(max(cellfun(@length,targetsCell)),numSubRegions);
for i=1:numSubRegions
    newTargets(1:length(targetsCell{i}),i) = targetsCell{i};
    newResponses(1:length(responsesCell{i}),i) = responsesCell{i};
    newAdaptorOffset(1:length(adaptorOffsetCell{i}),i) = adaptorOffsetCell{i};
end

% CalibColor
[calibColorP, calibColor_fitLL] = extractFits(data.(thisSubj).calibColor.targetVal, data.(thisSubj).calibColor.responseVal,data.(thisSubj).calibColor2.targetVal,data.(thisSubj).calibColor2.responseVal);
% WorkingMemoryColor
[workingMemoryColorP, workingMemoryColor_fitLL] = extractFits(data.(thisSubj).workingMemoryColor.targetVal, data.(thisSubj).workingMemoryColor.responseVal,data.(thisSubj).workingMemoryColor2.targetVal,data.(thisSubj).workingMemoryColor2.responseVal);
% adaptColor
[adaptColorB, adaptColorP, adaptColor_fitLL] = fitPandB(biasPrecision,newTargets,newResponses,newAdaptorOffset);

%% SAVE OUTPUT
filename = fullfile(outputDir, [thisSubj '.mat']);
save(filename)

