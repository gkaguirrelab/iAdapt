%[XYZs bgXYZ RGBs bgRGB] = CIELABTosRGB(0:359, 25, 7);
[XYZs bgXYZ RGBs bgRGB] = CIELABTosRGB(0:359, 30, 20);
RGBs = round(RGBs);
maximum = max(max(RGBs));
minimum = min(min(RGBs));
RGBs = RGBs';
fid = fopen('Color.txt','wt');
for i = 1:length(RGBs)
   fprintf(fid,'(%d, %d, %d)\t\n',RGBs(i,1), RGBs(i,2), RGBs(i,3)); 
end
display(sprintf('The range of RGB values is between %d and %d',minimum,maximum));
fclose(fid);