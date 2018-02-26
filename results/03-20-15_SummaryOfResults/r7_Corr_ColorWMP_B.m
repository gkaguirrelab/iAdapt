% within subject, color precision and color bias are anti-correlated
%% DEFINE PARAMETERS
dataFile = 'colorsOnly_99subj_C.mat';
dirs.dataDir = '~/Dropbox/Marcelo/UPenn/Documents/Projects/mTurkPsych/Data';
dirs.codeDir = '~/Dropbox/Marcelo/UPenn/Documents/Projects/mTurkPsych/Code';


%% ADD TOOLBOXES TO PATH
display(sprintf('Loading neccessary Toolboxes...'));
addpath(genpath(fullfile(dirs.codeDir,'jv10')));
display(sprintf('... Done!\n'));



%% LOAD DATA
load(fullfile(dirs.dataDir,'colorsOnly_99subj_C.mat'))
load(fullfile(dirs.dataDir,'facesOnly_94subj_D.mat'))

%% RUN REGRESSION TAKING INTO ACCOUNT MATCHING PRECISION
stats = regstats(adaptColorB(:,7),[workingMemoryColorP(:,3) calibColorP(:,3)],'linear');
betaWMP = stats.beta(2);
pvalWMP = stats.tstat.pval(2);

display(sprintf('The relationship between working memory precision and bias for COLORS (controlling for the matching task) has beta=%.2f (p=%.4f)',betaWMP,pvalWMP));

stats = regstats(adaptFaceB(:,7),[workingMemoryFaceP(:,3) calibFaceP(:,3)],'linear');
betaWMP = stats.beta(2);
pvalWMP = stats.tstat.pval(2);

display(sprintf('The relationship between working memory precision and bias for FACES (controlling for the matching task) has beta=%.2f (p=%.4f)',betaWMP,pvalWMP));