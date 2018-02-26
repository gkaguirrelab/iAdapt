function [precisionRad, biasRad, probGuess, dataDeg] = calibrationData(dataStructure,subjIDs)

addpath('./jv10');

dataDeg = cell(length(subjIDs),1);
precisionRad = nan(length(subjIDs),1);
probGuess = nan(length(subjIDs),1);
biasRad = nan(length(subjIDs),1);
for s = 1:length(subjIDs)
    thisID = subjIDs(s);
    subjData = ismember(dataStructure.userID,thisID);
    if isnumeric(dataStructure.responseGiven(subjData,:))
        responseGiven = dataStructure.responseGiven(subjData,:);
    else
        responseGiven = str2double(cellstr(dataStructure.responseGiven(subjData,:)));
    end
    correctResp = dataStructure.correctResp(subjData,:);
    
    % Shift arrays to correct range
    X = wrap(responseGiven/180*pi);
    T = wrap(correctResp/180*pi);
    E = wrap(X-T);
    
    % Calculate precision and bias
    [P, B] = JV10_error(wrap(E));
    
    % Mixture modelling to infer guesses 
    mmPars = JV10_fit(X(~isnan(E)), T(~isnan(E)));
    
    % Save to output arrays
    dataDeg{s} = [correctResp responseGiven rad2deg(E)];
    precisionRad(s) = P;
    biasRad(s) = B;
    probGuess(s) = mmPars(4);
end

% Analyze uniformity of wheel
%{
allCorrectResp=dataStructure.correctResp(ismember(dataStructure.userID,subjIDs));
allResponseGiven=dataStructure.responseGiven(ismember(dataStructure.userID,subjIDs),:);
if ~isnumeric(allResponseGiven)
    allResponseGiven=str2double(cellstr(allResponseGiven));
end
allErrors=wrap((allCorrectResp-allResponseGiven)/180*pi);

T = wrap(allCorrectResp/180*pi);
X = wrap(allResponseGiven/180*pi);
[P, B] = JV10_error(X(~isnan(X)),T(~isnan(X)));

subplot(121);
scatter(allCorrectResp,allResponseGiven,'*'); axis equal; axis square; axis([0 360 0 360]); title('Accuracy','FontSize',18); xlabel('Target'); ylabel('Response');
subplot(122);
scatter(allCorrectResp,abs(allErrors/pi*180),'*'); axis([0 360 0 180]); title(['Average precison: ' num2str(P)],'FontSize',18); xlabel('Target'); ylabel('Error');
%}