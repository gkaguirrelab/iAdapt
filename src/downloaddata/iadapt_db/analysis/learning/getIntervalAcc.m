function [distr] = getIntervalAcc (theOnes,respVals, actVals, interval)
numIntervals = length(actVals)/interval;
distr = struct;
for i = 1:interval:numIntervals
   distr.(['T' num2str((i - 1)*interval + 1) '_' 'T' num2str(i*interval)]) = getAccuracy(theOnes,respVals(((i - 1)*interval + 1):(i*interval)), actVals(((i - 1)*interval + 1):(i*interval))); 
end

