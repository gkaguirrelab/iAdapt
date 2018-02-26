load('subjFits_101subj_B.mat')
load('subjIDs_completesessions_r2greaterthan05_B.mat')

Y = nan(numSubj*6,1);
X = zeros(numSubj*6,numSubj*4);
covLabels = blanks(numSubj*4);

% Response vector
for s=1:numSubj
    Y((s*6 - 5):(s*6)) = [calibColorP(s,3);calibFaceP(s,3);workingMemoryColorP(s,3);workingMemoryFaceP(s,3);primeColorLongP(s,3);primeFaceLongP(s,3)];
end

% Intercept term
X(:,1) = ones(numSubj*6,1);
covLabels(1,1) = 'i';

% Subject effect
for s=1:(numSubj-1)
    X((s*6 - 5):(s*6),s+1) = ones(6,1);
    covLabels(1,s+1) = 's';
end

% Material effect (color=1, face=-1)
covLabels(1,find(~any(X),1,'first')) = 'a';
X(:,find(~any(X),1,'first')) = repmat([1;-1],numSubj*3,1);

% Measurement effect
covLabels(1,find(~any(X),1,'first')) = '1';
X(:,find(~any(X),1,'first')) = repmat([1;1;-0.5;-0.5;-0.5;-0.5],numSubj,1);
covLabels(1,find(~any(X),1,'first')) = '1';
X(:,find(~any(X),1,'first')) = repmat([-0.5;-0.5;-0.5;-0.5;1;1],numSubj,1);

% Subject-material interaction
idx=find(~any(X),1,'first');
X(:,idx:(idx+numSubj-2)) = X(:,2:numSubj) .* repmat(repmat([1;-1],numSubj*3,1),1,(numSubj-1));
covLabels(1,idx:(idx+numSubj-2)) = 'x';

% Subject-measurement interaction
idx=find(~any(X),1,'first');
X(:,idx:(idx+numSubj-2)) = X(:,2:numSubj) .* repmat(repmat([1;1;-0.5;-0.5;-0.5;-0.5],numSubj,1),1,(numSubj-1));
covLabels(1,idx:(idx+numSubj-2)) = '3';
idx=find(~any(X),1,'first');
X(:,idx:(idx+numSubj-2)) = X(:,2:numSubj) .* repmat(repmat([-0.5;-0.5;-0.5;-0.5;1;1],numSubj,1),1,(numSubj-1));
covLabels(1,idx:(idx+numSubj-2)) = '3';

%% RUN F-TESTS

% Create the full regression model
[bhat, bint, R, Rint, stats] = regress(Y,X);
F_full = stats(2);
p_full = stats(3);

% Create reduced regression model for subject effect
[bhat, bint, R, Rint, stats] = regress(Y,[ones(numSubj*6,1), X(:,covLabels=='s')]);
F_subj = stats(2);
p_subj = stats(3);

% Create reduced regression model for material effect
[bhat, bint, R, Rint, stats] = regress(Y,[ones(numSubj*6,1), X(:,covLabels=='a')]);
F_mat = stats(2);
p_mat = stats(3);

% Create reduced regression model for measurement effect
[bhat, bint, R, Rint, stats] = regress(Y,[ones(numSubj*6,1), X(:,or(covLabels=='1',covLabels=='2'))]);
F_meas = stats(2);
p_meas = stats(3);

% Create reduced regression model for subject-material interaction
[bhat, bint, R, Rint, stats] = regress(Y,[ones(numSubj*6,1), X(:,covLabels=='x')]);
F_subj_mat = stats(2);
p_subj_mat = stats(3);

% Create reduced regression model for subject-measurement interaction
[bhat, bint, R, Rint, stats] = regress(Y,[ones(numSubj*6,1), X(:,or(covLabels=='3',covLabels=='4'))]);
F_subj_meas = stats(2);
p_subj_meas = stats(3);

%[p_full,p_subj,p_mat,p_meas,p_subj_mat,p_subj_meas]


labelToTest = 's';
% SSE full model
[~, ~, R, ~, ~] = regress(Y,X);
SSE = nansum(R.^2);
% SSE reduced model
[~, ~, Rred, ~, ~] = regress(Y,X(:,~(covLabels==labelToTest)));
SSER = nansum(Rred.^2);
% Calculate F value
Fval = (  (SSER-SSE)/(sum(covLabels==labelToTest))  )  /  (  SSE/(size(X,1)-size(X,2)-1)  );
Pval = 1-fcdf(Fval,sum(covLabels==labelToTest),size(X,1)-size(X,2)-1)

% Remember than when I remove material, for example, I must also remove the
% interactions involving material from the model.
%interaction: p=7.5937e-05
%subject: p=1.2346e-05
%material: p=1.5239e-09
%subject-material: p=0.9888
%measurement: 4.4800e-04
%subject-measurement: p=1.0


%% BIAS EFFECT
subjPrecision_color = mean([calibColorP(:,3),workingMemoryColorP(:,3),primeColorLongP(:,3)],2);
subjBias_color = primeColorLongB(:,3);
[bhat, bint, R, Rint, stats] = regress(subjBias_color,[ones(numSubj,1), subjPrecision_color]);
F_subj_PonB = stats(2);
p_subj_PonB = stats(3);


subjPrecision_face = mean([calibFaceP(:,3),workingMemoryFaceP(:,3),primeFaceLongP(:,3)],2);
subjBias_face = primeFaceLongB(:,3);
[bhat, bint, R, Rint, stats] = regress(subjBias_face,[ones(numSubj,1), subjPrecision_face]);
F_subj_PonB = stats(2);
p_subj_PonB = stats(3);



%% MAIN ANALYSES USED
colorP1=calibColorP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3);
colorP2=workingMemoryColorP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3);
colorP3=primeColorLongP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3);
faceP1=calibFaceP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3);
faceP2=workingMemoryFaceP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3);
faceP3=primeFaceLongP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3);
colorB=primeColorLongB(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3);
faceB=primeFaceLongB(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3);

meanP=nanmean([calibColorP(:,3),calibFaceP(:,3),workingMemoryColorP(:,3),workingMemoryFaceP(:,3),primeColorLongP(:,3),primeFaceLongP(:,3)],2);
meanB=nanmean([primeColorLongB(:,3),primeFaceLongB(:,3)],2);
[rho,pval]=corr(meanP,meanB)
[rho,pval]=corr(meanP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05)),meanB(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05)))

meanP1=nanmean([calibColorP(:,1),calibFaceP(:,1),workingMemoryColorP(:,1),workingMemoryFaceP(:,1),primeColorLongP(:,1),primeFaceLongP(:,1)],2);
meanP2=nanmean([calibColorP(:,2),calibFaceP(:,2),workingMemoryColorP(:,2),workingMemoryFaceP(:,2),primeColorLongP(:,2),primeFaceLongP(:,2)],2);
[rho,pval]=corr(meanP1(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05)),meanP2(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05)))


meanPc=nanmean([calibColorP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3),workingMemoryColorP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3),primeColorLongP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3)],2);
meanPf=nanmean([calibFaceP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3),workingMemoryFaceP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3),primeFaceLongP(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3)],2);
meanBc=nanmean([primeColorLongB(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3)],2);
meanBf=nanmean([primeFaceLongB(ismember(subjIDs,subjIDs_completesessions_r2greaterthan05),3)],2);
[rho,pval]=corr(mean([meanPc,meanPf],2),mean([meanBc,meanBf],2))
[rho,pval]=corr(meanBc,meanBf)
% Regressing out precision from bias
[~,~,resBc] = regress(meanBc,meanPc);
[~,~,resBf] = regress(meanBf,meanPf);
[rho,pval]=corr(resBc,resBf)




allLLfits = [calibColor_fitLL(:,3) calibFace_fitLL(:,3) workingMemoryColor_fitLL(:,3) workingMemoryFace_fitLL(:,3) primeColorLong_fitLL(:,3) primeFaceLong_fitLL(:,3)];
subjs2Include = and(incompleteSessions==0,all(allLLfits>-50,2));

