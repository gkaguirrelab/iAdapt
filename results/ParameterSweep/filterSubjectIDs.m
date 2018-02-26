function [filteredIDs amountPaid] = filterSubjectIDs(db, dateRange, origIDs)

% If no subset of user IDs was entered, use all of them
if nargin<3
    origIDs = db.data.Users.ID; % Include all IDs
end
if nargin<2
    dateRange = {'July 18, 2014', 'July 21, 2014'};
end

origIDs = ismember(db.data.Users.ID,origIDs);

%% FILTER USERS BY DATE & COMPLETION
dayBegin = dateRange(1);
dayEnd = dateRange(2);

% Convert each date to number of days since January 0, 0000
allDates = cellstr(db.data.Users.initialTimeStamp);
allDates = datevec(allDates);
allDates = datenum(allDates(:,1:3));
IDsWithinDateRange = ismember(allDates,datenum(dayBegin):datenum(dayEnd));
filteredIDs = and(origIDs,IDsWithinDateRange);

% Make sure that all subjects completed all trials in all experiments
structurefields = fieldnames(db.data);
allIDs = db.data.Users.ID(filteredIDs);
trialsCompleted = nan(length(allIDs),0);
for k=1:length(structurefields)
    this_struct = db.data.(structurefields{k});
    if isfield(this_struct,'userID')
        temp = nan(length(allIDs),1);
        for s=1:length(allIDs)
            temp(s) = sum(this_struct.userID==allIDs(s));
        end
        trialsCompleted = [trialsCompleted temp]; %#ok<AGROW>
    end
end
subjWhoCompleted = allIDs(sum(trialsCompleted,2)==max(sum(trialsCompleted,2)));
subjWhoCompleted = ismember(db.data.Users.ID,subjWhoCompleted);
filteredIDs = and(filteredIDs,subjWhoCompleted);

%% FILTER USERS BY COLOR DEPTH
minColorDepth = 24;
filteredIDs = and(filteredIDs,str2double(cellstr(db.data.Users.colorDepth))>=minColorDepth);

%% FILTER USERS BY DEMOGRAPHICS
%{
agerange = 15:50;
gender = {'Male', 'Female','Other'};
handedness = {'Left-handed', 'Right-handed','Ambidextrous };

filteredIDs = and(filteredIDs,ismember(db.data.Users.Age,agerange));
filteredIDs = and(filteredIDs,ismember(db.data.Users.Gender,gender));
filteredIDs = and(filteredIDs,ismember(db.data.Users.Handedness,handedness));
%}

%% FILTER USERS BY ISHIHARA SCORE
minIshiharaScore = 7;
tempIshihara = cellstr(db.data.Users.ishiharaScore(:,1));
ishiharaScore = nan(length(tempIshihara),1);
for i=1:length(ishiharaScore)
    ishiharaScore(i) = str2double(tempIshihara{i});
end
filteredIDs = and(filteredIDs,ishiharaScore>minIshiharaScore);

%% CALCULATE AMOUNT PAID
amountPaid = nan(size(filteredIDs));
for i=1:length(amountPaid)
    if filteredIDs(i)
        amountPaid(i) = str2double(db.data.Users.amountPaid(i,:));
    end
end

%% OUTPUT ID NUMBERS
filteredIDs = db.data.Users.ID(filteredIDs);