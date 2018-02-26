% Across subject, color precision and color bias are anti-correlated
%% DEFINE PARAMETERS
dataFile = {'colorsAndFaces_101subj_A.mat', 'colorsAndFaces_101subj_B.mat', 'facesOnly_94subj_D.mat'};
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
[rho, pval] = corr(primeFaceLongB(:,3),primeFaceLongP(:,3));
display(sprintf('DATASET 1: The correlation between Face precision and Face bias across subjects is r=%.2f (p=%.4f)',rho,pval));
stats = regstats(primeFaceLongB(:,3),[primeFaceLongP(:,3) calibFaceP(:,3)],'linear');
display(sprintf('           Controlling for matching precision, the significance of the effect is p=%.4f',stats.tstat.pval(2)));

load(fullfile(dirs.dataDir,dataFile{2}))
[rho, pval] = corr(primeFaceLongB(:,3),primeFaceLongP(:,3));
display(sprintf('DATASET 2: The correlation between Face precision and Face bias across subjects is r=%.2f (p=%.4f)',rho,pval));
stats = regstats(primeFaceLongB(:,3),[primeFaceLongP(:,3) calibFaceP(:,3)],'linear');
display(sprintf('           Controlling for matching precision, the significance of the effect is p=%.4f',stats.tstat.pval(2)));

load(fullfile(dirs.dataDir,dataFile{3}))
[rho, pval] = corr(adaptFaceP(:,7),adaptFaceB(:,7));
display(sprintf('DATASET FACE ONLY: The correlation between Face precision and Face bias across subjects is r=%.2f (p=%.4f)',rho,pval));
stats = regstats(adaptFaceB(:,7),[adaptFaceP(:,7) calibFaceP(:,3)],'linear');
display(sprintf('           Controlling for matching precision, the significance of the effect is p=%.4f',stats.tstat.pval(2)));