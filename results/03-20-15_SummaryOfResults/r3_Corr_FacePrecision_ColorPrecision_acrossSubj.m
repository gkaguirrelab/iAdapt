%% DEFINE PARAMETERS
dataFileAB = {'colorsAndFaces_101subj_A.mat', 'colorsAndFaces_101subj_B.mat'};
dataFileCD = {'colorsOnly_99subj_C.mat', 'facesOnly_94subj_D.mat'};
dirs.dataDir = '~/Dropbox/Marcelo/UPenn/Documents/Projects/mTurkPsych/Data';
dirs.codeDir = '~/Dropbox/Marcelo/UPenn/Documents/Projects/mTurkPsych/Code';


%% ADD TOOLBOXES TO PATH
display(sprintf('Loading neccessary Toolboxes...'));
addpath(genpath(fullfile(dirs.codeDir)));
display(sprintf('... Done!\n'));


%% DEFINE NECESSARY VARIABLES
numDatasetsAB = length(dataFileAB);
numDatasetsCD = length(dataFileCD);

for d=1:numDatasetsAB
    %% LOAD DATA
    load(fullfile(dirs.dataDir,dataFileAB{d}))
    
    %% CALCULATE CORRELATION
    display(sprintf('--- DATASET %d ---',d));
    [~, table] = anova_rm(primeColorLongP(:,1:2),'off');
    display(sprintf('The effect of session on Color precision was F(%d,%d) = %.2f (p=%.4f). The effect of subject was F(%d,%d) = %.2f (p=%.4f)',table{2,3},table{4,3},table{2,5},table{2,6},table{3,3},table{4,3},table{3,5},table{3,6}));
    
    [~, table] = anova_rm(primeFaceLongP(:,1:2),'off');
    display(sprintf('The effect of session on Face precision was F(%d,%d) = %.2f (p=%.4f). The effect of subject was F(%d,%d) = %.2f (p=%.4f)',table{2,3},table{4,3},table{2,5},table{2,6},table{3,3},table{4,3},table{3,5},table{3,6}));
end

%% LOAD DATA
load(fullfile(dirs.dataDir,dataFileCD{1}))

%% CALCULATE CORRELATION
display(sprintf('--- DATASET: COLORS ONLY ---'));
[~, table] = anova_rm(adaptColorP(:,1:6),'off');
display(sprintf('The effect of session on Color precision was F(%d,%d) = %.2f (p=%.4f). The effect of subject was F(%d,%d) = %.2f (p=%.4f)',table{2,3},table{4,3},table{2,5},table{2,6},table{3,3},table{4,3},table{3,5},table{3,6}));


%% LOAD DATA
load(fullfile(dirs.dataDir,dataFileCD{2}))

%% CALCULATE CORRELATION
display(sprintf('--- DATASET: FACES ONLY ---'));
[~, table] = anova_rm(adaptFaceP(:,1:6),'off');
display(sprintf('The effect of session on Face precision was F(%d,%d) = %.2f (p=%.4f). The effect of subject was F(%d,%d) = %.2f (p=%.4f)',table{2,3},table{4,3},table{2,5},table{2,6},table{3,3},table{4,3},table{3,5},table{3,6}));
