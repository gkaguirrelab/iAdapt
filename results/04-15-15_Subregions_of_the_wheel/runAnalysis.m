subjFitsDataDir = './subjFits_Color_highContrast/';
dir_output = dir(subjFitsDataDir);

subjList = {};
calibColorP_all = [];
calibColor_fitLL_all = [];
workingMemoryColorP_all = [];
workingMemoryColor_fitLL_all = [];
adaptColorB_all = [];
adaptColorP_all = [];
adaptColor_fitLL_all = [];
for i=1:length(dir_output)
    if strcmp(dir_output(i).name,'.') || strcmp(dir_output(i).name,'..') || strcmp(dir_output(i).name,'.DS_Store')
    else
        thisFile = fullfile(subjFitsDataDir,dir_output(i).name);
        load(thisFile);
        subjList = [subjList; thisSubj];
        calibColorP_all = [calibColorP_all; calibColorP];
        calibColor_fitLL_all = [calibColor_fitLL_all; calibColor_fitLL];
        workingMemoryColorP_all = [workingMemoryColorP_all; workingMemoryColorP];
        workingMemoryColor_fitLL_all = [workingMemoryColor_fitLL_all; workingMemoryColor_fitLL];
        adaptColorB_all = [adaptColorB_all; adaptColorB];
        adaptColorP_all = [adaptColorP_all; adaptColorP];
        adaptColor_fitLL_all = [adaptColor_fitLL_all; adaptColor_fitLL];
    end
end

calibColorP = calibColorP_all;
calibColor_fitLL = calibColor_fitLL_all;
workingMemoryColorP = workingMemoryColorP_all;
workingMemoryColor_fitLL = workingMemoryColor_fitLL_all;
adaptColorB = adaptColorB_all;
adaptColorP = adaptColorP_all;
adaptColor_fitLL = adaptColor_fitLL_all;
save('combinedData.mat','subjList','calibColorP','calibColor_fitLL','workingMemoryColorP','workingMemoryColor_fitLL','adaptColorB','adaptColorP','adaptColor_fitLL');
clear
load('combinedData.mat')

% Make bar plot for precision and bias
figure(1);
subplot(1,2,1);
numSubRegions = size(adaptColorP,2)-1;
subregions = 0:(360/numSubRegions):360;
ticklabels = cell(1,6);
for i=1:6
    ticklabels{i} = [num2str(subregions(i)) '-' num2str(subregions(i+1))];
end
barwitherr(std(adaptColorP(:,1:6))/sqrt(size(adaptColorP,1)), nanmean(adaptColorP(:,1:6)));
set(gca, 'ylim',[2 5]);
set(gca,'ytick',2:0.5:5);
%set(gca,'xlim',[1 6]);
set(gca,'xtick',1:6);
set(gca,'xticklabel',ticklabels);
set(gca,'FontSize',16);
ylabel('Precision (deg)','FontSize',18);
xlabel('Subregion of color wheel (deg)','FontSize',18)

subplot(1,2,2);
barwitherr(std(adaptColorB(:,1:6))/sqrt(size(adaptColorB,1)), nanmean(adaptColorB(:,1:6)));
set(gca, 'ylim',[3 12]);
set(gca,'ytick',3:12);
%set(gca,'xlim',[1 6]);
set(gca,'xtick',1:6);
set(gca,'xticklabel',ticklabels);
set(gca,'FontSize',16);
ylabel('Bias (deg)','FontSize',18);
xlabel('Subregion of color wheel (deg)','FontSize',18)

% Calculate the correlation between precision and bias for each subregion
corrPB_rho = nan(1,7);
corrPB_p = nan(1,7);
for i=1:7
    [corrPB_rho(i), corrPB_p(i)] = corr(adaptColorP(:,i),adaptColorB(:,i),'type','Spearman');
end

% Calculate the correlation between precision and bias for each subject
numSubj = size(adaptColorP,1);
corrPB_withinSubj = nan(numSubj,1);
for s=1:numSubj
    corrPB_withinSubj(s) = corr(adaptColorP(s,1:6)',adaptColorB(s,1:6)');
end
nanmean(corrPB_withinSubj)
[~,p]=ttest(corrPB_withinSubj)

% Look at all subregions and all subjects
allP=adaptColorP(:,1:6);
allB=adaptColorB(:,1:6);
scatter(allP(:),allB(:),'filled')
[rho,pval]=corr(allP(:),allB(:),'type','Pearson');
[rho,pval]=corr(allP(:),allB(:),'type','Spearman')

% Plot scatter plots for each bin separately
figure(2);
for i=1:6
    subplot(2,3,i);
    scatter(1./adaptColorP(:,i),adaptColorB(:,i),'filled');
    lsline
end





%% PLOT SPLINE FIT
%{
splinePieces = 100;
xx=linspace(0,10,400);
pp1=splinefit(allP(:),allB(:),splinePieces);
y1 = ppval(pp1,xx);
plot(allP(:),allB(:),'.',xx,y1,'MarkerSize', 12)

splinePieces = 10;
xx=linspace(0,10,400);
pp1=splinefit([allP(:); zeros(1000,1)],[allB(:); zeros(1000,1)],splinePieces);
y1 = ppval(pp1,xx);
plot(allP(:),allB(:),'.',xx,y1,'MarkerSize', 12, 'LineWidth', 5)
xlim([0 10])

splinePieces = 100;
xx=linspace(0,10,400);
pp1=splinefit(allP(:),allB(:),splinePieces);
pp2=splinefit([allP(:); zeros(1000,1)],[allB(:); zeros(1000,1)],10);
y1 = ppval(pp1,xx);
y2 = ppval(pp2,xx);
plot(allP(:),allB(:),'.',xx,[y1;y2],'MarkerSize', 12)
%}