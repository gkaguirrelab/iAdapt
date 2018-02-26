% Load the data
load('../../Data/D_facesOnly_94subj_highSaturation.mat');
load('../../Data/E_colorsOnly_98subj_highSaturation.mat');

corrPB_color = nan(size(adaptColorB,1),1);
for s=1:size(adaptColorB,1)
    corrPB_color(s) = fisherz(corr(adaptColorP(s,1:6)',adaptColorB(s,1:6)','type','Spearman'));
end
corrPB_face = nan(size(adaptFaceB,1),1);
for s=1:size(adaptFaceB,1)
    corrPB_face(s) = fisherz(corr(adaptFaceP(s,1:6)',adaptFaceB(s,1:6)','type','Spearman'));
end






corrPB_face = nan(numSubj,1);