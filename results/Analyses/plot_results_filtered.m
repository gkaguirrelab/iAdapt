outputDir = './indivDiff';
datafile = 'subjFits_101subj_B.mat';
save_figures = true;
if ~exist(outputDir,'dir')
    mkdir(outputDir)
end

%% calibColorP1 vs. calibColorP2
x_str = 'calibColorP(subjs2Include,1)';
y_str = 'calibColorP(subjs2Include,2)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(1:(strfind(x_str, '(')-1)) 'vs' y_str(1:(strfind(y_str, '(')-1))]), '-png', '-q101'); end;

%% calibFaceP1 vs. calibFaceP2
x_str = 'calibFaceP(subjs2Include,1)';
y_str = 'calibFaceP(subjs2Include,2)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(1:(strfind(x_str, '(')-1)) 'vs' y_str(1:(strfind(y_str, '(')-1))]), '-png', '-q101'); end;

%% calibColorP3 vs. calibFaceP3
x_str = 'calibColorP(subjs2Include,3)';
y_str = 'calibFaceP(subjs2Include,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(1:(strfind(x_str, '(')-1)) 'vs' y_str(1:(strfind(y_str, '(')-1))]), '-png', '-q101'); end;

%% workingMemoryColorP1 vs. workingMemoryColorP2
x_str = 'workingMemoryColorP(subjs2Include,1)';
y_str = 'workingMemoryColorP(subjs2Include,2)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(1:(strfind(x_str, '(')-1)) 'vs' y_str(1:(strfind(y_str, '(')-1))]), '-png', '-q101'); end;

%% workingMemoryFaceP1 vs. workingMemoryFaceP2
x_str = 'workingMemoryFaceP(subjs2Include,1)';
y_str = 'workingMemoryFaceP(subjs2Include,2)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(1:(strfind(x_str, '(')-1)) 'vs' y_str(1:(strfind(y_str, '(')-1))]), '-png', '-q101'); end;

%% calibColorP3 vs. workingMemoryColorP3
x_str = 'calibColorP(subjs2Include,3)';
y_str = 'workingMemoryColorP(subjs2Include,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(1:(strfind(x_str, '(')-1)) 'vs' y_str(1:(strfind(y_str, '(')-1))]), '-png', '-q101'); end;

%% calibFaceP3 vs. workingMemoryFaceP3
x_str = 'calibFaceP(subjs2Include,3)';
y_str = 'workingMemoryFaceP(subjs2Include,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(1:(strfind(x_str, '(')-1)) 'vs' y_str(1:(strfind(y_str, '(')-1))]), '-png', '-q101'); end;

%% workingMemoryColorP3 vs. workingMemoryFaceP3
x_str = 'workingMemoryColorP(subjs2Include,3)';
y_str = 'workingMemoryFaceP(subjs2Include,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(1:(strfind(x_str, '(')-1)) 'vs' y_str(1:(strfind(y_str, '(')-1))]), '-png', '-q101'); end;

%% primeColorLongP1 vs. primeColorLongP2
x_str = 'primeColorLongP(subjs2Include,1)';
y_str = 'primeColorLongP(subjs2Include,2)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(1:(strfind(x_str, '(')-1)) 'vs' y_str(1:(strfind(y_str, '(')-1))]), '-png', '-q101'); end;

%% primeFaceLongP1 vs. primeFaceLongP2
x_str = 'primeFaceLongP(subjs2Include,1)';
y_str = 'primeFaceLongP(subjs2Include,2)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(1:(strfind(x_str, '(')-1)) 'vs' y_str(1:(strfind(y_str, '(')-1))]), '-png', '-q101'); end;

%% calibColorP3 vs. primeColorLongP3
x_str = 'calibColorP(subjs2Include,3)';
y_str = 'primeColorLongP(subjs2Include,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(1:(strfind(x_str, '(')-1)) 'vs' y_str(1:(strfind(y_str, '(')-1))]), '-png', '-q101'); end;

%% calibFaceP3 vs. primeFaceLongP3
x_str = 'calibFaceP(subjs2Include,3)';
y_str = 'primeFaceLongP(subjs2Include,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(1:(strfind(x_str, '(')-1)) 'vs' y_str(1:(strfind(y_str, '(')-1))]), '-png', '-q101'); end;

%% primeColorLongP3 vs. primeFaceLongP3
x_str = 'primeColorLongP(subjs2Include,3)';
y_str = 'primeFaceLongP(subjs2Include,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(1:(strfind(x_str, '(')-1)) 'vs' y_str(1:(strfind(y_str, '(')-1))]), '-png', '-q101'); end;

%% primeColorLongB1 vs. primeColorLongB2
x_str = 'primeColorLongB(subjs2Include,1)';
y_str = 'primeColorLongB(subjs2Include,2)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(1:(strfind(x_str, '(')-1)) 'vs' y_str(1:(strfind(y_str, '(')-1))]), '-png', '-q101'); end;

%% primeFaceLongB1 vs. primeFaceLongB2
x_str = 'primeFaceLongB(subjs2Include,1)';
y_str = 'primeFaceLongB(subjs2Include,2)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(1:(strfind(x_str, '(')-1)) 'vs' y_str(1:(strfind(y_str, '(')-1))]), '-png', '-q101'); end;

%% primeColorLongP3 vs. primeColorLongB3
x_str = 'primeColorLongP(subjs2Include,3)';
y_str = 'primeColorLongB(subjs2Include,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;

%% primeFaceLongP3 vs. primeFaceLongB3
x_str = 'primeFaceLongP(subjs2Include,3)';
y_str = 'primeFaceLongB(subjs2Include,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;

%% primeColorLongB3 vs. primeFaceLongB3
x_str = 'primeColorLongB(subjs2Include,3)';
y_str = 'primeFaceLongB(subjs2Include,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(1:(strfind(x_str, '(')-1)) 'vs' y_str(1:(strfind(y_str, '(')-1))]), '-png', '-q101'); end;

%% calibColorP3 vs. primeColorLongB3
x_str = 'calibColorP(subjs2Include,3)';
y_str = 'primeColorLongB(subjs2Include,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(1:(strfind(x_str, '(')-1)) 'vs' y_str(1:(strfind(y_str, '(')-1))]), '-png', '-q101'); end;

%% calibFaceP3 vs. primeFaceLongB3
x_str = 'calibFaceP(subjs2Include,3)';
y_str = 'primeFaceLongB(subjs2Include,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(1:(strfind(x_str, '(')-1)) 'vs' y_str(1:(strfind(y_str, '(')-1))]), '-png', '-q101'); end;

%% workingMemoryColorP3 vs. primeColorLongB3
x_str = 'workingMemoryColorP(subjs2Include,3)';
y_str = 'primeColorLongB(subjs2Include,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(1:(strfind(x_str, '(')-1)) 'vs' y_str(1:(strfind(y_str, '(')-1))]), '-png', '-q101'); end;

%% workingMemoryFaceP3 vs. primeFaceLongB3
x_str = 'workingMemoryFaceP(subjs2Include,3)';
y_str = 'primeFaceLongB(subjs2Include,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(1:(strfind(x_str, '(')-1)) 'vs' y_str(1:(strfind(y_str, '(')-1))]), '-png', '-q101'); end;