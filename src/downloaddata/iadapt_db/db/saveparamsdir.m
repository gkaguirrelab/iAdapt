function saveparamsdir(savename)

dirName = savename;
source = fullfile(fileparts(pwd),'Params', 'parameters');
destination = fullfile(fileparts(pwd),'DB_History');
date_time = strrep(datestr(now), ':', '_');
% Make copy of file with current date and time to make file name unique
copyfile(source, [destination '/' dirName date_time]);

