% DOWNLOAD DATA
% Download the data (and parameters) from the server
[rawData,params] = downloadData;

% Extract relevant data
ID = rawData.Users.ID;
Nationality = rawData.Users.Nationality;
Age = rawData.Users.Age;
Gender = rawData.Users.Gender;
Handedness = rawData.Users.Handedness;

% Create table with the data
T = table(ID,Nationality,Age,Gender,Handedness);

% Write table to excel file
writetable(T,'EthnicityInfo.csv')