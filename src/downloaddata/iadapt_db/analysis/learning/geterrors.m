function [indaccuracy, totaccuracy] = geterrors(data)

indaccuracy = struct;
totaccuracy = struct;
elmts = fieldnames(data);
for i = 2:numel(elmts)
    if isfield(data.(elmts{i}), 'stimType') && isfield(data.(elmts{i}), 'responseCharacter')
        truevals = data.(elmts{i}).stimType;
        response = data.(elmts{i}).responseCharacter;
        indaccuracy.(elmts{i}) = struct;
        %Get individual accuracy
        for j = 1:max(data.Users.ID)
            indivTrials = data.(elmts{i}).userID == j;
            %Check that there is data for this user
            if any(indivTrials) == 1
                indivTruevals = truevals(indivTrials);
                indivResponse = response(indivTrials);
                [distribution, mean, stdv]  = errordistr(indivTruevals, indivResponse);
                indaccuracy.(elmts{i}).(['id' num2str(j)]) = struct;
                indaccuracy.(elmts{i}).(['id' num2str(j)]).distr = distribution;
                indaccuracy.(elmts{i}).(['id' num2str(j)]).mean = mean;
                indaccuracy.(elmts{i}).(['id' num2str(j)]).stdv = stdv;
            end
        end
        %Get total accuracy
        [distribution, mean, stdv]  = errordistr(truevals, response);
        totaccuracy.(elmts{i}) = struct;
        totaccuracy.(elmts{i}).distr = distribution;
        totaccuracy.(elmts{i}).mean = mean;
        totaccuracy.(elmts{i}).stdv = stdv;
    end
end
 
