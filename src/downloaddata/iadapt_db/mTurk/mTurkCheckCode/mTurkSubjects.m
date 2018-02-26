filename = 'Batch_1639218_batch_results';
minInitialTimestamp = '2014-08-6 0:0:0';
finalTask = 'calibFace2';
idIndex = 27;
codeIndex = 39;

[notInDB, dupCodes] = mTurkConfirm(filename, codeIndex,minInitialTimestamp);
codeIDs = getCodeIDs(filename, idIndex, codeIndex);
subjPay = getSubjectPay(codeIDs);
% Convert payment to numeric dollars
subjPay.payment = str2double(subjPay.payment)/100;
% Double payment for all subjects who completed the experiment
data = loaddb;
completedIDs = unique(data.(finalTask).userID);
subjPay.payment(ismember(subjPay.userID, completedIDs)) = subjPay.payment(ismember(subjPay.userID, completedIDs))*2;
clearvars filename minInitialTimestamp codeIDs idIndex codeIndex data finalTask completedIDs
