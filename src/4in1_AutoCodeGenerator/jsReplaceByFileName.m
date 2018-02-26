function jsReplaceByFileName(origTaskString)

addpath(pwd);
cd ..;
cd jsFiles/clones;
direct = dir(fullfile(pwd,'*.js'));
for i = 1:length(direct)
   fileName = direct(i).name;
    newFileStrReplace(fileName,fileName, origTaskString, fileName(1:length(fileName)-3));
end

cd ..;
cd ..;
cd code;