function [notInDB, dupCodes] = mTurkConfirm(filename, codeIndex, minTimeStamp)

fileExtension = '.csv';

% Get codes from mTurk output file
[header, contents] = read_mixed_csv(['../mTurkConfirm/' filename fileExtension], ',');
turkCodes = contents(:,codeIndex);
turkCodes = (strtrim(strrep(turkCodes, '"', '')));

% Get codes from database
data  = loaddb;
dbCodes = cellstr(data.Users.completionCode);
% Use codes from minTimeStamp and on. Prevents accepting codes that may
% have been given to past subjects
dbCodes = dbCodes(datenum(data.Users.initialTimeStamp) >= datenum(minTimeStamp));

notInDB = setdiff(turkCodes, dbCodes);
[C,IA,IC] = unique(turkCodes);
dupCodes = unique(turkCodes(setdiff(1:length(turkCodes), IA)));



