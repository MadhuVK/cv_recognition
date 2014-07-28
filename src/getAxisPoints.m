function [y, x] = getAxisPoints(pos, MAP)
%GETAXISPOINTS Summary of this function goes here
%   Detailed explanation goes here
xRad = pos(2); 
yRad = pos(1); 
y = []; 
x = []; 
for i=size(MAP,1):-1:1
    if MAP(i, xRad) ~= 0
        y = [y,(i-yRad)]; 
    end
end
for i=size(MAP,2):-1:1
    if MAP(yRad, i) ~= 0
        x = [x, (i-xRad)]; 
    end
end

end