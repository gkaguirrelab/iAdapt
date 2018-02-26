% within subject, color precision and color bias are anti-correlated
%% DEFINE PARAMETERS
dataFile = {'C_colorsOnly_99subj_lowSaturation.mat', 'D_facesOnly_94subj.mat', 'E_colorsOnly_98subj_highSaturation.mat'};
dirs.dataDir = '~/Dropbox/Marcelo/UPenn/Documents/Projects/mTurkPsych/Data';
dirs.codeDir = '~/Dropbox/Marcelo/UPenn/Documents/Projects/mTurkPsych/Code';


%% ADD TOOLBOXES TO PATH
display(sprintf('Loading neccessary Toolboxes...'));
addpath(genpath(fullfile(dirs.codeDir,'jv10')));
display(sprintf('... Done!\n'));


%% DEFINE NECESSARY VARIABLES
numDatasets = length(dataFile);


%% CALCULATE CORRELATION
load(fullfile(dirs.dataDir,dataFile{1}));
indivCorrs = nan(length(subjList),1);
for s=1:length(subjList)
    indivCorrs(s) = corr(adaptColorP(s,1:6)',adaptColorB(s,1:6)');
end
[~,pval,~,stats] = ttest(indivCorrs);
display(sprintf('DATASET COLORS ONLY: The mean correlation between Color precision and Color bias within subject is r=%.2f, t(%d)=%.2f (p=%.4f)',mean(indivCorrs),stats.df,stats.tstat,pval));

load(fullfile(dirs.dataDir,dataFile{2}));
indivCorrs = nan(length(subjList),1);
for s=1:length(subjList)
    indivCorrs(s) = corr(adaptFaceP(s,1:6)',adaptFaceB(s,1:6)');
end
[~,pval,~,stats] = ttest(indivCorrs);
display(sprintf('DATASET FACES ONLY: The mean correlation between Face precision and Face bias within subject is r=%.2f, t(%d)=%.2f (p=%.4f)',mean(indivCorrs),stats.df,stats.tstat,pval));

load(fullfile(dirs.dataDir,dataFile{3}));
indivCorrs = nan(length(subjList),1);
for s=1:length(subjList)
    indivCorrs(s) = corr(adaptColorP(s,1:6)',adaptColorB(s,1:6)');
end
[~,pval,~,stats] = ttest(indivCorrs);
display(sprintf('DATASET COLORS ONLY - HIGH SATURATION: The mean correlation between Color precision and Color bias within subject is r=%.2f, t(%d)=%.2f (p=%.4f)',mean(indivCorrs),stats.df,stats.tstat,pval));
