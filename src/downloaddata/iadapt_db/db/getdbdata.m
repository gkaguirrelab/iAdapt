function [localdatadir,tablenamesfile] = getdbdata(connector)
% The connector data structure holds information used to connect
% to the database/server

% Path to sql file on server
fullsqlpath = 'mysql';

host = connector.host;
database = connector.database;
dbusername = connector.dbusername;
dbPssword = connector.dbPssword;
serverPssword = connector.serverPssword;

% Directory where txt data will be saved on server
datadir = '/home/mattar/data';
% Directory where txt data will be saved on local machine
localdatadir = fullfile(fileparts(pwd),'SQL_data');
% Name of file that will hold the names of the tables
tablenamesfile = 'Tables.txt';

% Give permissions to read, write to, and execute scripts
system('chmod u+rwx callDBTextDownload.sh');
system('chmod u+rwx getTextData.sh');
% Dump sql data into text files on server by calling .sh file that we placed on server
system(['./callDBTextDownload.sh ' serverPssword ' ' dbPssword ' ' fullsqlpath ' ' datadir ' ' host ' ' database ' ' dbusername ' ' dbPssword  ' ' tablenamesfile]);
% Get sql text data from server to local directory
system(['./getTextData.sh ' serverPssword ' ' datadir ' ' localdatadir]);

[~,splitServerDir] = fileparts(datadir);
localdatadir = fullfile(localdatadir,splitServerDir);

