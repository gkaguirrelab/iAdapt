function clearDB

textFile_tablesToBeCleared = 'dbClearTables.txt';
serverPssword = 'aequa0Ae';
dbPssword = 'Eife7Oorai';
dbhost = 'localhost';
database = 'iadapt';
username = 'iadapt';
% Name of file that holds the names of the tables to be cleared (truncated) in the
% database
tablenamesfile = fullfile(fileparts(pwd),'dbClear',textFile_tablesToBeCleared);

system('chmod u+rwx clearDB.sh');
system(['./clearDB.sh ' serverPssword ' '  dbPssword ' ' dbhost ' ' database ' ' username ' ' tablenamesfile]);

