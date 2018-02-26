function wheel = colorWheelRGB(radius,numColors,path2wheel)

% Check if path2wheel exists
% Check if radius is too small or too large
% If numColors is not entered, assume 360

load(path2wheel)

% Generate list of angles to sample from
degreesRads = linspace(0, 2*pi, numColors+1);
% Remove the repetition at 0/360
degreesRads = degreesRads(1:end-1);

% Generate (x,y) coordinates of circle
x=radius*sin(degreesRads);
y=radius*cos(degreesRads);

% Displace by centerXY and round to nearest neighbor
centerXY = [median(1:size(colorWheel,1)) median(1:size(colorWheel,2))];
Xround=round(x+centerXY(1));
Yround=round(y+centerXY(2));

% Create color wheel
wheel = zeros(numColors,3);
for i=1:numColors
    wheel(i,:) = squeeze(colorWheel(Xround(i),Yround(i),:))';
end

imagesc(reshape(wheel,1,360,3)/256)