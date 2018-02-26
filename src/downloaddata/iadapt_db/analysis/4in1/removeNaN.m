function [nanRemoved] = removeNaN(structures)
% Removes corresponding rows (where any column in that row contains at least one NaN value) 
% from the equally-sized 2d data structures contained in the given cell array

structures = horzcat(structures{:});
structures = structures(~any(isnan(structures), 2), :);
nanRemoved = {};
theSize = size(structures);
for i = 1:theSize(2)
    nanRemoved{i} = structures(:, i);
end