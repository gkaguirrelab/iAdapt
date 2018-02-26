function params = importparams(connector, localParamDir)
% The connector data structure holds information used to connect
% to the database/server

import java.util.LinkedList
% Delete and recreate parameter directory, effectively clearing contents
if exist(localParamDir, 'dir')
    rmdir(localParamDir, 's');
    mkdir(localParamDir);
end
getparams(connector.serverPssword, connector.serverparamDir, localParamDir);

params = struct;
% Save current directory
origDir = pwd;
cd(localParamDir);
currentDir = dir(pwd);
queue = LinkedList();
for i = 1:length(currentDir)
    if currentDir(i).name(1) ~= '.'
        if currentDir(i).isdir
            queue.add([pwd '/' currentDir(i).name]);
        else
            [pathstr,name,ext] = fileparts([pwd '/' currentDir(i).name]);
            params.([name '_' strrep(ext, '.', '')]) = importdata(currentDir(i).name);
        end
    end 
end

% Go through all directories contained in localParamDir, and create a field for the 
% params datastruct with the content of each file
while queue.size() ~= 0
    cd(queue.pop);
    currentDir = dir(pwd);
    for i = 1:length(currentDir)
        if currentDir(i).name(1) ~= '.'
            if currentDir(i).isdir
                queue.add([pwd '/' currentDir(i).name]);
            else
                [pathstr,name,ext] = fileparts([pwd '/' currentDir(i).name]);
                params.([name '_' strrep(ext, '.', '')]) = importdata(currentDir(i).name);
            end
        end
    end
    
end

cd(origDir)
