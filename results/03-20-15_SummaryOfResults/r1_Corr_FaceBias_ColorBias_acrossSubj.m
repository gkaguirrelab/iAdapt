%% DEFINE PARAMETERS
dataFile = {'colorsAndFaces_101subj_A.mat', 'colorsAndFaces_101subj_B.mat'};
dirs.dataDir = '~/Dropbox/Marcelo/UPenn/Documents/Projects/mTurkPsych/Data';
dirs.codeDir = '~/Dropbox/Marcelo/UPenn/Documents/Projects/mTurkPsych/Code';


%% ADD TOOLBOXES TO PATH
display(sprintf('Loading neccessary Toolboxes...'));
addpath(genpath(fullfile(dirs.codeDir,'jv10')));
display(sprintf('... Done!\n'));


%% DEFINE NECESSARY VARIABLES
numDatasets = length(dataFile);

for d=1:numDatasets
    %% LOAD DATA
    load(fullfile(dirs.dataDir,dataFile{d}))
    
    %% CALCULATE CORRELATION
    [rho, pval] = corr(primeColorLongB(:,3),primeFaceLongB(:,3));
    
    display(sprintf('DATASET %d: The correlation between Color bias and Face bias is r=%.2f (p=%.4f)',d,rho,pval));
end