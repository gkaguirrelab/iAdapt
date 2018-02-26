%% DEFINE PARAMETERS
dataFileAB = {'A_colorsAndFaces_101subj.mat', 'B_colorsAndFaces_101subj.mat'};
dataFileCDE = {'C_colorsOnly_99subj_lowSaturation.mat', 'D_facesOnly_94subj.mat', 'E_colorsOnly_98subj_highSaturation.mat'};
dirs.dataDir = '~/Dropbox/Marcelo/UPenn/Documents/Projects/mTurkPsych/Data';
dirs.codeDir = '~/Dropbox/Marcelo/UPenn/Documents/Projects/mTurkPsych/Code';


%% ADD TOOLBOXES TO PATH
display(sprintf('Loading neccessary Toolboxes...'));
addpath(genpath(fullfile(dirs.codeDir)));
display(sprintf('... Done!\n'));


%% DEFINE NECESSARY VARIABLES
numDatasetsAB = length(dataFileAB);
numDatasetsCDE = length(dataFileCDE);

for d=1:numDatasetsAB
    %% LOAD DATA
    load(fullfile(dirs.dataDir,dataFileAB{d}))
    
    %% CALCULATE CORRELATION
    display(sprintf('--- DATASET %d ---',d));
    [~, table] = anova_rm(primeColorLongB(:,1:2),'off');
    display(sprintf('The effect of session on Color bias was F(%d,%d) = %.2f (p=%.4f). The effect of subject was F(%d,%d) = %.2f (p=%.4f)',table{2,3},table{4,3},table{2,5},table{2,6},table{3,3},table{4,3},table{3,5},table{3,6}));
    
    [~, table] = anova_rm(primeFaceLongB(:,1:2),'off');
    display(sprintf('The effect of session on Face bias was F(%d,%d) = %.2f (p=%.4f). The effect of subject was F(%d,%d) = %.2f (p=%.4f)',table{2,3},table{4,3},table{2,5},table{2,6},table{3,3},table{4,3},table{3,5},table{3,6}));
end

%% LOAD DATA
load(fullfile(dirs.dataDir,dataFileCDE{1}))

%% CALCULATE CORRELATION
display(sprintf('--- DATASET: COLORS ONLY ---'));
[~, table] = anova_rm(adaptColorB(:,1:6),'off');
display(sprintf('The effect of session on Color bias was F(%d,%d) = %.2f (p=%.4f). The effect of subject was F(%d,%d) = %.2f (p=%.4f)',table{2,3},table{4,3},table{2,5},table{2,6},table{3,3},table{4,3},table{3,5},table{3,6}));


%% LOAD DATA
load(fullfile(dirs.dataDir,dataFileCDE{2}))

%% CALCULATE CORRELATION
display(sprintf('--- DATASET: FACES ONLY ---'));
[~, table] = anova_rm(adaptFaceB(:,1:6),'off');
display(sprintf('The effect of session on Face bias was F(%d,%d) = %.2f (p=%.4f). The effect of subject was F(%d,%d) = %.2f (p=%.4f)',table{2,3},table{4,3},table{2,5},table{2,6},table{3,3},table{4,3},table{3,5},table{3,6}));


%% LOAD DATA
load(fullfile(dirs.dataDir,dataFileCDE{3}))

%% CALCULATE CORRELATION
display(sprintf('--- DATASET: COLORS ONLY - HIGH SATURATION ---'));
[~, table] = anova_rm(adaptColorB(:,1:6),'off');
display(sprintf('The effect of session on Color bias was F(%d,%d) = %.2f (p=%.4f). The effect of subject was F(%d,%d) = %.2f (p=%.4f)',table{2,3},table{4,3},table{2,5},table{2,6},table{3,3},table{4,3},table{3,5},table{3,6}));
