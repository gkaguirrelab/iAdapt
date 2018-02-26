function [payTable payArray] = paySubjects(rawData,dateRange)

if nargin<2
    dateRange = {'August 1, 2014', 'September 4, 2014'};
end


%% EXTRACT LIST OF USER IDS

% Select users by date of completion
dayBegin = dateRange(1);
dayEnd = dateRange(2);
% Convert each date to number of days since January 0, 0000
allDates = cellstr(rawData.Users.initialTimeStamp);
allDates = datevec(allDates);
allDates = datenum(allDates(:,1:3));
IDsWithinDateRange = ismember(allDates,datenum(dayBegin):datenum(dayEnd));
filteredIDs = IDsWithinDateRange;

% Extract 
allIDs = rawData.Users.ID(filteredIDs);
payTable = cell(length(allIDs)+1,4);
payTable(2:end,1) = num2cell(allIDs);
payTable{1,2} = 'COMPLETIONCODE';
payTable{1,3} = 'BASEPAY';
for i = 1:length(allIDs)
    thisID = allIDs(i);
    payTable{i+1,2} = rawData.Users.completionCode(rawData.Users.ID==thisID,:);
    payTable{i+1,3} = str2double(rawData.Users.amountPaid(rawData.Users.ID==thisID,:));
end

% Figure out who completed the entire experiment (to get bonus)
completedAll = nan(length(allIDs),1);
for i = 1:length(allIDs)
    thisID = allIDs(i);
    if (sum(ismember(rawData.calibColor2.userID,thisID))==0) || (max(rawData.calibColor2.trialNum(ismember(rawData.calibColor2.userID,thisID))) < 1)
        completedAll(i) = 0;
    else
        completedAll(i) = 1;
    end
end
completedIDs = allIDs(logical(completedAll));

% Double payment of those who completed the entire experiment
payArray = nan(length(allIDs),1);
payTable{1,4} = 'PAY+BONUS';
for i = 1:length(allIDs)
    if completedAll(i)
        payArray(i) = (payTable{i+1,3}*2)/100;
    else
        payArray(i) = (payTable{i+1,3}*1)/100;
    end
    payTable{i+1,4} = sprintf('$ %.2f',payArray(i));
end

% Sort by completion time
completionTime = datenum(cellstr(rawData.Users.finalTimeStamp));
completionTime = completionTime(filteredIDs);
[~,sortIdx] = sort(completionTime);
payTable(2:end,:) = payTable(sortIdx+1,:);

