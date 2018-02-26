%% PARAMETERS
dbFile = './080714.mat';
dateRange = {'August 5, 2014', 'August 8, 2014'};
targetDur = [100 200 400];
ISIDur = [50 100 200 400];

filterCalibrationBegin = true;
filterCalibrationEnd = true;
    precisionThreshold = 0.5;
    probGuessThreshold = 0.2;
filterPrime = true;
    probPrimeThreshold = 0.2;
    maxNumberOfTasksAboveThreshold = 3;


%% LOAD DATA
load(dbFile)
[filteredIDs, ~] = filterSubjectIDs(db, dateRange);
display(['Number of valid subjects: ' num2str(length(filteredIDs))]);


%% ANALYZE CALIBRATION DATA
[precisionColor1, biasColor1, probGuessColor1] = calibrationData(db.data.calibColor,filteredIDs);
[precisionColor2, biasColor2, probGuessColor2] = calibrationData(db.data.calibColor2,filteredIDs);
[precisionFace1, biasFace1, probGuessFace1] = calibrationData(db.data.calibFace,filteredIDs);
[precisionFace2, biasFace2, probGuessFace2] = calibrationData(db.data.calibFace2,filteredIDs);
% Plot results: Precision and P(guesses) distributions
%{
subplot(2,2,1);
hist(probGuessColor1); title('Color 1','FontSize',18); xlabel('Probability','FontSize',14);
subplot(2,2,2);
hist(probGuessColor2); title('Color 2','FontSize',18); xlabel('Probability','FontSize',14);
subplot(2,2,3);
hist(probGuessFace1); title('Face 1','FontSize',18); xlabel('Probability','FontSize',14);
subplot(2,2,4);
hist(probGuessFace2); title('Face 2','FontSize',18); xlabel('Probability','FontSize',14);
hist(mean([probGuessColor1,probGuessColor2,probGuessFace1,probGuessFace2],2)); title('Overall','FontSize',18); xlabel('Probability of guess','FontSize',14);
subplot(2,2,1);
hist(precisionColor1,0:1:8); title('Color 1','FontSize',18); xlabel('Precision','FontSize',14); axis([-0.5 10 0 10]);
subplot(2,2,2);
hist(precisionColor2,0:1:8); title('Color 2','FontSize',18); xlabel('Precision','FontSize',14); axis([-0.5 10 0 10]);
subplot(2,2,3);
hist(precisionFace1,0:1:8); title('Face 1','FontSize',18); xlabel('Precision','FontSize',14); axis([-0.5 10 0 10]);
subplot(2,2,4);
hist(precisionFace2,0:1:8); title('Face 2','FontSize',18); xlabel('Precision','FontSize',14); axis([-0.5 10 0 10]);
hist(mean([probGuessColor1,probGuessColor2,probGuessFace1,probGuessFace2],2),0:0.5:5); title('Overall','FontSize',18); xlabel('Precision','FontSize',14); axis([-0.5 5 0 20]);
%}
%% CALIBRATION DATA FILTER
precisionOK = ones(size(filteredIDs));
guessesOK = ones(size(filteredIDs));
if filterCalibrationBegin
    % Filter based on calibration precision (e.g. precision > 1)
    precisionOK = and(precisionOK,and(precisionColor1>precisionThreshold,precisionFace1>precisionThreshold));
    % Filter subjects based on probability of guesses
    guessesOK = and(guessesOK,and(probGuessColor1<probGuessThreshold,probGuessFace1<probGuessThreshold));
end
if filterCalibrationEnd
    % Filter based on calibration precision (e.g. precision > 1)
    precisionOK = and(precisionOK,and(precisionColor2>precisionThreshold,precisionFace2>precisionThreshold));
    % Filter subjects based on probability of guesses
    guessesOK = and(guessesOK,and(probGuessColor2<probGuessThreshold,probGuessFace2<probGuessThreshold));
end

filteredIDs = filteredIDs(and(precisionOK,guessesOK));
display(['Number subjects after calibration data filter: ' num2str(length(filteredIDs))]);







%% ANALYZE PRIME DATA
precisionColor = nan(length(filteredIDs),length(targetDur),length(ISIDur));
biasColor = nan(length(filteredIDs),length(targetDur),length(ISIDur));
probGuessColor = nan(length(filteredIDs),length(targetDur),length(ISIDur));
probPrimeColor = nan(length(filteredIDs),length(targetDur),length(ISIDur));
precisionFace = nan(length(filteredIDs),length(targetDur),length(ISIDur));
biasFace = nan(length(filteredIDs),length(targetDur),length(ISIDur));
probGuessFace = nan(length(filteredIDs),length(targetDur),length(ISIDur));
probPrimeFace = nan(length(filteredIDs),length(targetDur),length(ISIDur));
errorColor = cell(length(targetDur),length(ISIDur));
errorFace = cell(length(targetDur),length(ISIDur));
% Loop through each of the scans
for j=1:length(targetDur)
    for k=1:length(ISIDur)
        thisDBnameColor = ['db.data.prime_A5000_T' num2str(targetDur(j)) '_ISI' num2str(ISIDur(k)) 'Face_Mask'];
        thisDBnameFace = ['db.data.prime_A5000_T' num2str(targetDur(j)) '_ISI' num2str(ISIDur(k)) 'Face'];
        display(['Analyzing: A5000_T' num2str(targetDur(j)) '_ISI' num2str(ISIDur(k))])
        [precisionColor(:,j,k), biasColor(:,j,k), probGuessColor(:,j,k), probPrimeColor(:,j,k), errorColor{j,k}] = primeData(eval(thisDBnameColor),filteredIDs);
        [precisionFace(:,j,k), biasFace(:,j,k), probGuessFace(:,j,k), probPrimeFace(:,j,k), errorFace{j,k}] = primeData(eval(thisDBnameFace),filteredIDs);
    end
end

%% PRIME DATA FILTER
probGuessColor = reshape(probGuessColor,size(probGuessColor,1),size(probGuessColor,2)*size(probGuessColor,3));
probGuessFace = reshape(probGuessFace,size(probGuessFace,1),size(probGuessFace,2)*size(probGuessFace,3));
probPrimeColor = reshape(probPrimeColor,size(probPrimeColor,1),size(probPrimeColor,2)*size(probPrimeColor,3));
probPrimeFace = reshape(probPrimeFace,size(probPrimeFace,1),size(probPrimeFace,2)*size(probPrimeFace,3));
% Plot results
%{
subplot(2,2,1);
hist(mean(probGuessColor,2),0:0.05:1); title('Guess-rate Color','FontSize',18); axis([-0.025 1 0 15]);
subplot(2,2,2);
hist(mean(probGuessFace,2),0:0.05:1); title('Guess-rate Face','FontSize',18); axis([-0.025 1 0 15]);
subplot(2,2,3);
hist(mean(probPrimeColor,2),0:0.05:1); title('Prime-rate Color','FontSize',18); axis([-0.025 1 0 15]);
subplot(2,2,4);
hist(mean(probPrimeFace,2),0:0.05:1); title('Prime-rate Face','FontSize',18); axis([-0.025 1 0 15]);

scatter(mean(probGuessColor,2),mean(probGuessFace,2),'filled'); xlabel('Guess Color'); ylabel('Guess Face')
scatter(mean(probPrimeColor,2),mean(probPrimeFace,2),'filled'); xlabel('Prime Color'); ylabel('Prime Face')
scatter(mean(probGuessColor,2),mean(probPrimeColor,2),'filled'); xlabel('Guess Color'); ylabel('Prime Color')
scatter(mean(probGuessFace,2),mean(probPrimeFace,2),'filled'); xlabel('Guess Face'); ylabel('Prime Face')
%}
% Determine subjects with high probGuess or high probPrime
probGuessColorOK = sum(probGuessColor>probGuessThreshold,2) < maxNumberOfTasksAboveThreshold;
probGuessFaceOK = sum(probGuessFace>probGuessThreshold,2) < maxNumberOfTasksAboveThreshold;
probGuessOK = and(probGuessColorOK,probGuessFaceOK);
probPrimeColorOK = sum(probPrimeColor>probPrimeThreshold,2) < maxNumberOfTasksAboveThreshold;
probPrimeFaceOK = sum(probPrimeFace>probPrimeThreshold,2) < maxNumberOfTasksAboveThreshold;
probPrimeOK = and(probPrimeColorOK,probPrimeFaceOK);
if filterPrime
    % Apply the filter (remove bad subjects)
    filteredIDs = filteredIDs(and(probGuessOK,probPrimeOK));
    display(['Number subjects after prime data filter: ' num2str(length(filteredIDs))]);
    % Loop through each of the scans, reanalyzing only the data from the good subjects
    precisionColor = nan(length(filteredIDs),length(targetDur),length(ISIDur));
    biasColor = nan(length(filteredIDs),length(targetDur),length(ISIDur));
    probGuessColor = nan(length(filteredIDs),length(targetDur),length(ISIDur));
    probPrimeColor = nan(length(filteredIDs),length(targetDur),length(ISIDur));
    precisionFace = nan(length(filteredIDs),length(targetDur),length(ISIDur));
    biasFace = nan(length(filteredIDs),length(targetDur),length(ISIDur));
    probGuessFace = nan(length(filteredIDs),length(targetDur),length(ISIDur));
    probPrimeFace = nan(length(filteredIDs),length(targetDur),length(ISIDur));
    for j=1:length(targetDur)
        for k=1:length(ISIDur)
            thisDBnameColor = ['db.data.prime_A5000_T' num2str(targetDur(j)) '_ISI' num2str(ISIDur(k)) 'Face_Mask'];
            thisDBnameFace = ['db.data.prime_A5000_T' num2str(targetDur(j)) '_ISI' num2str(ISIDur(k)) 'Face'];
            display(['Analyzing: A5000_T' num2str(targetDur(j)) '_ISI' num2str(ISIDur(k))])
            [precisionColor(:,j,k), biasColor(:,j,k), probGuessColor(:,j,k), probPrimeColor(:,j,k), errorColor{j,k}] = primeData(eval(thisDBnameColor),filteredIDs);
            [precisionFace(:,j,k), biasFace(:,j,k), probGuessFace(:,j,k), probPrimeFace(:,j,k), errorFace{j,k}] = primeData(eval(thisDBnameFace),filteredIDs);
        end
    end
end


%% PROCESS RESULTS
meanBiasColor = nan(length(targetDur),length(ISIDur));
meanBiasFace = nan(length(targetDur),length(ISIDur));
for j=1:length(targetDur)
    for k=1:length(ISIDur)
        [~, meanBiasColor(j,k)] = JV10_error(errorColor{j,k});
        [~, meanBiasFace(j,k)] = JV10_error(errorFace{j,k});
    end
end

% Reshape and convert to degrees
meanBiasColor = rad2deg(meanBiasColor);
meanBiasFace = rad2deg(meanBiasFace);


%% PLOT RESULTS
set(0,'DefaultAxesFontSize',14)
colorRange = max(abs(min(meanBiasColor(:))),abs(max(meanBiasColor(:))));
faceRange = max(abs(min(meanBiasFace(:))),abs(max(meanBiasFace(:))));
commonRange = max(colorRange,faceRange);
figure(1);

subplot(1,2,1);
imagesc(meanBiasColor);
colormap(b2r(-commonRange,commonRange)), colorbar, title('Face Mask');
set(gca, 'YTickLabel',num2cell(targetDur), 'YTick',1:numel(num2cell(targetDur)))
set(gca, 'XTickLabel',num2cell(ISIDur), 'YTick',1:numel(num2cell(ISIDur)))
ylabel('Target');
xlabel('ISI');

subplot(1,2,2);
imagesc(meanBiasFace);
colormap(b2r(-commonRange,commonRange)), colorbar, title('Face');
set(gca, 'YTickLabel',num2cell(targetDur), 'YTick',1:numel(num2cell(targetDur)))
set(gca, 'XTickLabel',num2cell(ISIDur), 'YTick',1:numel(num2cell(ISIDur)))
ylabel('Target');
xlabel('ISI');

dimVert_cm = 15;
dimHorz_cm = 50;
set(figure(1), 'units', 'centimeters', 'position', [20 30 dimHorz_cm dimVert_cm])

figure(2)
labels = {'100/50' '200/50' '400/50' '100/100' '200/100' '400/100' '100/200' '200/200' '400/200' '100/400' '200/400' '400/400'};
subplot(2,1,1)
colorSTE = rad2deg(std(reshape(biasColor,size(biasColor,1),size(biasColor,2)*size(biasColor,3)))/sqrt(size(biasColor,1)));
colorMean = rad2deg(mean(reshape(biasColor,size(biasColor,1),size(biasColor,2)*size(biasColor,3))));
barwitherr(colorSTE,colorMean);
title('Face Mask','FontSize',18)
set(gca, 'XTickLabel',labels, 'XTick',1:numel(labels))
ylim([-1.5*commonRange,1.5*commonRange])
xlabel('Target/ISI','FontSize',16)
subplot(2,1,2)
faceSTE = rad2deg(std(reshape(biasFace,size(biasFace,1),size(biasFace,2)*size(biasFace,3)))/sqrt(size(biasFace,1)));
faceMean = rad2deg(mean(reshape(biasFace,size(biasFace,1),size(biasFace,2)*size(biasFace,3))));
barwitherr(faceSTE,faceMean);
title('Face','FontSize',18)
set(gca, 'XTickLabel',labels, 'XTick',1:numel(labels))
ylim([-1.5*commonRange,1.5*commonRange])
xlabel('Target/ISI','FontSize',16)
set(figure(2), 'units', 'centimeters', 'position', [20 4 1.5*dimHorz_cm 1.5*dimVert_cm])

