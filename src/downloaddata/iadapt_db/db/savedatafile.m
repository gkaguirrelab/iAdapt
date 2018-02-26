function savedatafile

dataFile = 'iAdapt';
extension = '.sql';
source = fullfile(fileparts(pwd),'SQL_data');
destination = fullfile(fileparts(pwd),'DB_History');
date_time = strrep(datestr(now), ':', '_');
% Make copy of file with currnet date and time to make file name unique
copyfile([source '/' dataFile extension], [destination '/' dataFile date_time extension]);


