function savedbmat(db, savename)

datastruct = 'db';
savename = [savename '_'];
extension = '.mat';
destination = fullfile(fileparts(pwd),'DB_History');
date_time = strrep(datestr(now), ':', '_');
save([destination '/' savename date_time extension], datastruct);
