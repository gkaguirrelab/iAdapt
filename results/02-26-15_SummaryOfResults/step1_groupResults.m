%% DEFINE PARAMETERS
dirs.dataDir = '~/Dropbox/Marcelo/UPenn/Documents/Projects/mTurkPsych/Data';
dirs.codeDir = '~/Dropbox/Marcelo/UPenn/Documents/Projects/mTurkPsych/Code';
dataFile = 'colorsAndFaces_101subj_B.mat';


%% ADD TOOLBOXES TO PATH
display(sprintf('Loading neccessary Toolboxes...'));
addpath(genpath(fullfile(dirs.codeDir,'jv10')));
display(sprintf('... Done!\n'));

%% DEFINE NECESSARY VARIABLES

%% LOAD DATA
load(fullfile(dirs.dataDir,dataFile))

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

%% PLOT GROUP RESULTS
binPosition = -180:5:180;
figure(1);

subplot(3,2,1);
    data = rad2deg(wrap(deg2rad(groupCalibColorError(:))));
    data = data(~isnan(data));
    [N, X] = hist(data, binPosition);
    bar(X, N./sum(N), 1);
    set(gca, 'ylim',[0 .25]);
    set(gca,'ytick',0:0.05:0.25);
    set(gca,'xlim',[-180 180]);
    set(gca,'xtick',-180:45:180);
    set(gca,'xticklabel',-180:45:180);
    set(gca,'FontSize',14);
    ylabel('Probability');
    xlabel(['Error (' sprintf('%c', char(176)) ')'])
    title('Matching task - COLOR','FontSize',25);
    dataMean = nanmean(data);
    CI95indx = [floor(length(data)*0.025) ceil(length(data)*0.975)];
    data_sorted = sort(data); data95CI = data_sorted(CI95indx);
    line([dataMean dataMean],get(gca,'YLim'),'Color',[0 0 0]);
    line([data95CI(1) data95CI(1)],get(gca,'YLim'),'Color',[1 0 0]);
    line([data95CI(2) data95CI(2)],get(gca,'YLim'),'Color',[1 0 0]);
subplot(3,2,2);
    data = rad2deg(wrap(deg2rad(groupCalibFaceError(:))));
    data = data(~isnan(data));
    [N, X] = hist(data, binPosition);
    bar(X, N./sum(N), 1);
    set(gca, 'ylim',[0 .25]);
    set(gca,'ytick',0:0.05:0.25);
    set(gca,'xlim',[-180 180]);
    set(gca,'xtick',-180:45:180);
    set(gca,'xticklabel',-180:45:180);
    set(gca,'FontSize',14);
    ylabel('Probability');
    xlabel(['Error (' sprintf('%c', char(176)) ')'])
    title('Matching task - FACE','FontSize',25);
    dataMean = nanmean(data);
    CI95indx = [floor(length(data)*0.025) ceil(length(data)*0.975)];
    data_sorted = sort(data); data95CI = data_sorted(CI95indx);
    line([dataMean dataMean],get(gca,'YLim'),'Color',[0 0 0]);
    line([data95CI(1) data95CI(1)],get(gca,'YLim'),'Color',[1 0 0]);
    line([data95CI(2) data95CI(2)],get(gca,'YLim'),'Color',[1 0 0]);
subplot(3,2,3);
    data = rad2deg(wrap(deg2rad(groupWMColorError(:))));
    data = data(~isnan(data));
    [N, X] = hist(data, binPosition);
    bar(X, N./sum(N), 1);
    set(gca, 'ylim',[0 .25]);
    set(gca,'ytick',0:0.05:0.25);
    set(gca,'xlim',[-180 180]);
    set(gca,'xtick',-180:45:180);
    set(gca,'xticklabel',-180:45:180);
    set(gca,'FontSize',14);
    ylabel('Probability');
    xlabel(['Error (' sprintf('%c', char(176)) ')'])
    title('Delayed match task - COLOR','FontSize',25);
    dataMean = nanmean(data);
    CI95indx = [floor(length(data)*0.025) ceil(length(data)*0.975)];
    data_sorted = sort(data); data95CI = data_sorted(CI95indx);
    line([dataMean dataMean],get(gca,'YLim'),'Color',[0 0 0]);
    line([data95CI(1) data95CI(1)],get(gca,'YLim'),'Color',[1 0 0]);
    line([data95CI(2) data95CI(2)],get(gca,'YLim'),'Color',[1 0 0]);
subplot(3,2,4);
    data = rad2deg(wrap(deg2rad(groupWMFaceError(:))));
    data = data(~isnan(data));
    [N, X] = hist(data, binPosition);
    bar(X, N./sum(N), 1);
    set(gca, 'ylim',[0 .25]);
    set(gca,'ytick',0:0.05:0.25);
    set(gca,'xlim',[-180 180]);
    set(gca,'xtick',-180:45:180);
    set(gca,'xticklabel',-180:45:180);
    set(gca,'FontSize',14);
    ylabel('Probability');
    xlabel(['Error (' sprintf('%c', char(176)) ')'])
    title('Delayed match task - FACE','FontSize',25);
    dataMean = nanmean(data);
    CI95indx = [floor(length(data)*0.025) ceil(length(data)*0.975)];
    data_sorted = sort(data); data95CI = data_sorted(CI95indx);
    line([dataMean dataMean],get(gca,'YLim'),'Color',[0 0 0]);
    line([data95CI(1) data95CI(1)],get(gca,'YLim'),'Color',[1 0 0]);
    line([data95CI(2) data95CI(2)],get(gca,'YLim'),'Color',[1 0 0]);
subplot(3,2,5);
    data = rad2deg(wrap(deg2rad(groupAdaptColorError(:))));
    data(groupAdaptColorAdaptor(:)<0) = -data(groupAdaptColorAdaptor(:)<0);
    data = data(~isnan(data));
    [N, X] = hist(data, binPosition);
    bar(X, N./sum(N), 1);
    set(gca, 'ylim',[0 .25]);
    set(gca,'ytick',0:0.05:0.25);
    set(gca,'xlim',[-180 180]);
    set(gca,'xtick',-180:45:180);
    set(gca,'xticklabel',-180:45:180);
    set(gca,'FontSize',14);
    ylabel('Probability');
    xlabel(['Error (' sprintf('%c', char(176)) ')'])
    title('Adaptation task - COLOR','FontSize',25);
    dataMean = nanmean(data);
    CI95indx = [floor(length(data)*0.025) ceil(length(data)*0.975)];
    data_sorted = sort(data); data95CI = data_sorted(CI95indx);
    line([dataMean dataMean],get(gca,'YLim'),'Color',[0 0 0]);
    line([data95CI(1) data95CI(1)],get(gca,'YLim'),'Color',[1 0 0]);
    line([data95CI(2) data95CI(2)],get(gca,'YLim'),'Color',[1 0 0]);
subplot(3,2,6);
    data = rad2deg(wrap(deg2rad(groupAdaptFaceError(:))));
    data(groupAdaptFaceAdaptor(:)<0) = -data(groupAdaptFaceAdaptor(:)<0);
    data = data(~isnan(data));
    [N, X] = hist(data, binPosition);
    bar(X, N./sum(N), 1);
    set(gca, 'ylim',[0 .25]);
    set(gca,'ytick',0:0.05:0.25);
    set(gca,'xlim',[-180 180]);
    set(gca,'xtick',-180:45:180);
    set(gca,'xticklabel',-180:45:180);
    set(gca,'FontSize',14);
    ylabel('Probability');
    xlabel(['Error (' sprintf('%c', char(176)) ')'])
    title('Adaptation task - FACE','FontSize',25);
    dataMean = nanmean(data);
    CI95indx = [floor(length(data)*0.025) ceil(length(data)*0.975)];
    data_sorted = sort(data); data95CI = data_sorted(CI95indx);
    line([dataMean dataMean],get(gca,'YLim'),'Color',[0 0 0]);
    line([data95CI(1) data95CI(1)],get(gca,'YLim'),'Color',[1 0 0]);
    line([data95CI(2) data95CI(2)],get(gca,'YLim'),'Color',[1 0 0]);
    