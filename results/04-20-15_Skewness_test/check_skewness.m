%load('../../Data/E_colorsOnly_98subj_highSaturation.mat')
load('../../Data/C_colorsOnly_99subj.mat')
addpath(genpath('../../Code/jv10'))

allP = adaptColorP(:,1:6);
lowP_thresh = 2.5;
highP_thresh = 5;

lowP = allP<lowP_thresh;
highP = allP>highP_thresh;

% Collect the trial data
numSubj = size(allP,1);
lowPdata = [];
highPdata = [];
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
            if lowP(s,i)==1
                lowPdata = [lowPdata;wrap(error_adjusted)];
            end
            if highP(s,i)==1
                highPdata = [highPdata;wrap(error_adjusted)];
            end
        end
    end
end

% Convert back to degrees (for interpretation)
lowPdata = rad2deg(lowPdata);
highPdata = rad2deg(highPdata);

% Plot both histograms in the same figure
[n1, xout1] = hist(lowPdata,-180:5:180);
bar(xout1,n1,'r'); grid; hold
[n2, xout2] = hist(highPdata,-180:5:180);
bar(xout2,n2,'g');

figure;
subplot(211);
hist(lowPdata,-180:5:180)
ylim([0 500]);
xlim([-100 100])
line([nanmean(lowPdata) nanmean(lowPdata)],[0 500]);
subplot(212);
hist(highPdata,-180:5:180)
ylim([0 500]);
xlim([-100 100])
line([nanmean(highPdata) nanmean(highPdata)],[0 500]);