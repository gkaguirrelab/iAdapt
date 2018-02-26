function [ errorPrintout ] = getErrorPrintout(inderrors, toterrors)


elmts = fieldnames(toterrors);
errorPrintout = struct;
for i = 1:length(elmts)
    distrcell = {};
    distrcell{1, 1} = 'userID';
    distrcell{1, 2} = 'userMean';
    distrcell{1, 3} = 'userStdv';
    distrcell{1, 4} = 'totalMean';
    distrcell{1, 5} = 'totalStdv';
    experElmts = fieldnames(inderrors.(elmts{i}));
    for j = 1:length(experElmts)
        distrcell{(j + 1),1} = experElmts{j};
        distrcell{(j + 1),2} = inderrors.(elmts{i}).(experElmts{j}).mean;
        distrcell{(j + 1),3} = inderrors.(elmts{i}).(experElmts{j}).stdv;
        distrcell{(j + 1),4} = toterrors.(elmts{i}).mean;
        distrcell{(j + 1),5} = toterrors.(elmts{i}).stdv;
    end
    errorPrintout.(elmts{i}) = distrcell;
end




