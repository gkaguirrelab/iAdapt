function genPrimeExpermtsMask()

numTrialsPerseq = 12;

oldAdapterLevels = 5000;
oldTargetLevels = [100, 200, 400];
oldIsiLevels = [50, 100, 200, 400];

adapterLevels = [50, 200, 5000];
targetLevels = 50;
isiLevels = [100, 200, 400, 3000];


levelsCombine =  genA_T_ISI_combin(adapterLevels, isiLevels, targetLevels);
fieldNames = {'prime_A', '_T', '_ISI'};
stimuli = {'Face', 'Color'};

%%Clear clones
cd .. 
cd jsFiles
cd clones
delete('*');
cd ..
cd ..
cd paramsFiles
cd clones
delete('*'); 
cd ..
cd ..
cd sequences
delete('*'); 
cd ..
cd textGen
delete('*'); 
cd ..
cd code

%%CREATE JSON CLONES
for i = 1:length(stimuli)
    stimulus = stimuli{i};
    for j = 1:length(levelsCombine)
        name = [fieldNames{1} num2str(levelsCombine(j, 1)) fieldNames{2} num2str(levelsCombine(j, 2)) fieldNames{3} num2str(levelsCombine(j, 3)) stimulus '_Mask'];
        filename = ['../paramsFiles/clones/' name '.json'];
        copyfile(['../paramsFiles/prototypes/prime' stimulus 'Long.json'],filename)
        newFileStrReplaceSpecial(filename, filename, '"blank_before_prime_duration": 500,', ['"blank_before_prime_duration": 500,\n\t"prime_duration":' num2str(levelsCombine(j, 1)) ',\n\t"ISI":' num2str(levelsCombine(j, 3)) ',\n\t"target_duration":' num2str(levelsCombine(j, 2)) ',']);
        newFileStrReplaceSpecial(filename, filename, ['"dbTableName":"prime' stimulus 'Long",'], ['"dbTableName":"' name '",']);
        newFileStrReplaceSpecial(filename, filename, ['"stimulusSeq":"parameters/sequences/prime' stimulus 'Long_target.txt",'], ['"stimulusSeq":"parameters/sequences/target_seq_' name '.txt",']);
        newFileStrReplaceSpecial(filename, filename, ['"primeSeq":"parameters/sequences/prime' stimulus 'Long_prime.txt",'], ['"primeSeq":"parameters/sequences/prime_seq_' name '.txt",']);
    end
end


%%CREATE JS FILE CLONES
for i = 1:length(stimuli)
    stimulus = stimuli{i};
    for j = 1:length(levelsCombine)
        name = [fieldNames{1} num2str(levelsCombine(j, 1)) fieldNames{2} num2str(levelsCombine(j, 2)) fieldNames{3} num2str(levelsCombine(j, 3)) stimulus '_Mask'];
        jsfilename = ['../jsFiles/clones/' name '.js'];
        copyfile(['../jsFiles/prototypes/prime' stimulus 'Long.js'],jsfilename);
        jsReplaceByFileName(['prime' stimulus 'Long'])
    end
end

gen4in1seqs(numTrialsPerseq);

%%Generate drop and create table syntax 
cd ..
cd textGen
oldLevelsCombine =  genA_T_ISI_combin(oldAdapterLevels, oldIsiLevels, oldTargetLevels);
f = fopen('switchTables.txt', 'a');
% Drop old tables
for i = 1:length(stimuli)
    stimulus = stimuli{i};
    for j = 1:length(oldLevelsCombine)
        name = [fieldNames{1} num2str(oldLevelsCombine(j, 1)) fieldNames{2} num2str(oldLevelsCombine(j, 2)) fieldNames{3} num2str(oldLevelsCombine(j, 3)) stimulus '_Mask'];
        fwrite(f, ['drop table ' name ';']);
    end
end
% Make new tables
for i = 1:length(stimuli)
    stimulus = stimuli{i};
    for j = 1:length(levelsCombine)
        name = [fieldNames{1} num2str(levelsCombine(j, 1)) fieldNames{2} num2str(levelsCombine(j, 2)) fieldNames{3} num2str(levelsCombine(j, 3)) stimulus '_Mask'];
        fwrite(f, ['CREATE TABLE `' name '` (`userID` int(11) NOT NULL,`responseGiven` int(11) DEFAULT NULL,`reactionTime` int(11) DEFAULT NULL,`correctResp` int(11) DEFAULT NULL,`primeShift` int(11) DEFAULT NULL,`trialNum` int(11) DEFAULT NULL,`blank0_duration` int(11) DEFAULT NULL,`prime_duration` int(11) DEFAULT NULL,`blank1_duration` int(11) DEFAULT NULL,`target_duration` int(11) DEFAULT NULL,`blank2_duration` int(11) DEFAULT NULL,`mask_duration` int(11) DEFAULT NULL,`blank3_duration` int(11) DEFAULT NULL,`accuracyScore` decimal(11,3) DEFAULT NULL) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;']);
    end
end

fclose(f);

% Create protocolList 
f = fopen('protocols.txt', 'a');
for i = 1:length(stimuli)
    stimulus = stimuli{i};
    for j = 1:length(levelsCombine)
        name = [fieldNames{1} num2str(levelsCombine(j, 1)) fieldNames{2} num2str(levelsCombine(j, 2)) fieldNames{3} num2str(levelsCombine(j, 3)) stimulus '_Mask'];
        fprintf(f, ['\t{\n\t\t"name":"' name '",\n\t\t"paramsFile":"parameters/protocols/' name '.json",\n\t\t"jsFile":"js/protocols/' name '.js",\n\t\t"shuffle":1\n\t},\n']);
    end
end
fclose(f);

cd ..
cd code




