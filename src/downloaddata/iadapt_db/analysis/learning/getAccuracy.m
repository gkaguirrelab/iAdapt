function [accuracy] = getAccuracy(theOnes,respVals, actVals)
% This function assumes that respVals and actVals are the same length

if ischar(respVals)
    respVals = cellstr(respVals);
end

% Convert all subjects' responses to 1s and 0s. Remove
% rows containing "Null"
for i = 1:length(theOnes)
   respVals(strcmpi(respVals,theOnes(i))) = {'1'};
end
logicalZeros = logical(abs(strcmp(respVals, '1') - 1));
logicalNulls = strcmpi(respVals, 'null');
% Remove rows continaing "null"
respVals(logicalZeros) = {'0'};
respVals(logicalNulls) = [];
actVals(logicalNulls) = [];
respVals = str2double(respVals);
accuracy = sum(respVals == actVals)/length(actVals);



