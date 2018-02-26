function saveAll(db, savename)
% Saves a version of the SQL data file,the db data structure, and the params directory 

savedbmat(db, savename);
saveparamsdir(savename);