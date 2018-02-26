function [data, params] = downloadData(experimentName,remove_datafiles_from_local_directories)

if nargin<2
    remove_datafiles_from_local_directories = true;
end

if nargin<1
    experimentName = 'iadapt';
end

% Generates a serverdb datastructure to be used with functions that connect
% to the server/db and save it to the genserverdbConnectors directory
serverdbConnector = struct;
switch experimentName
    case {'iAdapt','iadapt','IAdapt'}
        serverdbConnector.serverPssword = 'aequa0Ae';
        serverdbConnector.dbPssword = 'Eife7Oorai';
        serverdbConnector.host = 'localhost';
        serverdbConnector.database = 'iadapt';
        serverdbConnector.dbusername = 'iadapt';
        serverdbConnector.serverparamDir = '/home/mattar/iadapt/parameters/';
    case {'faceRating','facerating','FaceRating'}
        serverdbConnector.serverPssword = 'aequa0Ae';
        serverdbConnector.dbPssword = 'Eife7Oorai';
        serverdbConnector.host = 'localhost';
        serverdbConnector.database = 'test';
        serverdbConnector.dbusername = 'iadapt';
        serverdbConnector.serverparamDir = '/home/mattar/html/faceRating/parameters/';
    case {'spaceTravel','SpaceTravel','spacetravel'}
        serverdbConnector.dbPssword = 'aP5eiBo6';
        serverdbConnector.serverPssword = 'aequa0Ae';
        serverdbConnector.host = 'localhost';
        serverdbConnector.database = 'SpaceTravel';
        serverdbConnector.dbusername = 'mattar';
        serverdbConnector.serverparamDir = '/home/mattar/html/spaceTravel/parameters/';
    case {'blue','Blue'}
        serverdbConnector.serverPssword = 'aequa0Ae';
        serverdbConnector.dbPssword = 'EeT4phoj1kaec1ohs2bohWof';
        serverdbConnector.host = 'localhost';
        serverdbConnector.database = 'blue';
        serverdbConnector.dbusername = 'blue';
        serverdbConnector.serverparamDir = '/home/mattar/iadapt/blue/parameters/';
end

% Directory where txt data will be saved on server
serverDataDir = '/home/mattar/data';
% Directory where txt data will be saved on local machine
localDataDir = './';
localParamsDir = './';
% Name of file that will hold the names of the tables
tablenamesfile = 'Tables.txt';

% Give permissions to read, write to, and execute scripts
system('chmod u+rwx callDBTextDownload.sh');
system('chmod u+rwx getTextData.sh');
system('chmod u+rwx getParams.sh');


% Dump sql data into text files on server by calling .sh file that we placed on server
system(['./callDBTextDownload.sh ' serverdbConnector.serverPssword ' ' serverdbConnector.dbPssword ' mysql ' serverDataDir ' ' serverdbConnector.host ' ' serverdbConnector.database ' ' serverdbConnector.dbusername ' ' serverdbConnector.dbPssword  ' ' tablenamesfile]);
% Get sql text data from server to local directory
system(['./getTextData.sh ' serverdbConnector.serverPssword ' ' serverDataDir ' ' localDataDir]);

% Extract table information
tables = importdata(fullfile(localDataDir,'data',tablenamesfile));

% Download data from each table
data = struct;
for i = 1:length(tables)
    data.(tables{i}) = tdfread(fullfile(localDataDir,'data',[tables{i} '.txt'])); 
end



%% DOWNLOAD PARAMETER LIST
import java.util.LinkedList
% Give permissions to read, write to, and execute scripts

% Download parameter files from the server to the local directory
system(['./getParams.sh ' serverdbConnector.serverPssword ' ' serverdbConnector.serverparamDir ' ' localParamsDir]);

% Extract parameters info into a structure
params = struct;
% Create fields for each subfolder
allContents = dir(fullfile(localParamsDir,'parameters'));
for i=1:length(allContents)
    if allContents(i).name(1)~='.'
        % If it is a file
        if ~isdir(fullfile(localParamsDir,'parameters',allContents(i).name))
            thisFile = fullfile(localParamsDir,'parameters',allContents(i).name);
            [~,filename,fileextension] = fileparts(thisFile);
            fileContents = importdata(thisFile,'!');
            if strcmp(fileextension, '.json')
                % Extract contents of the file
                for line=1:length(fileContents)
                    parsedLine = strsplit(fileContents{line},':');
                    if length(parsedLine)==2
                        thisfield = regexp(parsedLine{1}, '(?<=")[^"]+(?=")', 'match');
                        thisvalue = regexp(parsedLine{2}, '(?<=")[^"]+(?=")', 'match');
                        if isempty(thisvalue)
                            thisvalue = cellstr(num2str(str2double(parsedLine{2})));
                        end
                        if exist(thisvalue{1},'file')==2
                            params.(filename).(thisfield{1})=fileread(thisvalue{1});
                        else
                            params.(filename).(thisfield{1})=thisvalue{1};
                        end
                    end
                end
            else
                params.(filename)=fileContents;
            end
        else % If it is a directory
            thisDir = fullfile(localParamsDir,'parameters',allContents(i).name);
            [~,dirname,~] = fileparts(thisDir);
            thisDirContents = dir(thisDir);
            for j=1:length(thisDirContents)
                if thisDirContents(j).name(1)~='.'
                    thisFile = fullfile(thisDir,thisDirContents(j).name);
                    [~,filename,fileextension] = fileparts(thisFile);
                    fileContents = importdata(thisFile,'!');
                    if strcmp(fileextension, '.json')
                        % Extract contents of the file
                        for line=1:length(fileContents)
                            parsedLine = strsplit(fileContents{line},':');
                            if length(parsedLine)==2
                                thisfield = regexp(parsedLine{1}, '(?<=")[^"]+(?=")', 'match');
                                thisvalue = regexp(parsedLine{2}, '(?<=")[^"]+(?=")', 'match');
                                if isempty(thisvalue)
                                    thisvalue = cellstr(num2str(str2double(parsedLine{2})));
                                end
                                if exist(thisvalue{1},'file')==2
                                    params.(dirname).(filename).(thisfield{1})=fileread(thisvalue{1});
                                else
                                    params.(dirname).(filename).(thisfield{1})=thisvalue{1};
                                end
                            end
                        end
                    else
                        params.(dirname).(filename)=fileContents;
                    end
                end
            end
        end
    end
end



%% DELETE EVERYTHING CREATED EXCEPT FOR THE DOWNLOADED VARIABLES
if remove_datafiles_from_local_directories
    rmdir(fullfile(localParamsDir,'data'),'s')
    rmdir(fullfile(localParamsDir,'parameters'),'s')
end
