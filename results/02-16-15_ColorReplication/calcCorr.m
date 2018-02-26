%% CALCULATE CORRELATIONS BASED ON INDIVIDUAL DIFFERENCES
[rho,pval] = corrcoef(adaptColorB(:,7),adaptColorP(:,7),'rows','pairwise');
display(sprintf('The Pearson correlation between bias and precision per subject is %.2f (p = %.4f)',rho(1,2),pval(1,2)));

%% CALCULATE CORRELATIONS BASED ON STATE/BLOCK
[rho,pval] = corrcoef(reshape(adaptColorB(:,1:6),size(adaptColorB,1)*6,1),reshape(adaptColorP(:,1:6),size(adaptColorP,1)*6,1),'rows','pairwise');
display(sprintf('The Pearson correlation between bias and precision per block is %.2f (p = %.4f)',rho(1,2),pval(1,2)));

%% CALCULATE RESIDUALS
BIAS_Runs_no_Subj = nan(size(adaptColorB,1),6);
PREC_Runs_no_Subj = nan(size(adaptColorP,1),6);
for i=1:6
    [~,~,BIAS_Runs_no_Subj(:,i),~,~] = regress(adaptColorB(:,i),[ones(size(adaptColorB(:,7))) adaptColorB(:,7)]);
    [~,~,PREC_Runs_no_Subj(:,i),~,~] = regress(adaptColorP(:,i),[ones(size(adaptColorP(:,7))) adaptColorP(:,7)]);
end
[~,~,BIAS_Subj_no_Runs,~,~] = regress(adaptColorB(:,7),[ones(size(adaptColorB,1),1) adaptColorB(:,1:6)]);
[~,~,PREC_Subj_no_Runs,~,~] = regress(adaptColorP(:,7),[ones(size(adaptColorP,1),1) adaptColorP(:,1:6)]);

%% CALCULATE VARIANCE EXPLAINED
%{
[rho,pval] = corrcoef(adaptColorB(:,7),adaptColorP(:,7),'rows','pairwise');
display(sprintf('SUBJECT explains %.2f%% of the variance',100*rho(1,2)^2));
[rho,pval] = corrcoef(BIAS_Subj_no_Runs,PREC_Subj_no_Runs,'rows','pairwise');
display(sprintf('SUBJECT (regressing out run info) explains %.2f%% of the variance',100*rho(1,2)^2));

[rho,pval] = corrcoef(reshape(adaptColorB(:,1:6),size(adaptColorB,1)*6,1),reshape(adaptColorP(:,1:6),size(adaptColorP,1)*6,1),'rows','pairwise');
display(sprintf('RUN explains %.2f%% of the variance',100*rho(1,2)^2));
[rho,pval] = corrcoef(BIAS_Runs_no_Subj(:),PREC_Runs_no_Subj(:),'rows','pairwise');
display(sprintf('RUN (regressing out subject info) explains %.2f%% of the variance',100*rho(1,2)^2));
%}

[rho,pval] = corrcoef(adaptColorP(:,7),adaptColorB(:,7),'rows','pairwise');
display(sprintf('Subject precision explains %.2f%% of the bias variance',100*rho(1,2)^2));
[rho,pval] = corrcoef(PREC_Subj_no_Runs,adaptColorB(:,7),'rows','pairwise');
display(sprintf('Subject precision without run-to-run variability explains %.2f%% of the bias variance',100*rho(1,2)^2));
[rho,pval] = corrcoef(reshape(adaptColorP(:,1:6),size(adaptColorP,1)*6,1),reshape(adaptColorB(:,1:6),size(adaptColorB,1)*6,1),'rows','pairwise');
display(sprintf('Run-to-run precision explains %.2f%% of the bias variance',100*rho(1,2)^2));
[rho,pval] = corrcoef(PREC_Runs_no_Subj,reshape(adaptColorB(:,1:6),size(adaptColorB,1)*6,1),'rows','pairwise');
display(sprintf('Run-to-run precision without subject variability explains %.2f%% of the bias variance',100*rho(1,2)^2));

%% USE REGRESSION APPROACH TO PREDICT RUN-TO-RUN BIAS
display(sprintf(' '));
display(sprintf('REGRESSION APPROACH:'));
Y = reshape(adaptColorB(:,1:6),numel(adaptColorB(:,1:6)),1);
X1 = reshape(adaptColorP(:,1:6),numel(adaptColorP(:,1:6)),1);
X2 = repmat(adaptColorP(:,7),6,1);
[B,BINT,R,RINT,STATS] = regress(Y,[ones(size(X1)) X1 X2]);
varExpX1 = var(B(2)*X1)/var(Y);
varExpX2 = var(B(3)*X1)/var(Y);
display(sprintf('Run-to-run precision explains %.2f%% of the run-to-run bias variance',100*varExpX1));
display(sprintf('Subject precision explains %.2f%% of the run-to-run bias variance',100*varExpX2));


%% USE REGRESSION APPROACH TO PREDICT SUBJECT BIAS
Y = repmat(adaptColorB(:,7),6,1);
X1 = reshape(adaptColorP(:,1:6),numel(adaptColorP(:,1:6)),1);
X2 = repmat(adaptColorP(:,7),6,1);
[B,BINT,R,RINT,STATS] = regress(Y,[ones(size(X1)) X1 X2]);
varExpX1 = var(B(2)*X1)/var(Y);
varExpX2 = var(B(3)*X1)/var(Y);
display(sprintf('Run-to-run precision explains %.2f%% of the subject bias variance',100*varExpX1));
display(sprintf('Subject precision explains %.2f%% of the subject bias variance',100*varExpX2));