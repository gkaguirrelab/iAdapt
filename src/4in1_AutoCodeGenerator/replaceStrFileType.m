function replaceStrFileType(fileType, origString, newString)

direct = dir(fullfile(pwd,['*.' fileType]));
for i = 1:length(direct)
    newFileStrReplace(direct(i).name, direct(i).name, origString, newString)
end