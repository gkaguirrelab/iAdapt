function [ distance ] = circdist(deg1, deg2)

if isnan(deg1) ||  isnan(deg2)
    distance = NaN;
else
    distance = min(scaleDegree(deg1 - deg2), scaleDegree(deg2 - deg1));
    if scaleDegree(deg1 - distance) == deg2
        distance = distance * -1;
    end
end
