function [ experData ] = filtIDs( experData, IDs, minTrialNum )
% Given an experiment data structure, returns an experiment datastruct
% only contianing data pertaining to the range of IDS specified, with at
% least a "minTrialNum"th trial. Both bounds of the range are inclusive. minTrialNum is
% an optional variable. This function assumes that the experiment fields contain
% the same number of elements for a given experiment (one for each trial)

% Give trialNum a default value of 0 if user doesn't input
% it as a parameter
if nargin < 3
    minTrialNum = 0;
end

elmts = fieldnames(experData);
for i = 1:length(elmts)
    if isfield(experData.(elmts{i}), 'userID') && isfield(experData.(elmts{i}), 'trialNum')
        experElmts = fieldnames(experData.(elmts{i}));
        eachID  = zeros(length(experData.(elmts{i}).userID), 1);
        %   Select data only from subjects whose IDs are given
        for j = 1:length(IDs)
            eachID = or(experData.(elmts{i}).userID == IDs(j), eachID);
        end
        trialIndices = experData.(elmts{i}).trialNum >= minTrialNum;
        trialIDs = unique(experData.(elmts{i}).userID(trialIndices));
        rangeTrials = zeros(length(experData.(elmts{i}).trialNum), 1);
        % Select data only from subjects that have at least a
        % "minTrialNumntrials"th trial
        for j = 1:length(trialIDs)
            rangeTrials = or(experData.(elmts{i}).userID == trialIDs(j), rangeTrials);
        end
        for j = 1:length(experElmts)
            %Convert character fields to cell arrays
            if ischar(experData.(elmts{i}).(experElmts{j}))
                experData.(elmts{i}).(experElmts{j}) = cellstr(experData.(elmts{i}).(experElmts{j}));
            end
            experData.(elmts{i}).(experElmts{j}) = experData.(elmts{i}).(experElmts{j})(and(eachID,rangeTrials));
        end
    end
end