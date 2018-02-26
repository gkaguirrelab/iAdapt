function [data, params] = loaddb(pastDB)

% Loads db variables from local directory
if nargin == 1
    matFile = pastDB;
    cd ..
    cd ..
    cd DB_History
else
    matFile = 'db';
    cd ..;
    cd ..;
    cd Current_DB;
end
loaded = load([matFile '.mat']); 

db = loaded.db;
data = db.data;
params = db.params;
cd ..;
cd Analysis;
cd 4in1;