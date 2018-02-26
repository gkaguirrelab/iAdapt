load('subjFits_101subj_B.mat')
allLLfits = [calibColor_fitLL(:,3) calibFace_fitLL(:,3) workingMemoryColor_fitLL(:,3) workingMemoryFace_fitLL(:,3) primeColorLong_fitLL(:,3) primeFaceLong_fitLL(:,3)];
subjs2Include = and(incompleteSessions==0,all(allLLfits>-50,2));

% Visualize the distributions of precision
hist(calibColorP(subjs2Include,3),20)
hist(calibFaceP(subjs2Include,3),20)
scatterhist(calibColorP(subjs2Include,3),calibFaceP(subjs2Include,3),'NBins',[20,20],'Marker','.','MarkerSize',20)