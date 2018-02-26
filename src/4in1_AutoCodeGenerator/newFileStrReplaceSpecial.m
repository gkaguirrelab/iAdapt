function newFileStrReplace(origFile, newFile, origString, newString)
% Create a new file with name newFile, which is a copy of
% origFile, but with origString replaced by newString. If
% newFile already exists, it will be replaced by a new file, with the
% changes produced by this function. Replaced text can contain special
% characters

str = fileread(origFile);               
str = strrep(str, origString, newString);        
fid = fopen(newFile, 'w');
fprintf(fid, str);              
fclose(fid);
