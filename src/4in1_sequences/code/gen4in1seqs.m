function [taskSeqs, primeSeqs] = gen4in1seqs(numTrials)
addpath(pwd);
cd ..
cd paramsFiles

direct = dir(fullfile(pwd,'*.json'));

%% GENERATE SEQUENCES
taskSeqs = zeros(numTrials,length(direct));
primeSeqs = zeros(numTrials,length(direct));
for i=1:length(direct)
    taskVals = linspace(0,360-(360/numTrials),numTrials) + floor(rand*(360/numTrials));
    if mod(numTrials,2)==0
        primeVals = [45*ones((numTrials/2),1); -45*ones((numTrials/2),1)];
    else
        primeVals = [45*ones(floor(numTrials/2),1); 45*(2*round(rand)-1); -45*ones(floor(numTrials/2),1)];
    end
    taskSeqs(:,i) = taskVals(randperm(numTrials));
    primeSeqs(:,i) = primeVals(randperm(numTrials));
end
cd ..
cd sequences
%% SAVE TO EXTERNAL FILE
for i=1:length(direct)
    %Parse json files to extract addresses referenced for the sequences
    filestr = fileread(['../paramsFiles/' direct(i).name]);
    jsonParse = parse_json(filestr);
    if isfield(jsonParse{1}, 'stimulusSeq')
        splitAddress = strsplit(jsonParse{1}.stimulusSeq,'/');
        dlmwrite(['./' splitAddress{length(splitAddress)}], taskSeqs(:,i));
    end
    if isfield(jsonParse{1}, 'primeSeq')
        splitAddress = strsplit(jsonParse{1}.primeSeq,'/');
        dlmwrite(['./' splitAddress{length(splitAddress)}], primeSeqs(:,i));
    end
end

cd ..
cd code
