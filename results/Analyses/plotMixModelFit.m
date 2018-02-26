function R2 = plotMixModelFit(targets,responses,adaptorOffset,bias)
    
xaxis = -pi:0.01:pi;

if nargin<3
    targetVal=wrap(deg2rad(targets));
    respVal=wrap(deg2rad(responses));
    errorVal = wrap(respVal-targetVal);
    % Calculate fit
    [B, LL] = JV10_fit(errorVal,zeros(size(errorVal)));
    K=B(1);
    pT=B(2);
    pN=B(3);
    pU=B(4);
    vonmises_component = pT * vonmisespdf(xaxis,0,K)/sum(vonmisespdf(xaxis,0,K));
    uniform_component = pU * ones(size(xaxis))/sum(ones(size(xaxis)));
    fullfit = vonmises_component + uniform_component;

    % Create the histogram
    [f,x]=hist(rad2deg(errorVal),-180:5:180);
    
elseif nargin==4
    targetVal=wrap(deg2rad(targets));
    respVal=wrap(deg2rad(responses));
    errorVal = wrap(respVal-targetVal);
    errorCorrected = nan(size(errorVal));
    errorCorrected(adaptorOffset<0) = errorVal(adaptorOffset<0);
    errorCorrected(adaptorOffset>0) = -errorVal(adaptorOffset>0);
    % Calculate fit
    [B, LL] = JV10_fit(errorCorrected, deg2rad(ones(size(errorCorrected))*bias), deg2rad(ones(size(errorCorrected))*(-45)));
    K=B(1);
    pT=B(2);
    pN=B(3);
    pU=B(4);
    vonmises_component = pT * vonmisespdf(xaxis,deg2rad(bias),K)/sum(vonmisespdf(xaxis,deg2rad(bias),K));
    uniform_component = pU * ones(size(xaxis))/sum(ones(size(xaxis)));
    nontarget_component = pN * vonmisespdf(xaxis,deg2rad(-45),K)/sum(vonmisespdf(xaxis,deg2rad(-45),K));
    fullfit = vonmises_component + uniform_component + nontarget_component;

    % Create the histogram
    [f,x]=hist(rad2deg(errorCorrected),-180:5:180);
end


% Plot histogram
dx = diff(x(1:2));
bar(x,f/sum(f*dx));
hold on
plot(rad2deg(xaxis),fullfit/trapz(rad2deg(xaxis),fullfit),'r');
hold off

% Calculate fit prediction at each bin
y=fullfit/trapz(rad2deg(xaxis),fullfit);
fit_prediction = nan(size(f));
for i=1:length(x)
    [~,I] = min(abs(rad2deg(xaxis)-x(i)));
    fit_prediction(i) = y(I);
end
R2 = corr2(f,fit_prediction)^2;

axis([-90 90 0 max(f/trapz(x,f))]);
xlabel('Degrees','FontSize',14)
ylabel('Errors','FontSize',14)
%title(['Fit LL: ' num2str(LL) '; Fit R2: ' num2str(corr2(f,fit_prediction)^2)],'FontSize',18)
title(['Fit R2: ' num2str(R2)],'FontSize',18)
%title(['Fit LL: ' num2str(LL)],'FontSize',18)


%% Calculate the Kolmogorov-Smirnov Goodness-of-Fit Test
%{
if ~isinf(LL)
    xaxis_deg = rad2deg(xaxis);
    error_deg = rad2deg(errorVal);
    pfd_fit = fullfit/trapz(xaxis_deg,fullfit);
    cdfval = nan(size(error_deg));
    for i=1:length(error_deg)
        % Find the index of the closest point
        [~,I] = min(abs(xaxis_deg-error_deg(i)));
        % Find the cdf value at that point
        cdfval(i) = trapz(xaxis_deg(1:I),pfd_fit(1:I));
    end
    [kstest_h,kstest_p] = kstest(error_deg,'CDF',[error_deg,cdfval]);
    %title(['KS-test p: ' sprintf('%2.3f',kstest_p)],'FontSize',18);
    
    % Color the bars in red if test rejects the null hypothesis
    if kstest_h
        dx = diff(x(1:2));
        bar(x,f/sum(f*dx),'r');
        hold on
        plot(rad2deg(xaxis),fullfit/trapz(rad2deg(xaxis),fullfit),'k');
        hold off
        axis([-90 90 0 max(f/trapz(x,f))]);
        xlabel('Degrees','FontSize',14)
        ylabel('Errors','FontSize',14)
        %title(['KS-test p: ' sprintf('%2.3f',kstest_p)],'FontSize',18);
        title(['Fit LL: ' num2str(LL)],'FontSize',18);
    end
else
    dx = diff(x(1:2));
    bar(x,f/sum(f*dx),'r');
    hold on
    plot(rad2deg(xaxis),fullfit/trapz(rad2deg(xaxis),fullfit),'k');
    hold off
    axis([-90 90 0 max(f/trapz(x,f))]);
    xlabel('Degrees','FontSize',14)
    ylabel('Errors','FontSize',14)
    title(['Fit LL: ' num2str(LL)],'FontSize',18);
end
%}
