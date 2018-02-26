% Across subject, color precision and color bias are anti-correlated
%% DEFINE PARAMETERS
dataFile = {'A_colorsAndFaces_101subj.mat', 'B_colorsAndFaces_101subj.mat', 'C_colorsOnly_99subj_lowSaturation.mat', 'E_colorsOnly_98subj_highSaturation.mat'};
dirs.dataDir = '~/Dropbox/Marcelo/UPenn/Documents/Projects/mTurkPsych/Data';
dirs.codeDir = '~/Dropbox/Marcelo/UPenn/Documents/Projects/mTurkPsych/Code';


%% ADD TOOLBOXES TO PATH
display(sprintf('Loading neccessary Toolboxes...'));
addpath(genpath(fullfile(dirs.codeDir,'jv10')));
display(sprintf('... Done!\n'));


%% DEFINE NECESSARY VARIABLES
numDatasets = length(dataFile);


%% CALCULATE CORRELATIONS
load(fullfile(dirs.dataDir,dataFile{1}))
[rho, pval] = corr(primeColorLongB(:,3),primeColorLongP(:,3));
display(sprintf('DATASET 1: The correlation between Color precision and Color bias across subjects is r=%.2f (p=%.4f)',rho,pval));
stats = regstats(primeColorLongB(:,3),[primeColorLongP(:,3) calibColorP(:,3)],'linear');
display(sprintf('           Controlling for matching precision, the significance of the effect is p=%.4f',stats.tstat.pval(2)));

load(fullfile(dirs.dataDir,dataFile{2}))
[rho, pval] = corr(primeColorLongB(:,3),primeColorLongP(:,3));
display(sprintf('DATASET 2: The correlation between Color precision and Color bias across subjects is r=%.2f (p=%.4f)',rho,pval));
stats = regstats(primeColorLongB(:,3),[primeColorLongP(:,3) calibColorP(:,3)],'linear');
display(sprintf('           Controlling for matching precision, the significance of the effect is p=%.4f',stats.tstat.pval(2)));

load(fullfile(dirs.dataDir,dataFile{3}))
[rho, pval] = corr(adaptColorP(:,7),adaptColorB(:,7));
display(sprintf('DATASET COLOR ONLY: The correlation between Color precision and Color bias across subjects is r=%.2f (p=%.4f)',rho,pval));
stats = regstats(adaptColorB(:,7),[adaptColorP(:,7) calibColorP(:,3)],'linear');
display(sprintf('           Controlling for matching precision, the significance of the effect is p=%.4f',stats.tstat.pval(2)));

load(fullfile(dirs.dataDir,dataFile{4}))
[rho, pval] = corr(adaptColorP(:,7),adaptColorB(:,7));
display(sprintf('DATASET COLOR ONLY - HIGH SATURATION: The correlation between Color precision and Color bias across subjects is r=%.2f (p=%.4f)',rho,pval));
stats = regstats(adaptColorB(:,7),[adaptColorP(:,7) calibColorP(:,3)],'linear');
display(sprintf('           Controlling for matching precision, the significance of the effect is p=%.4f',stats.tstat.pval(2)));