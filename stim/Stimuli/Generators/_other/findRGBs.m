for i = 1:length(possibles)
    [XYZs bgXYZ RGBs bgRGB] = CIELABTosRGB(0:359, possibles(i, 1), possibles(i, 2));
    RGBs = round(RGBs);
    RGBs = RGBs';
    if isequal(data, RGBs)
       theValue = i; 
    end
end