%% DEFINE PARAMETERS AND LOAD DATA
load('../../Data/C_colorsOnly_99subj_lowSaturation.mat')
%load('../../Data/E_colorsOnly_98subj_highSaturation.mat')
addpath(genpath('../../Code/jv10'))

%% ANALYZE DATA

% Define tertiles
allP = adaptColorP(:,1:6);
tertiles = quantile(allP(:),[0 1/3 2/3 1]);
tertile1 = and(allP>=tertiles(1) , allP<=tertiles(2));
tertile2 = and(allP>=tertiles(2) , allP<=tertiles(3));
tertile3 = and(allP>=tertiles(3) , allP<=tertiles(4));

% Collect the trial data
numSubj = size(allP,1);
errorTertile1 = nan(0,0);
errorTertile2 = nan(0,0);
errorTertile3 = nan(0,0);
for s=1:numSubj
    try
        thisSubj = subjList{s};
        for i=1:6
            thisBlock = ['adaptColor' num2str(i)];
            targets = wrap(deg2rad(data.(thisSubj).(thisBlock).targetVal));
            responses = wrap(deg2rad(data.(thisSubj).(thisBlock).responseVal));
            adaptor = data.(thisSubj).(thisBlock).adaptor;
            error_raw = wrap(responses-targets);
            error_adjusted = nan(size(error_raw));
            error_adjusted(adaptor<0) = error_raw(adaptor<0);
            error_adjusted(adaptor>0) = -error_raw(adaptor>0);
            if tertile1(s,i)==1
                errorTertile1 = [errorTertile1;wrap(error_adjusted)];
            elseif tertile2(s,i)==1
                errorTertile2 = [errorTertile2;wrap(error_adjusted)];
            elseif tertile3(s,i)==1
                errorTertile3 = [errorTertile3;wrap(error_adjusted)];
            end
        end
    end
end
errorTertile1 = round(rad2deg(errorTertile1));
errorTertile2 = round(rad2deg(errorTertile2));
errorTertile3 = round(rad2deg(errorTertile3));

% Plot both histograms in the same figure
[n1, xout1] = hist(errorTertile1,-180:5:180);
[n2, xout2] = hist(errorTertile2,-180:5:180);
[n3, xout3] = hist(errorTertile3,-180:5:180);
figure(1);
clf;
hold on;
bar(xout1,n1/size(errorTertile1,1),'r');
bar(xout2,n2/size(errorTertile2,1),'g');
bar(xout3,n3/size(errorTertile3,1),'b');
line([nanmean(errorTertile1) nanmean(errorTertile1)],ylim,'Color',[0.5 0 0],'LineWidth',5);
line([nanmean(errorTertile2) nanmean(errorTertile2)],ylim,'Color',[0 0.5 0],'LineWidth',5);
line([nanmean(errorTertile3) nanmean(errorTertile3)],ylim,'Color',[0 0 0.5],'LineWidth',5);
xlim([-90 90]);
grid on;
ylabel('Probability of occurence','FontSize',18);
xlabel('Response error (degrees)','FontSize',18);

% Calculate the percentage of points on each side of the mean
skew = nan(3,2);
skew(1,1) = sum(errorTertile1<nanmean(errorTertile1))/length(errorTertile1);
skew(1,2) = sum(errorTertile1>nanmean(errorTertile1))/length(errorTertile1);
skew(2,1) = sum(errorTertile2<nanmean(errorTertile2))/length(errorTertile2);
skew(2,2) = sum(errorTertile2>nanmean(errorTertile2))/length(errorTertile2);
skew(3,1) = sum(errorTertile3<nanmean(errorTertile3))/length(errorTertile3);
skew(3,2) = sum(errorTertile3>nanmean(errorTertile3))/length(errorTertile3);
% Display results of asymetry analysis
display(sprintf('In the lowest precision tertile, %.2f%%/%.2f%% of the errors are below/above the mean.',100*skew(1,1),100*skew(1,2)));
display(sprintf('In the middle precision tertile, %.2f%%/%.2f%% of the errors are below/above the mean.',100*skew(2,1),100*skew(2,2)));
display(sprintf('In the highest precision tertile, %.2f%%/%.2f%% of the errors are below/above the mean.',100*skew(3,1),100*skew(3,2)));

