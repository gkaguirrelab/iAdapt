function [inderrors, toterrors] = geterrors(data)

inderrors = struct;
toterrors = struct;
elmts = fieldnames(data);
for i = 2:numel(elmts)
    if isfield(data.(elmts{i}), 'stimType') && isfield(data.(elmts{i}), 'responseGiven')
        truevals = data.(elmts{i}).stimType;
        response = data.(elmts{i}).responseGiven;
        if ischar(truevals)
            truevals = char2double(truevals);
        elseif iscell(truevals)
            truevals = str2double(truevals);
        end
        if ischar(response)
            response = char2double(response);
        elseif iscell(response)
            response = str2double(response);
        end
        inderrors.(elmts{i}) = struct;
        %Get individual errors
        for j = 1:max(data.Users.ID)
            indivTrials = data.(elmts{i}).userID == j;
            %Check that there is data for this user
            if any(indivTrials) == 1
                indivTruevals = truevals(indivTrials);
                indivResponse = response(indivTrials);
                [distribution, mean, stdv]  = errordistr(indivTruevals, indivResponse);
                inderrors.(elmts{i}).(['id' num2str(j)]) = struct;
                inderrors.(elmts{i}).(['id' num2str(j)]).distr = distribution;
                inderrors.(elmts{i}).(['id' num2str(j)]).mean = mean;
                inderrors.(elmts{i}).(['id' num2str(j)]).stdv = stdv;
            end
        end
        %Get total errors
        [distribution, mean, stdv]  = errordistr(truevals, response);
        toterrors.(elmts{i}) = struct;
        toterrors.(elmts{i}).distr = distribution;
        toterrors.(elmts{i}).mean = mean;
        toterrors.(elmts{i}).stdv = stdv;
    end
end
 
