%% LOAD DATA 
% First batch
load('color1analysis.mat')
adaptBias = adapt_BTable;
adaptPrecision = adapt_PTable;
% Second batch
load('color2analysis.mat')
adaptBias = [adaptBias; adapt_BTable];
adaptPrecision = [adaptPrecision; adapt_PTable];

%% CALCULATE CORRELATIONS
% Correlations per run
[rho,pval] = corrcoef(adaptBias(:),adaptPrecision(:),'rows','pairwise');
display(sprintf('The Pearson correlation between bias and precision per run is %.2f (p = %.4f)',rho(1,2),pval(1,2)));
[rho,pval] = corr(adaptBias(:),adaptPrecision(:),'type','Spearman');
display(sprintf('The Spearman correlation between bias and precision per run is %.2f (p = %.4f)',rho,pval));

% Scatter plot
scatter(adaptBias(:),adaptPrecision(:)); lsline
xlabel('BIAS (degrees)');
ylabel('PRECISION (degrees^{-1})');

% Average data for each subject
[rho,pval] = corrcoef(nanmean(adaptBias,2),nanmean(adaptPrecision,2),'rows','pairwise');
display(sprintf('The Pearson correlation between bias and precision per subject is %.2f (p = %.4f)',rho(1,2),pval(1,2)));