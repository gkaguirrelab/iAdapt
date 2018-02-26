possibles = zeros(2500,2);
possibleI = 1;

for i = 1: 50
    for j = 1:50
        
    [XYZs bgXYZ RGBs bgRGB] = CIELABTosRGB(0:359, j, i);
    RGBs = round(RGBs);
    maximum = max(max(RGBs));
    minimum = min(min(RGBs));
    
    if maximum <= 256 && minimum >= 0
        possibles(possibleI, 1) = j;
        possibles(possibleI, 2) = i;
        possibleI = possibleI + 1;
    end
    end
end

possibles(possibleI : length(possibles), :)  = [];