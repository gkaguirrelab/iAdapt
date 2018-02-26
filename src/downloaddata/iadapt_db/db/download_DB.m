function [db, data, params] = download_DB

%Set task and location of iAdapt_DB on the current machine 
serverdbConnector = 'iAdapt';
iAdapt_DB_dir = fileparts(fileparts(pwd));

%Load connection data structure
serverdbConnectDir = 'serverdbConnector/serverdbConnectors/';
connector = load([serverdbConnectDir serverdbConnector '.mat']);
connector = connector.serverdbConnector;

% Get DB data from server database
[datadir, tablenamesfile] = getdbdata(connector);
tables = importdata([datadir '/' tablenamesfile]);
data = struct;
for i = 1:length(tables)
    data.(tables{i}) = tdfread([datadir '/' tables{i} '.txt']);
end

% Get parameters from server
localParamDir = [iAdapt_DB_dir '/' 'iAdapt_DB/Params/parameters'];
params = importparams(connector, localParamDir);

% Save to Current_DB directory as well as to DB_History
db = struct;
db.data = data;
db.params = params;
cd ..
cd Current_DB
save('db.mat', 'db');
cd ..
cd DB
saveAll(db, serverdbConnector);
