function [MAP] = drawCircle(x0,y0,xAxis, yAxis, MAP, percent)
%DRAWCIRCLE Summary of this function goes here
%   Detailed explanation goes here
global majorMinor; 
global plotValues;
global plotValuesIndex; 
global percentCoverage; 
global numValues; 
global supportVector; 

if (abs(xAxis/yAxis) < .5 || abs(xAxis/yAxis) > .7 )
    return; 
end
if (yAxis < 10)
    return; 
end

%fprintf('%d %d %d %d', x0,  y0, xAxis, yAxis)
%{
vLength = round(2*abs(yAxis)); 
hLength = round(2*abs(xAxis)); 
region1 = MAP(y0:(y0 + round(vLength/3)), (x0-xAxis):(x0-xAxis + round(hLength/3)));
if hLength < 5
    return;
end
if sum(region1(:)) < 1
    return; 
end


region3 = MAP(y0: y0 + round(vLength/3), (x0-xAxis + round(2*hLength/3)):(x0-xAxis + hLength)); 
if sum(region3(:)) < 1
    return; 
end
region7 = MAP(y0 + round(2*vLength/3):y0 + round(vLength), (x0-xAxis):(x0-xAxis + round(hLength/3))); 
if sum(region7(:)) < 1 
    return; 
end
region9 = MAP(y0 + round(2*vLength/3):y0 + round(vLength), (x0-xAxis + round(2*hLength/3)):(x0-xAxis + hLength)); 
if sum(region9(:)) < 1 
    return; 
end
%{
region5 = MAP(y0:y0 + round(vLength), (x0-xAxis):(x0-xAxis + round(hLength))); 
region5Size = size(region5,1)*size(region5,2); 
if sum(region5(:))/region5Size < .2 && sum(region5(:))/region5Size > .8
    return; 
end
%}
 %}
%fourPoints = [y0, y0 + 2*yAxis, x0 - xAxis, x0 + xAxis]; 
%{
dist = round(abs(yAxis)); 
fourCount = 0; 
if sum(MAP(y0-dist:y0, x0)) > 1
    fourCount = fourCount + 1; 
end
if sum(MAP(y0+2*yAxis:(y0+2*xAxis+dist), x0)) > 1
    fourCount = fourCount + 1; 
end
if sum(MAP(y0, x0-xAxis-dist:(x0-xAxis))) > 1
    fourCount = fourCount + 1; 
end
if sum(MAP(y0, x0+xAxis:(x0+xAxis+dist))) > 1
    fourCount = fourCount + 1; 
end
if fourCount > 1
    return; 
end
%}
%{
dist = round(abs(yAxis)); 
fourCount = 0; 
if sum(MAP(y0-dist:y0+dist, x0)) > 1
    fourCount = fourCount + 1; 
end
if sum(MAP(y0+2*yAxis:(y0+2*xAxis+dist), x0)) > 1
    fourCount = fourCount + 1; 
end
if sum(MAP(y0, x0-xAxis-dist:(x0-xAxis))) > 1
    fourCount = fourCount + 1; 
end
if sum(MAP(y0, x0+xAxis:(x0+xAxis+dist))) > 1
    fourCount = fourCount + 1; 
end
if fourCount > 1
    return; 
end
%}
%{
dist = round(abs(50/yAxis)); 
fourCount = [50, 50, 50, 50]; 
for i=y0-dist:y0+dist
    if MAP(i,x0) == 1 && fourCount(1) > abs(y0-i)
        fourCount(1) = abs(y0-i); 
    end
end
for i = y0 + 2*yAxis - dist: y0 + 2*yAxis + dist 
    if MAP(i,x0) == 1 && fourCount(2) > abs(y0-i)
        fourCount(2) = abs(y0-i); 
    end
end
for i=x0-xAxis-dist:x0-xAxis+dist
    if MAP(y0+yAxis,i) == 1 && fourCount(3) > abs(x0-xAxis-i)
        fourCount(3) = abs(x0-xAxis-i); 
    end 
end
for i=x0+xAxis-dist:x0+xAxis+dist
    if MAP(y0+yAxis,i) == 1 && fourCount(4) > abs(x0+xAxis-i)
        fourCount(4) = abs(x0-xAxis-i); 
    end 
end
%}


%fprintf('%d %d %d %d', x0, y0, xAxis, yAxis); 
th = 0:pi/10:2*pi;
xunit = round(x0 + xAxis*cos(th)); 
yunit = round((y0 + yAxis) + yAxis*sin(th)); 
[thisPercentCoverage, count] = getPercentCoverage(xunit, yunit, MAP); 
if thisPercentCoverage > percent
    supportVector(:,plotValuesIndex) = [xAxis, yAxis, x0, (y0+yAxis), ((x0-1)*size(MAP,1) + (y0+yAxis))]; 
    %plot(xunit,yunit, '-.'); 
    %x = thisPercentCoverage; 
    %y = count
    %B = (.9/.1 * x/y) / (.9/.1*x/y + 1); 
    %A = (1-B); 
    %percentCoverage = [percentCoverage; A*x + B*y]; 
    currentPlotValues = [xunit', yunit']; 
    %stuff = MAP(y0 + floor(xAxis/10) : (y0 + 2*yAxis - floor(xAxis/10)), x0 - xAxis + floor(xAxis/10): x0 + xAxis - floor(xAxis/10)); 
    %numValues = [numValues; size(stuff(stuff==1), 1)]; %/(size(stuff,1)*size(stuff,2))]; 
    plotValues(:,:,plotValuesIndex) = [currentPlotValues]; 
   % majorMinor = [majorMinor; (yAxis/xAxis)]; 
    plotValuesIndex = plotValuesIndex + 1; 
    %text = annotation('textbox', [x0, y0 + yAxis]); 
    %set(text, 'String', sprintf('%f', mean(fourCount), 'Fontsize', 8)); 
end

end