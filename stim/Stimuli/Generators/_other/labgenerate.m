
[XYZs bgXYZ RGBs bgRGB] = CIELABTosRGB(0:359, 25, 12);
RGBs = round(RGBs);
maximum = max(max(RGBs));
minimum = min(min(RGBs));
RGBs = RGBs';




