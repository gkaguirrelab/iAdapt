% CALIBCOLOR
figure(1);
maximize(figure(1));
for s=1:numSubj
    thisSubj = subjIDs{s};
    subplot(11,10,s);
    targets = [data.(thisSubj).calibColor.targetVal;data.(thisSubj).calibColor2.targetVal];
    responses = [data.(thisSubj).calibColor.responseVal;data.(thisSubj).calibColor2.responseVal];
    calibColor_R2(s) = plotMixModelFit(targets,responses);
end
export_fig('calibColor_fits', '-png', '-q101');

% CALIBFACE
figure(2);
maximize(figure(2));
for s=1:numSubj
    thisSubj = subjIDs{s};
    subplot(11,10,s);
    targets = [data.(thisSubj).calibFace.targetVal;data.(thisSubj).calibFace2.targetVal];
    responses = [data.(thisSubj).calibFace.responseVal;data.(thisSubj).calibFace2.responseVal];
    calibFace_R2(s) = plotMixModelFit(targets,responses);
end
export_fig('calibFace_fits', '-png', '-q101');

% WMCOLOR
figure(3);
maximize(figure(3));
for s=1:numSubj
    thisSubj = subjIDs{s};
    subplot(11,10,s);
    targets = [data.(thisSubj).workingMemoryColor.targetVal;data.(thisSubj).workingMemoryColor2.targetVal];
    responses = [data.(thisSubj).workingMemoryColor.responseVal;data.(thisSubj).workingMemoryColor2.responseVal];
    workingMemoryColor_R2(s) = plotMixModelFit(targets,responses);
end
export_fig('wmColor_fits', '-png', '-q101');

% WMFACE
figure(4);
maximize(figure(4));
for s=1:numSubj
    thisSubj = subjIDs{s};
    subplot(11,10,s);
    targets = [data.(thisSubj).workingMemoryFace.targetVal;data.(thisSubj).workingMemoryFace2.targetVal];
    responses = [data.(thisSubj).workingMemoryFace.responseVal;data.(thisSubj).workingMemoryFace2.responseVal];
    workingMemoryFace_R2(s) = plotMixModelFit(targets,responses);
end
export_fig('wmFace_fits', '-png', '-q101');

% ADAPTCOLOR
figure(5);
maximize(figure(5));
for s=1:numSubj
    thisSubj = subjIDs{s};
    subplot(11,10,s);
    targets = [data.(thisSubj).primeColorLong.targetVal;data.(thisSubj).primeColorLong2.targetVal];
    responses = [data.(thisSubj).primeColorLong.responseVal;data.(thisSubj).primeColorLong2.responseVal];
    adaptorOffset = [data.(thisSubj).primeColorLong.adaptor;data.(thisSubj).primeColorLong2.adaptor];
    bias = primeColorLongB(s,3);
    primeColorLong_R2(s) = plotMixModelFit(targets,responses,adaptorOffset,bias);
end
export_fig('adaptColor_fits', '-png', '-q101');

% ADAPTFACE
figure(6);
maximize(figure(6));
for s=1:numSubj
    thisSubj = subjIDs{s};
    subplot(11,10,s);
    targets = [data.(thisSubj).primeFaceLong.targetVal;data.(thisSubj).primeFaceLong2.targetVal];
    responses = [data.(thisSubj).primeFaceLong.responseVal;data.(thisSubj).primeFaceLong2.responseVal];
    adaptorOffset = [data.(thisSubj).primeFaceLong.adaptor;data.(thisSubj).primeFaceLong2.adaptor];
    bias = primeFaceLongB(s,3);
    primeFaceLong_R2(s) = plotMixModelFit(targets,responses,adaptorOffset,bias);
end
export_fig('adaptFace_fits', '-png', '-q101');