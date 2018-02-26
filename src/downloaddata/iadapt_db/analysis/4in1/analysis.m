[data, inderrors, toterrors, errorPrintout, params] = analyzeExper('calibColor',94:125, 119, 'iadapt_08-Jul-2014 12_28_40');
[data, inderrors, toterrors, errorPrintout, params] = analyzeExper('calibFace', 94:125, 119., 'iadapt_08-Jul-2014 12_28_40');

% Test whether colors and faces are equally difficult
% [h,p,ci,stats] = vartest2(toterrors.calibColor.distr,toterrors.calibFace.distr)