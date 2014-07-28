function [points] = combineCircles(ellipses, im1)
%% decide if two ellipses should be combined here 



%% Combine the two ellipses 
stuff1 = zeros(size(im1,1),size(im1,2)); 
for i=1:size(ellipses,2)
    stuff1 = ellipseMatrix(ellipses(:,i), stuff1); %NOTE THIS NEEDS TO BE CHANGED LATER
end
Point = NaN; 
for i=1:size(im1,1)
    for j=1:size(im1,2)
        if stuff1(i,j) == 1; 
            Point = [i,j]; 
        end
    end
end
if isnan(Point)
    points = []; 
else 
    points = bwtraceboundary(stuff1, Point, 'SW'); 
end
