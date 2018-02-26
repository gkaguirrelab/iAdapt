function [ distribution, mean, stdv ] = errordist( truevals, chosenvals )

distribution = arrayfun(@circdist, truevals, chosenvals);
mean = nanmean(distribution);
stdv = nanstd(distribution);
