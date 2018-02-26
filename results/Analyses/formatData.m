function formatedData = formatData(rawData,dateRange)

if nargin<2
    dateRange = {'October 7, 2014', 'October 31, 2014'};
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

% Select only users who completed the entire experiment
IDnum = rawData.Users.ID(filteredIDs);
for i = 1:length(IDnum)
    thisID = IDnum(i);
    if (sum(ismember(rawData.calibColor2.userID,thisID))==0) || (max(rawData.calibColor2.trialNum(ismember(rawData.calibColor2.userID,thisID))) < 1)
        filteredIDs(rawData.Users.ID==thisID) = 0;
    end
end
validIDs = rawData.Users.ID(filteredIDs);


%% FORMAT DATA
data= struct;
for i=1:length(validIDs)
    thisID = validIDs(i);
    % Extract basic info from subjects
    userFields = fieldnames(rawData.Users);
    for f=1:length(userFields)
        data.(['s' num2str(thisID)]).info.(userFields{f}) = rawData.Users.(userFields{f})(rawData.Users.ID==thisID,:);
    end
    
    % Loop through each task, extracting the relevant data
    allTasks = fieldnames(rawData);
    allTasks = allTasks(~strcmp(fieldnames(rawData),'Users'));
    for j=1:length(allTasks)
        thisTask = allTasks{j};
        if isfield(rawData.(thisTask),'userID') % If userID field exists
            if sum(ismember(rawData.(thisTask).userID,thisID)) % If this subject completed any trial
                data.(['s' num2str(thisID)]).(thisTask).trialNum = rawData.(thisTask).trialNum(ismember(rawData.(thisTask).userID,thisID));
                data.(['s' num2str(thisID)]).(thisTask).targetVal = rawData.(thisTask).correctResp(ismember(rawData.(thisTask).userID,thisID));
                data.(['s' num2str(thisID)]).(thisTask).responseVal = rawData.(thisTask).responseGiven(ismember(rawData.(thisTask).userID,thisID));
                data.(['s' num2str(thisID)]).(thisTask).reactionTime = rawData.(thisTask).reactionTime(ismember(rawData.(thisTask).userID,thisID));
                data.(['s' num2str(thisID)]).(thisTask).accuracy = rawData.(thisTask).accuracyScore(ismember(rawData.(thisTask).userID,thisID));
                if isfield(rawData.(thisTask),'primeShift')
                    data.(['s' num2str(thisID)]).(thisTask).adaptor = rawData.(thisTask).primeShift(ismember(rawData.(thisTask).userID,thisID));
                end
            end
        end
    end
end

%% OUTPUT DATA
formatedData = data;