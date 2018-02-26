function combinations = genA_T_ISI_combin(adapterLevels, isiLevels, targetLevels)

[gridAdapt, gridTarget, gridISI] = meshgrid(adapterLevels,targetLevels, isiLevels);
combinations = [gridAdapt(:) gridTarget(:) gridISI(:)];