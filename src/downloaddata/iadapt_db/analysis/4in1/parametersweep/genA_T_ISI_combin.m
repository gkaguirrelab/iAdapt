function combinations = genA_T_ISI_combin(targetLevels, isiLevels, adapterLevels)

if nargin < 3
    [gridTarget, gridISI] = meshgrid(targetLevels, isiLevels);
    combinations = [gridTarget(:) gridISI(:)];
else
    [gridAdapt, gridTarget, gridISI] = meshgrid(adapterLevels,targetLevels, isiLevels);
    combinations = [gridAdapt(:) gridTarget(:) gridISI(:)];
end

