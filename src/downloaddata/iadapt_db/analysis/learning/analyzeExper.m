function [data, inderrors, toterrors, errorPrintout, params] = analyzeExper(experiment, IDs, minTrialNum)

if nargin < 3
    minTrialNum = 0;
end

[data, params] = loaddb;
data = filtIDs(data,IDs, minTrialNum);
[inderrors, toterrors] = geterrors(data);
errorPrintout = getErrorPrintout(inderrors, toterrors);

% Test whether the errors are centered at zero (unbiased errors)
T_Test = ttest(toterrors.(experiment).distr)


% Test whether the stimulus space is homogeneous
figure('name', ['Stimulus Space ' experiment]);
scatter(data.(experiment).stimType,abs(toterrors.(experiment).distr))

% 
% for i=0:20:(360-19)
%     bounds=[i,i+19];
%     a=errors.calibColor.distr((data.calibColor.stimType<bounds(2))&(data.calibColor.stimType>bounds(1)));
%     b=errors.calibColor.distr(~((data.calibColor.stimType<bounds(2))&(data.calibColor.stimType>bounds(1))));
%     subplot(211)
%     hist(abs(a),0:5:180)
%     xlim([0 180])
%     subplot(212)
%     hist(abs(b),0:5:180)
%     xlim([0 180])
%     pause
% end

% distr for each subj in subplots and total with mean and standv
figure('name', ['Inidividual Errors ' experiment]);
genIndivSubplots(inderrors.(experiment), @(x)hist(abs(x), 0:5:180),[0 150]);
figure('name', ['Total Errors ' experiment]);
hist(abs(toterrors.(experiment).distr),0:5:180);
Error_Report = errorPrintout.(experiment)

% Give a range of IDs for analysis
% Compare difficulties 
% Look for asymitries



