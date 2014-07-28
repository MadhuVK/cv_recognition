function [MAP] = drawCircle(y0,x0,yAxis, xAxis, MAP)
%DRAWCIRCLE Summary of this function goes here
%   Detailed explanation goes here
%{
if yAxis < 10 || xAxis < 10
    return; 
end
if x > 270
    return
end
%}
%{
path1 = pathFinder([y0,x0], [yAxis,xAxis]); 
path2 = pathFinder( [yAxis,xAxis], [y0,x0]); 
path = [path1;path2]; 
for i=1:size(path,1)
MAP(path(i,1), path(i,2)) = 1;
end
%}

if (abs(yAxis) >= abs(xAxis)) && (abs(xAxis/yAxis) < .25 || abs(xAxis/yAxis) > .75 )
    return; 
end

if  abs(xAxis) > abs(yAxis)
    return; 
end


th = 0:pi/50:2*pi;
xunit = round(xAxis * cos(th)) + x0;
yunit = round(yAxis * sin(th)) +  y0;
pixelValues = [xunit', yunit']; 
if getPercentCoverage(pixelValues, MAP) > .7
    plot(xunit,yunit); 
end

%plot(x0, y0, 'r.'); 
end

