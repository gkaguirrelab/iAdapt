%% DEFINE PARAMETERS
dirs.dataDir = '~/Dropbox/Marcelo/UPenn/Documents/Projects/mTurkPsych/Data';
dirs.codeDir = '~/Dropbox/Marcelo/UPenn/Documents/Projects/mTurkPsych/Code';
dataFile = 'colorsAndFaces_101subj_A.mat';


%% ADD TOOLBOXES TO PATH
display(sprintf('Loading neccessary Toolboxes...'));
addpath(genpath(fullfile(dirs.codeDir,'jv10')));
display(sprintf('... Done!\n'));

%% DEFINE NECESSARY VARIABLES

%% LOAD DATA
load(fullfile(dirs.dataDir,dataFile))

%%
figure(1);

subplot(2,2,1)
    scatter(calibColorP(:,3),primeColorLongB(:,3),'filled')
    set(gca, 'ylim',[-10 20]);
    set(gca,'ytick',-10:5:20);
    a=axis;a(1)=0;axis(a);
    set(gca,'xtick',0:15);
    set(gca,'xticklabel',0:15);
    set(gca,'FontSize',14);
    ylabel(['Response bias (' sprintf('%c', char(176)) ')'])
    xlabel(['Precision (' sprintf('%c', char(176)) '^{-1})'])
    title('Matching task - COLOR','FontSize',25);
    lsline

subplot(2,2,2)
    scatter(calibFaceP(:,3),primeFaceLongB(:,3),'filled')
    set(gca, 'ylim',[-10 20]);
    set(gca,'ytick',-10:5:20);
    set(gca,'xlim',[0 7]);
    set(gca,'xtick',0:1:7);
    set(gca,'xticklabel',0:1:7);
    set(gca,'FontSize',14);
    ylabel(['Response bias (' sprintf('%c', char(176)) ')'])
    xlabel(['Precision (' sprintf('%c', char(176)) '^{-1})'])
    title('Matching task - FACE','FontSize',25);
    lsline

subplot(2,2,3)
    scatter(workingMemoryColorP(:,3),primeColorLongB(:,3),'filled')
    set(gca, 'ylim',[-10 20]);
    set(gca,'ytick',-10:5:20);
    set(gca,'xlim',[0 7]);
    set(gca,'xtick',0:1:7);
    set(gca,'xticklabel',0:1:7);
    set(gca,'FontSize',14);
    ylabel(['Response bias (' sprintf('%c', char(176)) ')'])
    xlabel(['Precision (' sprintf('%c', char(176)) '^{-1})'])
    title('Delayed match task - COLOR','FontSize',25);
    lsline

subplot(2,2,4)
    scatter(workingMemoryFaceP(:,3),primeFaceLongB(:,3),'filled')
    set(gca, 'ylim',[-10 20]);
    set(gca,'ytick',-10:5:20);
    set(gca,'xlim',[0 7]);
    set(gca,'xtick',0:1:7);
    set(gca,'xticklabel',0:1:7);
    set(gca,'FontSize',14);
    ylabel(['Response bias (' sprintf('%c', char(176)) ')'])
    xlabel(['Precision (' sprintf('%c', char(176)) '^{-1})'])
    title('Delayed match task - FACE','FontSize',25);
    lsline




%% EXTRACT GROUP DATA
groupCalibColorError = nan(15,2,numSubj);
groupCalibFaceError = nan(15,2,numSubj);
groupWMColorError = nan(30,2,numSubj);
groupWMFaceError = nan(30,2,numSubj);
groupAdaptColorError = nan(30,2,numSubj);
groupAdaptFaceError = nan(30,2,numSubj);
groupAdaptColorAdaptor = nan(30,2,numSubj);
groupAdaptFaceAdaptor = nan(30,2,numSubj);
for s=1:numSubj
    thisSubj = subjIDs{s};
    try
        groupCalibColorError(:,1,s) = data.(thisSubj).calibColor.targetVal-data.(thisSubj).calibColor.responseVal;
        groupCalibColorError(:,2,s) = data.(thisSubj).calibColor2.targetVal-data.(thisSubj).calibColor2.responseVal;
        groupCalibFaceError(:,1,s) = data.(thisSubj).calibFace.targetVal-data.(thisSubj).calibFace.responseVal;
        groupCalibFaceError(:,2,s) = data.(thisSubj).calibFace2.targetVal-data.(thisSubj).calibFace2.responseVal;
    end
        
    try
        groupWMColorError(:,1,s) = data.(thisSubj).workingMemoryColor.targetVal-data.(thisSubj).workingMemoryColor.responseVal;
        groupWMColorError(:,2,s) = data.(thisSubj).workingMemoryColor2.targetVal-data.(thisSubj).workingMemoryColor2.responseVal;
        groupWMFaceError(:,1,s) = data.(thisSubj).workingMemoryFace.targetVal-data.(thisSubj).workingMemoryFace.responseVal;
        groupWMFaceError(:,2,s) = data.(thisSubj).workingMemoryFace2.targetVal-data.(thisSubj).workingMemoryFace2.responseVal;
    end
        
    try
        groupAdaptColorError(:,1,s) = data.(thisSubj).primeColorLong.targetVal-data.(thisSubj).primeColorLong.responseVal;
        groupAdaptColorError(:,2,s) = data.(thisSubj).primeColorLong2.targetVal-data.(thisSubj).primeColorLong2.responseVal;
        groupAdaptFaceError(:,1,s) = data.(thisSubj).primeFaceLong.targetVal-data.(thisSubj).primeFaceLong.responseVal;
        groupAdaptFaceError(:,2,s) = data.(thisSubj).primeFaceLong2.targetVal-data.(thisSubj).primeFaceLong2.responseVal;
    end
        
    try
        groupAdaptColorAdaptor(:,1,s) = data.(thisSubj).primeColorLong.adaptor;
        groupAdaptColorAdaptor(:,2,s) = data.(thisSubj).primeColorLong2.adaptor;
        groupAdaptFaceAdaptor(:,1,s) = data.(thisSubj).primeFaceLong.adaptor;
        groupAdaptFaceAdaptor(:,2,s) = data.(thisSubj).primeFaceLong2.adaptor;
    end
end





%{
colorP1=calibColorP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3);
colorP2=workingMemoryColorP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3);
colorP3=primeColorLongP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3);
faceP1=calibFaceP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3);
faceP2=workingMemoryFaceP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3);
faceP3=primeFaceLongP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3);
colorB=primeColorLongB(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3);
faceB=primeFaceLongB(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3);

meanP=nanmean([calibColorP(:,3),calibFaceP(:,3),workingMemoryColorP(:,3),workingMemoryFaceP(:,3),primeColorLongP(:,3),primeFaceLongP(:,3)],2);
meanB=nanmean([primeColorLongB(:,3),primeFaceLongB(:,3)],2);
[rho,pval]=corr(meanP,meanB)
[rho,pval]=corr(meanP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05)),meanB(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05)))

meanP1=nanmean([calibColorP(:,1),calibFaceP(:,1),workingMemoryColorP(:,1),workingMemoryFaceP(:,1),primeColorLongP(:,1),primeFaceLongP(:,1)],2);
meanP2=nanmean([calibColorP(:,2),calibFaceP(:,2),workingMemoryColorP(:,2),workingMemoryFaceP(:,2),primeColorLongP(:,2),primeFaceLongP(:,2)],2);
[rho,pval]=corr(meanP1(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05)),meanP2(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05)))


meanPc=nanmean([calibColorP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3),workingMemoryColorP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3),primeColorLongP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3)],2);
meanPf=nanmean([calibFaceP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3),workingMemoryFaceP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3),primeFaceLongP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3)],2);
meanBc=nanmean([primeColorLongB(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3)],2);
meanBf=nanmean([primeFaceLongB(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3)],2);
[rho,pval]=corr(mean([meanPc,meanPf],2),mean([meanBc,meanBf],2))
[rho,pval]=corr(meanBc,meanBf)
% Regressing out precision from bias
[~,~,resBc] = regress(meanBc,meanPc);
[~,~,resBf] = regress(meanBf,meanPf);
[rho,pval]=corr(resBc,resBf)




allLLfits = [calibColor_fitLL(:,3) calibFace_fitLL(:,3) workingMemoryColor_fitLL(:,3) workingMemoryFace_fitLL(:,3) primeColorLong_fitLL(:,3) primeFaceLong_fitLL(:,3)];
subjs2Include = and(incompleteSessions==0,all(allLLfits>-50,2));
%}
