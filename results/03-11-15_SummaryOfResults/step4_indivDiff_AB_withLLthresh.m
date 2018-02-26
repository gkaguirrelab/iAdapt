%% DEFINE PARAMETERS
dataFile = 'colorsAndFaces_101subj_A.mat';
dirs.dataDir = '~/Dropbox/Marcelo/UPenn/Documents/Projects/mTurkPsych/Data';
dirs.codeDir = '~/Dropbox/Marcelo/UPenn/Documents/Projects/mTurkPsych/Code';
LLthresh = -60;

%% ADD TOOLBOXES TO PATH
display(sprintf('Loading neccessary Toolboxes...'));
addpath(genpath(fullfile(dirs.codeDir,'jv10')));
display(sprintf('... Done!\n'));

%% DEFINE NECESSARY VARIABLES

%% LOAD DATA
load(fullfile(dirs.dataDir,dataFile))

%% REMOVE LOW-LL FITS
goodFits_Color = (calibColor_fitLL(:,3)>(LLthresh/2)) & (workingMemoryColor_fitLL(:,3)>(LLthresh)) & (primeColorLong_fitLL(:,3)>(LLthresh));
goodFits_Face = (calibFace_fitLL(:,3)>(LLthresh/2)) & (workingMemoryFace_fitLL(:,3)>(LLthresh)) & (primeFaceLong_fitLL(:,3)>(LLthresh));

%% PLOT STUFF
f1=figure(1);
subplot(3,2,1)
    scatter(calibColorP(goodFits_Color,3),primeColorLongB(goodFits_Color,3),'filled')
    [Pearson_r,Pearson_pval] = corr(calibColorP(goodFits_Color,3),primeColorLongB(goodFits_Color,3),'type','Pearson');
    [Spearman_rho,Spearman_pval] = corr(calibColorP(goodFits_Color,3),primeColorLongB(goodFits_Color,3),'type','Spearman');
    [Kendall_tau,Kendall_pval] = corr(calibColorP(goodFits_Color,3),primeColorLongB(goodFits_Color,3),'type','Kendall');
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
    annotation('textbox',...
    [0.28,0.87,0.190,0.045],...
    'String',{...
    ['Pearson r: ' num2str(Pearson_r) ' (p = ' num2str(Pearson_pval) ')'],...
    ['Spearman rho: ' num2str(Spearman_rho) ' (p = ' num2str(Spearman_pval) ')'],...
    ['Kendall tau: ' num2str(Kendall_tau) ' (p = ' num2str(Kendall_pval) ')']},...
    'FontSize',12,...
    'FontName','Arial',...
    'LineWidth',2);
subplot(3,2,2)
    scatter(calibFaceP(goodFits_Face,3),primeFaceLongB(goodFits_Face,3),'filled')
    [Pearson_r,Pearson_pval] = corr(calibFaceP(goodFits_Face,3),primeFaceLongB(goodFits_Face,3),'type','Pearson');
    [Spearman_rho,Spearman_pval] = corr(calibFaceP(goodFits_Face,3),primeFaceLongB(goodFits_Face,3),'type','Spearman');
    [Kendall_tau,Kendall_pval] = corr(calibFaceP(goodFits_Face,3),primeFaceLongB(goodFits_Face,3),'type','Kendall');
    set(gca, 'ylim',[-10 20]);
    set(gca,'ytick',-10:5:20);
    a=axis;a(1)=0;axis(a);
    set(gca,'xtick',0:15);
    set(gca,'xticklabel',0:15);
    set(gca,'FontSize',14);
    ylabel(['Response bias (' sprintf('%c', char(176)) ')'])
    xlabel(['Precision (' sprintf('%c', char(176)) '^{-1})'])
    title('Matching task - FACE','FontSize',25);
    lsline
    annotation('textbox',...
    [0.72,0.87,0.190,0.045],...
    'String',{...
    ['Pearson r: ' num2str(Pearson_r) ' (p = ' num2str(Pearson_pval) ')'],...
    ['Spearman rho: ' num2str(Spearman_rho) ' (p = ' num2str(Spearman_pval) ')'],...
    ['Kendall tau: ' num2str(Kendall_tau) ' (p = ' num2str(Kendall_pval) ')']},...
    'FontSize',12,...
    'FontName','Arial',...
    'LineWidth',2);
subplot(3,2,3)
    scatter(workingMemoryColorP(goodFits_Color,3),primeColorLongB(goodFits_Color,3),'filled')
    [Pearson_r,Pearson_pval] = corr(workingMemoryColorP(goodFits_Color,3),primeColorLongB(goodFits_Color,3),'type','Pearson');
    [Spearman_rho,Spearman_pval] = corr(workingMemoryColorP(goodFits_Color,3),primeColorLongB(goodFits_Color,3),'type','Spearman');
    [Kendall_tau,Kendall_pval] = corr(workingMemoryColorP(goodFits_Color,3),primeColorLongB(goodFits_Color,3),'type','Kendall');
    set(gca, 'ylim',[-10 20]);
    set(gca,'ytick',-10:5:20);
    a=axis;a(1)=0;axis(a);
    set(gca,'xtick',0:15);
    set(gca,'xticklabel',0:15);
    set(gca,'FontSize',14);
    ylabel(['Response bias (' sprintf('%c', char(176)) ')'])
    xlabel(['Precision (' sprintf('%c', char(176)) '^{-1})'])
    title('Delayed match task - COLOR','FontSize',25);
    lsline
    annotation('textbox',...
    [0.28,0.57,0.190,0.045],...
    'String',{...
    ['Pearson r: ' num2str(Pearson_r) ' (p = ' num2str(Pearson_pval) ')'],...
    ['Spearman rho: ' num2str(Spearman_rho) ' (p = ' num2str(Spearman_pval) ')'],...
    ['Kendall tau: ' num2str(Kendall_tau) ' (p = ' num2str(Kendall_pval) ')']},...
    'FontSize',12,...
    'FontName','Arial',...
    'LineWidth',2);
subplot(3,2,4)
    scatter(workingMemoryFaceP(goodFits_Face,3),primeFaceLongB(goodFits_Face,3),'filled')
    [Pearson_r,Pearson_pval] = corr(workingMemoryFaceP(~isnan(workingMemoryFaceP(goodFits_Face,3)),3),primeFaceLongB(~isnan(workingMemoryFaceP(goodFits_Face,3)),3),'type','Pearson');
    [Spearman_rho,Spearman_pval] = corr(workingMemoryFaceP(~isnan(workingMemoryFaceP(goodFits_Face,3)),3),primeFaceLongB(~isnan(workingMemoryFaceP(goodFits_Face,3)),3),'type','Spearman');
    [Kendall_tau,Kendall_pval] = corr(workingMemoryFaceP(~isnan(workingMemoryFaceP(goodFits_Face,3)),3),primeFaceLongB(~isnan(workingMemoryFaceP(goodFits_Face,3)),3),'type','Kendall');
    [Pearson_r,Pearson_pval] = corr(workingMemoryFaceP(goodFits_Face,3),primeFaceLongB(goodFits_Face,3),'type','Pearson');
    [Spearman_rho,Spearman_pval] = corr(workingMemoryFaceP(goodFits_Face,3),primeFaceLongB(goodFits_Face,3),'type','Spearman');
    [Kendall_tau,Kendall_pval] = corr(workingMemoryFaceP(goodFits_Face,3),primeFaceLongB(goodFits_Face,3),'type','Kendall');
    set(gca, 'ylim',[-10 20]);
    set(gca,'ytick',-10:5:20);
    a=axis;a(1)=0;axis(a);
    set(gca,'xtick',0:15);
    set(gca,'xticklabel',0:15);
    set(gca,'FontSize',14);
    ylabel(['Response bias (' sprintf('%c', char(176)) ')'])
    xlabel(['Precision (' sprintf('%c', char(176)) '^{-1})'])
    title('Delayed match task - FACE','FontSize',25);
    lsline
    annotation('textbox',...
    [0.72,0.57,0.190,0.045],...
    'String',{...
    ['Pearson r: ' num2str(Pearson_r) ' (p = ' num2str(Pearson_pval) ')'],...
    ['Spearman rho: ' num2str(Spearman_rho) ' (p = ' num2str(Spearman_pval) ')'],...
    ['Kendall tau: ' num2str(Kendall_tau) ' (p = ' num2str(Kendall_pval) ')']},...
    'FontSize',12,...
    'FontName','Arial',...
    'LineWidth',2);
subplot(3,2,5)
    scatter(primeColorLongP(goodFits_Color,3),primeColorLongB(goodFits_Color,3),'filled')
    [Pearson_r,Pearson_pval] = corr(primeColorLongP(goodFits_Color,3),primeColorLongB(goodFits_Color,3),'type','Pearson');
    [Spearman_rho,Spearman_pval] = corr(primeColorLongP(goodFits_Color,3),primeColorLongB(goodFits_Color,3),'type','Spearman');
    [Kendall_tau,Kendall_pval] = corr(primeColorLongP(goodFits_Color,3),primeColorLongB(goodFits_Color,3),'type','Kendall');
    set(gca, 'ylim',[-10 20]);
    set(gca,'ytick',-10:5:20);
    a=axis;a(1)=0;axis(a);
    set(gca,'xtick',0:15);
    set(gca,'xticklabel',0:15);
    set(gca,'FontSize',14);
    ylabel(['Response bias (' sprintf('%c', char(176)) ')'])
    xlabel(['Precision (' sprintf('%c', char(176)) '^{-1})'])
    title('Adaptation task - COLOR','FontSize',25);
    lsline
    annotation('textbox',...
    [0.28,0.27,0.190,0.045],...
    'String',{...
    ['Pearson r: ' num2str(Pearson_r) ' (p = ' num2str(Pearson_pval) ')'],...
    ['Spearman rho: ' num2str(Spearman_rho) ' (p = ' num2str(Spearman_pval) ')'],...
    ['Kendall tau: ' num2str(Kendall_tau) ' (p = ' num2str(Kendall_pval) ')']},...
    'FontSize',12,...
    'FontName','Arial',...
    'LineWidth',2);
subplot(3,2,6)
    scatter(primeFaceLongP(goodFits_Face,3),primeFaceLongB(goodFits_Face,3),'filled')
    [Pearson_r,Pearson_pval] = corr(primeFaceLongP(goodFits_Face,3),primeFaceLongB(goodFits_Face,3),'type','Pearson');
    [Spearman_rho,Spearman_pval] = corr(primeFaceLongP(goodFits_Face,3),primeFaceLongB(goodFits_Face,3),'type','Spearman');
    [Kendall_tau,Kendall_pval] = corr(primeFaceLongP(goodFits_Face,3),primeFaceLongB(goodFits_Face,3),'type','Kendall');
    set(gca, 'ylim',[-10 20]);
    set(gca,'ytick',-10:5:20);
    a=axis;a(1)=0;axis(a);
    set(gca,'xtick',0:15);
    set(gca,'xticklabel',0:15);
    set(gca,'FontSize',14);
    ylabel(['Response bias (' sprintf('%c', char(176)) ')'])
    xlabel(['Precision (' sprintf('%c', char(176)) '^{-1})'])
    title('Adaptation task - FACE','FontSize',25);
    lsline
    annotation('textbox',...
    [0.72,0.27,0.190,0.045],...
    'String',{...
    ['Pearson r: ' num2str(Pearson_r) ' (p = ' num2str(Pearson_pval) ')'],...
    ['Spearman rho: ' num2str(Spearman_rho) ' (p = ' num2str(Spearman_pval) ')'],...
    ['Kendall tau: ' num2str(Kendall_tau) ' (p = ' num2str(Kendall_pval) ')']},...
    'FontSize',12,...
    'FontName','Arial',...
    'LineWidth',2);
set(f1, 'Position', [1,80,1280,1266])


f2=figure(2);
averagePrecisionColor = nanmean([calibColorP(goodFits_Color,3),workingMemoryColorP(goodFits_Color,3),primeColorLongP(goodFits_Color,3)],2);
averagePrecisionFace = nanmean([calibFaceP(goodFits_Face,3),workingMemoryFaceP(goodFits_Face,3),primeFaceLongP(goodFits_Face,3)],2);
subplot(3,2,1)
    scatter(averagePrecisionColor,primeColorLongB(goodFits_Color,3),'filled');
    [Pearson_r,Pearson_pval] = corr(averagePrecisionColor,primeColorLongB(goodFits_Color,3),'type','Pearson');
    [Spearman_rho,Spearman_pval] = corr(averagePrecisionColor,primeColorLongB(goodFits_Color,3),'type','Spearman');
    [Kendall_tau,Kendall_pval] = corr(averagePrecisionColor,primeColorLongB(goodFits_Color,3),'type','Kendall');
    set(gca, 'ylim',[-10 20]);
    set(gca,'ytick',-10:5:20);
    a=axis;a(1)=0;axis(a);
    set(gca,'xtick',0:15);
    set(gca,'xticklabel',0:15);
    set(gca,'FontSize',14);
    ylabel(['Response bias (' sprintf('%c', char(176)) ')'])
    xlabel(['Precision (' sprintf('%c', char(176)) '^{-1})'])
    title('Average precision - COLOR','FontSize',25);
    lsline
    annotation('textbox',...
    [0.28,0.87,0.190,0.045],...
    'String',{...
    ['Pearson r: ' num2str(Pearson_r) ' (p = ' num2str(Pearson_pval) ')'],...
    ['Spearman rho: ' num2str(Spearman_rho) ' (p = ' num2str(Spearman_pval) ')'],...
    ['Kendall tau: ' num2str(Kendall_tau) ' (p = ' num2str(Kendall_pval) ')']},...
    'FontSize',12,...
    'FontName','Arial',...
    'LineWidth',2);
subplot(3,2,2)
    scatter(averagePrecisionFace,primeFaceLongB(goodFits_Face,3),'filled');
    [Pearson_r,Pearson_pval] = corr(averagePrecisionFace,primeFaceLongB(goodFits_Face,3),'type','Pearson');
    [Spearman_rho,Spearman_pval] = corr(averagePrecisionFace,primeFaceLongB(goodFits_Face,3),'type','Spearman');
    [Kendall_tau,Kendall_pval] = corr(averagePrecisionFace,primeFaceLongB(goodFits_Face,3),'type','Kendall');
    set(gca, 'ylim',[-10 20]);
    set(gca,'ytick',-10:5:20);
    a=axis;a(1)=0;axis(a);
    set(gca,'xtick',0:15);
    set(gca,'xticklabel',0:15);
    set(gca,'FontSize',14);
    ylabel(['Response bias (' sprintf('%c', char(176)) ')'])
    xlabel(['Precision (' sprintf('%c', char(176)) '^{-1})'])
    title('Average precision - FACE','FontSize',25);
    lsline
    annotation('textbox',...
    [0.72,0.87,0.190,0.045],...
    'String',{...
    ['Pearson r: ' num2str(Pearson_r) ' (p = ' num2str(Pearson_pval) ')'],...
    ['Spearman rho: ' num2str(Spearman_rho) ' (p = ' num2str(Spearman_pval) ')'],...
    ['Kendall tau: ' num2str(Kendall_tau) ' (p = ' num2str(Kendall_pval) ')']},...
    'FontSize',12,...
    'FontName','Arial',...
    'LineWidth',2);
set(f2, 'Position', [1,80,1280,1266])


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
