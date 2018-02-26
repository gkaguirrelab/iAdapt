subjFitsDataDir = '/Users/mattar/Desktop/Colors_subjFits';
dir_output = dir(subjFitsDataDir);

subjList = {};
calibColorP_all = [];
calibColor_fitLL_all = [];
workingMemoryColorP_all = [];
workingMemoryColor_fitLL_all = [];
adaptColorB_all = [];
adaptColorP_all = [];
adaptColor_fitLL_all = [];
for i=1:length(dir_output)
    if strcmp(dir_output(i).name,'.') || strcmp(dir_output(i).name,'..') || strcmp(dir_output(i).name,'.DS_Store')
    else
        thisFile = fullfile(subjFitsDataDir,dir_output(i).name);
        load(thisFile);
        subjList = [subjList; thisSubj];
        calibColorP_all = [calibColorP_all; calibColorP];
        calibColor_fitLL_all = [calibColor_fitLL_all; calibColor_fitLL];
        workingMemoryColorP_all = [workingMemoryColorP_all; workingMemoryColorP];
        workingMemoryColor_fitLL_all = [workingMemoryColor_fitLL_all; workingMemoryColor_fitLL];
        adaptColorB_all = [adaptColorB_all; adaptColorB];
        adaptColorP_all = [adaptColorP_all; adaptColorP];
        adaptColor_fitLL_all = [adaptColor_fitLL_all; adaptColor_fitLL];
    end
end

calibColorP = calibColorP_all;
calibColor_fitLL = calibColor_fitLL_all;
workingMemoryColorP = workingMemoryColorP_all;
workingMemoryColor_fitLL = workingMemoryColor_fitLL_all;
adaptColorB = adaptColorB_all;
adaptColorP = adaptColorP_all;
adaptColor_fitLL = adaptColor_fitLL_all;
save('combinedData.mat','subjList','calibColorP','calibColor_fitLL','workingMemoryColorP','workingMemoryColor_fitLL','adaptColorB','adaptColorP','adaptColor_fitLL');
clear
load('combinedData.mat')