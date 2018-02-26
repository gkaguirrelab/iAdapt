[data, inderrors, toterrors, errorPrintout, params] = analyzeExper('workingMemoryColor',94:125, 119);
[data, inderrors, toterrors, errorPrintout, params] = analyzeExper('workingMemoryFace', 94:125, 119);

% Test whether colors and faces are equally difficult
% [h,p,ci,stats] = vartest2(toterrors.calibColor.distr,toterrors.calibFace.distr)