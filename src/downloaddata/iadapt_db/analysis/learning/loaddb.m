function [data, params] = loaddb
% Loads db variables from local directory
matFile = 'db';
cd ..;
cd ..;
cd Current_DB;
loaded = load([matFile '.mat']);
db = loaded.db;
data = db.data;
params = db.params;
cd ..;
cd Analysis;
cd learning;