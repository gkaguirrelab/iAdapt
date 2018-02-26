outputDir = './indivDiff';
datafile = 'subjFits_101subj_B.mat';
save_figures = false;
if ~exist(outputDir,'dir')
    mkdir(outputDir)
end

%% calibColorP1 vs. calibColorP2
x_str = 'calibColorP(:,1)';
y_str = 'calibColorP(:,2)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;

%% calibFaceP1 vs. calibFaceP2
x_str = 'calibFaceP(:,1)';
y_str = 'calibFaceP(:,2)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;

%% calibColorP3 vs. calibFaceP3
x_str = 'calibColorP(:,3)';
y_str = 'calibFaceP(:,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;

%% workingMemoryColorP1 vs. workingMemoryColorP2
x_str = 'workingMemoryColorP(:,1)';
y_str = 'workingMemoryColorP(:,2)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;

%% workingMemoryFaceP1 vs. workingMemoryFaceP2
x_str = 'workingMemoryFaceP(:,1)';
y_str = 'workingMemoryFaceP(:,2)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;

%% calibColorP3 vs. workingMemoryColorP3
x_str = 'calibColorP(:,3)';
y_str = 'workingMemoryColorP(:,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;

%% calibFaceP3 vs. workingMemoryFaceP3
x_str = 'calibFaceP(:,3)';
y_str = 'workingMemoryFaceP(:,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;

%% workingMemoryColorP3 vs. workingMemoryFaceP3
x_str = 'workingMemoryColorP(:,3)';
y_str = 'workingMemoryFaceP(:,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;

%% primeColorLongP1 vs. primeColorLongP2
x_str = 'primeColorLongP(:,1)';
y_str = 'primeColorLongP(:,2)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;

%% primeFaceLongP1 vs. primeFaceLongP2
x_str = 'primeFaceLongP(:,1)';
y_str = 'primeFaceLongP(:,2)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;

%% calibColorP3 vs. primeColorLongP3
x_str = 'calibColorP(:,3)';
y_str = 'primeColorLongP(:,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;

%% calibFaceP3 vs. primeFaceLongP3
x_str = 'calibFaceP(:,3)';
y_str = 'primeFaceLongP(:,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;

%% primeColorLongP3 vs. primeFaceLongP3
x_str = 'primeColorLongP(:,3)';
y_str = 'primeFaceLongP(:,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;

%% primeColorLongB1 vs. primeColorLongB2
x_str = 'primeColorLongB(:,1)';
y_str = 'primeColorLongB(:,2)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;

%% primeFaceLongB1 vs. primeFaceLongB2
x_str = 'primeFaceLongB(:,1)';
y_str = 'primeFaceLongB(:,2)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;

%% primeColorLongP3 vs. primeColorLongB3
x_str = 'primeColorLongP(:,3)';
y_str = 'primeColorLongB(:,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;

%% primeFaceLongP3 vs. primeFaceLongB3
x_str = 'primeFaceLongP(:,3)';
y_str = 'primeFaceLongB(:,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;

%% primeColorLongB3 vs. primeFaceLongB3
x_str = 'primeColorLongB(:,3)';
y_str = 'primeFaceLongB(:,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;

%% calibColorP3 vs. primeColorLongB3
x_str = 'calibColorP(:,3)';
y_str = 'primeColorLongB(:,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;

%% calibFaceP3 vs. primeFaceLongB3
x_str = 'calibFaceP(:,3)';
y_str = 'primeFaceLongB(:,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;

%% workingMemoryColorP3 vs. primeColorLongB3
x_str = 'workingMemoryColorP(:,3)';
y_str = 'primeColorLongB(:,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;

%% workingMemoryFaceP3 vs. primeFaceLongB3
x_str = 'workingMemoryFaceP(:,3)';
y_str = 'primeFaceLongB(:,3)';
makeFig(x_str,y_str,datafile)
if(save_figures); export_fig(fullfile(outputDir,[x_str(regexp(x_str,'\w')) 'vs' y_str(regexp(y_str,'\w'))]), '-png', '-q101'); end;