function [P, fitLL] = extractFits(targets1,resps1,targets2,resps2)
% Inputs should all be in degrees

P = nan(1,3);
fitLL = nan(1,3);

% First block
targetVal=wrap(targets1*pi/180);
respVal=wrap(resps1*pi/180);
[B, LL] = JV10_fit(respVal,targetVal);
P(1) = 1/k2sd(B(1));
fitLL(1) = LL;

% Second block
targetVal=wrap(targets2*pi/180);
respVal=wrap(resps2*pi/180);
[B, LL] = JV10_fit(respVal,targetVal);
P(2) = 1/k2sd(B(1));
fitLL(2) = LL;

% Combined blocks
targetVal=[wrap(targets1*pi/180); wrap(targets2*pi/180)];
respVal=[wrap(resps1*pi/180); wrap(resps2*pi/180)];
[B, LL] = JV10_fit(respVal,targetVal);
P(3) = 1/k2sd(B(1));
fitLL(3) = LL;