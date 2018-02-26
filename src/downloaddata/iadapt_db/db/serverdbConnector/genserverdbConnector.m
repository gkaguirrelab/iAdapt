function serverdbConnector  = genserverdbConnector(serverPssword, dbPssword, host, database, dbusername, serverparamDir, serverdbConnectorName)
% Generates a serverdb datastructure to be used with functions that connect
% to the server/db and save it to the genserverdbConnectors directory

serverdbConnector = struct;
serverdbConnector.serverPssword = serverPssword;
serverdbConnector.dbPssword = dbPssword;
serverdbConnector.host = host;
serverdbConnector.database = database;
serverdbConnector.dbusername = dbusername;
serverdbConnector.serverparamDir = serverparamDir;

save(['serverdbConnectors' '/' serverdbConnectorName],'serverdbConnector')
