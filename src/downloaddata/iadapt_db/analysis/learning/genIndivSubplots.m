function genIndivSubplots( errors, graphFunc, ylimits )
% Generates a display of subplots, created by using the graphFunc, containing 
% indiividual errors from the given experiment. ylimits is an optional
% parameter that formats the plots' axes

fields = fieldnames(errors);
% Determine dimensions for subplot
dimension = ceil(sqrt(length(fields)));
% Generate subplots
for i = 1:length(fields)
    subplot(dimension, dimension, i);
    graphFunc(errors.(fields{i}).distr);
    if nargin == 3
        ylim(ylimits);
    end
end



