function makeFig(x_str,y_str,datafile)

load(datafile);

x = eval(x_str);
y = eval(y_str);
%a=x_str(regexp(x_str,'\w'));
%b=y_str(regexp(y_str,'\w'));
a=x_str(1:(strfind(x_str, '(')-1));
b=y_str(1:(strfind(y_str, '(')-1));

% Calculate correlations
x_noNaN = x(~any(isnan([x y]),2));
y_noNaN = y(~any(isnan([x y]),2));
[Pearson_r, Pearson_pval] = corr(x_noNaN,y_noNaN,'type','Pearson');
[Spearman_rho, Spearman_pval] = corr(x_noNaN,y_noNaN,'type','Spearman');
[Kendall_tau, Kendall_pval] = corr(x_noNaN,y_noNaN,'type','Kendall');

this_fig=figure;
scatter(x,y,'filled')
axis square

annotation('textbox',...
    [0.25,0.80,0.5,0.10],...
    'String',{...
    ['Pearson r: ' num2str(Pearson_r) ' (p = ' num2str(Pearson_pval) ')'],...
    ['Spearman rho: ' num2str(Spearman_rho) ' (p = ' num2str(Spearman_pval) ')'],...
    ['Kendall tau: ' num2str(Kendall_tau) ' (p = ' num2str(Kendall_pval) ')']},...
    'FontSize',12,...
    'FontName','Arial',...
    'LineWidth',2);
% Adjust axes
orig_axes = axis;
if strcmp(a(end),b(end))
    xymin = min(0,min([x;y]));
    %xymax = max([orig_axes(2),orig_axes(4)]);
    xymax = max([x;y]);
    axis([xymin 1.1*xymax xymin 1.1*xymax]);
else
    xmin = min(0,min(x));
    ymin = min(0,min(y));
    axis([1.1*xmin orig_axes(2) 1.1*ymin orig_axes(4)]);
end
lsline

% Add labels and title
title([a ' vs ' b],'FontSize',18)
xlabel(a,'FontSize',14)
ylabel(b,'FontSize',14)

% Resize the figure window
dimVert_cm = 20;
dimHorz_cm = 20;
set(this_fig, 'units', 'centimeters', 'position', [10 10 dimHorz_cm dimVert_cm])

% Set clipping off
%set(gca, 'Clipping', 'off');
set(this_fig, 'Clipping', 'off');
set(this_fig, 'renderer', 'painters');