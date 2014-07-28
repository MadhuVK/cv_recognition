function [percentage, count] = getPercentCoverage(xVals, yVals, MAP)
count = 0; 
for i=1:length(xVals)
    if MAP(yVals(i), xVals(i)) > 0
        count = count + 1; 
    end
end
percentage = (count/length(xVals)); 
end

