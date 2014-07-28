function MAP = outputCircles(circlePoints, MAP)
%OUTPUTCIRCLES Summary of this function goes here
%   Detailed explanation goes here

for i=1:size(circlePoints,1)
    for j=1:size(circlePoints,2)
        if ~isempty(circlePoints(i,j).xPts) && ~isempty(circlePoints(i,j).yPts)
            MAP = drawAllCircles(i,j,circlePoints(i,j), MAP); 
            %return; 
        end
    end
end

%MAP = drawAllCircles(134,335, circlePoints(134,335), MAP); 

end

