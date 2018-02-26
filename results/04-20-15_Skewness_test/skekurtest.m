function [skekurtest] = skekurtest(X,d,alpha)
% Hypotheses test concerning skewness and kurtosis.
%(This file consider both the g statistic and the beta estimates measures.)
%
%   Syntax: function [skekurtest] = skekurtest(X,d,alpha) 
%      
%     Inputs:
%          X - data vector. 
%          d - direction of tests (1 = one-tailed; 2 = two-tailed)[default = 2].
%       alpha - significance level (default = 0.05).
%
%     Outputs:
%            For an one-tailed hypothesis (d = 1)
%          - Whether or not the skewness to left or rigth were met.
%          - Whether or not the kurtosis to left or rigth were met.
%            For a two-tailed hypothesis (d = 2)
%          - Whether or not the skewness and kurtosis were met.
%
%
%    Example: From the example 6.1 of Zar (1999, p.70-71), we are interested to ask 
%             whether the data are skewned to left or to the rigth and also whether
%             they  are leptokurtic or platykurtic (d = 1) with  a  significance 
%             level = 0.05.
%
%                       x       Frequency
%                   ----------------------
%                      63           2
%                      64           2
%                      65           3
%                      66           5
%                      67           4
%                      68           6
%                      69           5
%                      70           8
%                      71           7
%                      72           7
%                      73          10
%                      74           6
%                      75           3
%                      76           2
%                   ----------------------
%                                       
%           Data matrix must be:
%      X=[63;63;64;64;65;65;65;66;66;66;66;66;67;67;67;67;68;68;68;68;68;68;69;69;69;69;69;
%      70;70;70;70;70;70;70;70;71;71;71;71;71;71;71;72;72;72;72;72;72;72;73;73;73;73;73;73;
%      73;73;73;73;74;74;74;74;74;74;75;75;75;76;76];
%
%     Calling on Matlab the function: 
%             skekurtest(X,1)
%
%       Answer is:
%
% ------------------------------------
%              E s t i m a t o r       
% ------------------------------------
%                g           b       
% ------------------------------------
% Skewness   -0.3452     -0.3378
% ------------------------------------
% Test to assesing skewness z= -1.2292
% Probability associated to the z statistic = 0.1095
% With a given significance = 0.050
% The population distribution is not skewed to left.
% 
% ------------------------------------
%              E s t i m a t o r       
% ------------------------------------
%                g           b       
% ------------------------------------
% kurtosis   -0.7182      2.2476
% ------------------------------------
% Test to assesing kurtosis z= 1.2762
% Probability associated to the z statistic = 0.1009
% With a given significance = 0.050
% The population distribution is leptokurtic.   
%

%  Created by A. Trujillo-Ortiz and R. Hernandez-Walls
%             Facultad de Ciencias Marinas
%             Universidad Autonoma de Baja California
%             Apdo. Postal 453
%             Ensenada, Baja California
%             Mexico.
%             atrujo@uabc.mx
%
%  September 09, 2003.
%
%  To cite this file, this would be an appropriate format:
%  Trujillo-Ortiz, A. and R. Hernandez-Walls. (2003). skekurtest: Hypotheses test concerning skewness
%    and kurtosis. A MATLAB file. [WWW document]. URL http://www.mathworks.com/matlabcentral/fileexchange/
%    loadFile.do?objectId=3953&objectType=FILE
%
%  References:
% 
%  Zar, J. H. (1999), Biostatistical Analysis (2nd ed.).
%           NJ: Prentice-Hall, Englewood Cliffs. pp. 70-71,115-119. 
%

if nargin < 3,
   alpha = 0.05;
end; 

if (alpha <= 0 | alpha >= 1)
   fprintf('Warning: significance level must be between 0 and 1\n');
   return;
end;

if nargin == 1,
   d = 2;
   alpha = 0.05;
end; 

n = length(X);

[c,v]=hist(X,X);  %record of data in a frequency table form
nc=find(c~=0);
c=[v(nc) c(nc)'];

x = c(:,1);
f = c(:,2);
s1 = f'*x;
s2 = f'*x.^2;
s3 = f'*x.^3;
s4 = f'*x.^4;
SS = s2-(s1^2/n);
v = SS/(n-1);
k3 = ((n*s3)-(3*s1*s2)+((2*(s1^3))/n))/((n-1)*(n-2));
g1 = k3/sqrt(v^3);
k4 = ((n+1)*((n*s4)-(4*s1*s3)+(6*(s1^2)*(s2/n))-((3*(s1^4))/(n^2)))/((n-1)*(n-2)*(n-3)))-((3*(SS^2))/((n-2)*(n-3)));
g2 = k4/v^2;
eg1 = ((n-2)*g1)/sqrt(n*(n-1));  %measure of skewness
eg2 = ((n-2)*(n-3)*g2)/((n+1)*(n-1))+((3*(n-1))/(n+1));  %measure of kurtosis
%Testing skewness
A = eg1*sqrt(((n+1)*(n+3))/(6*(n-2)));
B = (3*((n^2)+(27*n)-70)*((n+1)*(n+3)))/((n-2)*(n+5)*(n+7)*(n+9));
C = sqrt(2*(B-1))-1;
D = sqrt(C);
E = 1/sqrt(log(D));
F = A/sqrt(2/(C-1));
Zg1 = E*log(F+sqrt(F^2+1));

if d == 1;
   if Zg1 <= 0;
      P1 = normcdf(Zg1);
      fprintf('------------------------------------\n');
      disp('             E s t i m a t o r       ')
      fprintf('------------------------------------\n');
      disp('               g           b       ')
      fprintf('------------------------------------\n');
      fprintf('Skewness   %3.4f%12.4f\n', g1,eg1);
      fprintf('------------------------------------\n');
      fprintf('Test to assesing skewness z= %3.4f\n', Zg1);
      fprintf('Probability associated to the z statistic = %3.4f\n', P1);
      fprintf('With a given significance = %3.3f\n', alpha);
      if P1 <= alpha;
         disp('The population distribution is skewed to left.');
      else
         disp('The population distribution is not skewed to left.');
      end;
      disp(' ');
   else (Zg1 > 0);
      P1 = 1-normcdf(Zg1);
      fprintf('------------------------------------\n');
      disp('             E s t i m a t o r       ')
      fprintf('------------------------------------\n');
      disp('               g           b       ')
      fprintf('------------------------------------\n');
      fprintf('Skewness   %3.4f%12.4f\n', g1,eg1);
      fprintf('------------------------------------\n');
      fprintf('Test to assesing skewness z= %3.4f\n', Zg1);
      fprintf('Probability associated to the z statistic = %3.4f\n', P1);
      fprintf('With a given significance = %3.3f\n', alpha);
      if P1 >= alpha;
         disp('The population distribution is skewed to rigth.');
      else
         disp('The population distribution is not skewed to rigth.');
      end;
   end;
else (d == 2);
   Zg1 = abs(Zg1);
   P1 = 2*(1-normcdf(Zg1));
   fprintf('------------------------------------\n');
   disp('             E s t i m a t o r       ')
   fprintf('------------------------------------\n');
   disp('               g           b       ')
   fprintf('------------------------------------\n');
   fprintf('Skewness   %3.4f%12.4f\n', g1,eg1);
   fprintf('------------------------------------\n');
   fprintf('Test to assesing skewness z= %3.4f\n', Zg1);
   fprintf('Probability associated to the z statistic = %3.4f\n', P1);
   fprintf('With a given significance = %3.3f\n', alpha);     
   if P1 >= alpha;
      disp('The population distribution is symmetrical.');
   else
      disp('The population distribution is not symmetrical.');
   end;
end;

%Testing kurtosis
G = (24*n*(n-2)*(n-3))/((n+1)^2*(n+3)*(n+5));
H = ((n-2)*(n-3)*abs(g2))/((n+1)*(n-1)*sqrt(G));
J = ((6*(n^2-(5*n)+2))/((n+7)*(n+9)))*sqrt((6*(n+3)*(n+5))/((n*(n-2)*(n-3))));
K = 6+((8/J)*((2/J)+sqrt(1+(4/J^2))));
L = (1-(2/K))/(1+H*sqrt(2/(K-4)));
Zg2 = (1-(2/(9*K))-L^(1/3))/sqrt(2/(9*K));
if d == 1;
   if Zg2 <= 0;
      P2 = normcdf(Zg2);
      fprintf('------------------------------------\n');
      disp('             E s t i m a t o r       ')
      fprintf('------------------------------------\n');
      disp('               g           b       ')
      fprintf('------------------------------------\n');
      fprintf('kurtosis   %3.4f%12.4f\n', g2,eg2);
      fprintf('------------------------------------\n');
      fprintf('Test to assesing kurtosis z= %3.4f\n', Zg2);
      fprintf('Probability associated to the z statistic = %3.4f\n', P2);
      fprintf('With a given significance = %3.3f\n', alpha);
      if P2 <= alpha;
         disp('The population distribution is platykurtic.');
      else
         disp('The population distribution is not platikurtic.');
      end;
      disp(' ');
   else (Zg2 > 0);
      P2 = 1-normcdf(Zg2);
      fprintf('------------------------------------\n');
      disp('             E s t i m a t o r       ')
      fprintf('------------------------------------\n');
      disp('               g           b       ')
      fprintf('------------------------------------\n');
      fprintf('kurtosis   %3.4f%12.4f\n', g2,eg2);
      fprintf('------------------------------------\n');
      fprintf('Test to assesing kurtosis z= %3.4f\n', Zg2);
      fprintf('Probability associated to the z statistic = %3.4f\n', P2);
      fprintf('With a given significance = %3.3f\n', alpha);
     if P2 >= alpha;
         disp('The population distribution is leptokurtic.');
      else
         disp('The population distribution is not leptokurtic.');
      end;
   end;
else (d == 2);
   disp(' ');
   Zg2 = abs(Zg2);
   P2 = 2*(1-normcdf(Zg2));
   fprintf('------------------------------------\n');
   disp('             E s t i m a t o r       ')
   fprintf('------------------------------------\n');
   disp('               g           b       ')
   fprintf('------------------------------------\n');
   fprintf('kurtosis   %3.4f%12.4f\n', g2,eg2);
   fprintf('------------------------------------\n');
   fprintf('Test to assesing kurtosis z= %3.4f\n', Zg2);
   fprintf('Probability associated to the z statistic = %3.4f\n', P2);
   fprintf('With a given significance = %3.3f\n', alpha);
   if P2 >= alpha;
      disp('The population distribution is mesokurtic.');
   else
      disp('The population distribution is not mesokurtic.');
   end;
end;
