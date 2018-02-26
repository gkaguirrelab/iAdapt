function [ degree ] = scaleDegree( degree )

while degree >= 360 || degree < 0 
    if degree >= 360
        degree = degree - 360;
    else
        degree = degree + 360;
    end    
end


