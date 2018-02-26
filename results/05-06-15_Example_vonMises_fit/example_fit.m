%% DEFINE PARAMETERS
dataFile = '../../Data/C_colorsOnly_99subj_lowSaturation.mat';
dirs.dataDir = '~/Dropbox/Marcelo/UPenn/Documents/Projects/mTurkPsych/Data';
dirs.codeDir = '~/Dropbox/Marcelo/UPenn/Documents/Projects/mTurkPsych/Code';
subjNum = 1;


%% ADD TOOLBOXES TO PATH
display(sprintf('Loading neccessary Toolboxes...'));
addpath(genpath(fullfile(dirs.codeDir,'jv10')));
display(sprintf('... Done!\n'));


%% DEFINE NECESSARY VARIABLES
load(dataFile)
subjIDs = fieldnames(data);
xaxis = -pi:0.01:pi;


%% ANALYZE
figure(1);
thisSubj = subjIDs{subjNum};

% Read in trial information
targets = [];
responses = [];
adaptorOffset = [];
for i=1:6
    thisBlock = eval(['data.(thisSubj).adaptColor' num2str(i)]);
    targets = [targets; thisBlock.targetVal];
    responses = [responses; thisBlock.responseVal];
    adaptorOffset = [adaptorOffset; thisBlock.adaptor];
end

% Manipulate trial information
targetVal=wrap(deg2rad(targets));
respVal=wrap(deg2rad(responses));
errorVal = rad2deg(wrap(respVal-targetVal));
errorCorrected = nan(size(errorVal));
errorCorrected(adaptorOffset<0) = errorVal(adaptorOffset<0);
errorCorrected(adaptorOffset>0) = -errorVal(adaptorOffset>0);

% Identify the bias
%{
checkBias = -20:1:40;
allLL = nan(size(checkBias));
for i=1:length(checkBias)
    [~, allLL(i)] = JV10_fit(errorCorrected, deg2rad(ones(size(errorCorrected))*checkBias(i)), deg2rad(ones(size(errorCorrected))*(-45)));
    display(i);
end
[~,biasIdx] = max(allLL);
subjBias = checkBias(biasIdx);
%}
subjBias = data.(thisSubj).adaptColorB(subjNum,end);


% Calculate precision and fit log-likelihood
[B, LL] = JV10_fit(errorCorrected, deg2rad(ones(size(errorCorrected))*subjBias), deg2rad(ones(size(errorCorrected))*(-45)));
K=B(1);
pT=B(2);
pN=B(3);
pU=B(4);
vonmises_component = pT * vonmisespdf(xaxis,deg2rad(subjBias),K)/sum(vonmisespdf(xaxis,deg2rad(subjBias),K));
uniform_component = pU * ones(size(xaxis))/sum(ones(size(xaxis)));
nontarget_component = pN * vonmisespdf(xaxis,deg2rad(-45),K)/sum(vonmisespdf(xaxis,deg2rad(-45),K));
fullfit = vonmises_component + uniform_component + nontarget_component;
subjPrecision = 1/k2sd(K);
subjLL = LL;

% Create the histogram
[f,x]=hist(rad2deg(errorCorrected),-180:5:180);

% Plot histogram and fit curve
dx = diff(x(1:2));
bar(x,f/sum(f*dx));
hold on
plot(rad2deg(xaxis),fullfit/trapz(rad2deg(xaxis),fullfit),'r');
hold off
