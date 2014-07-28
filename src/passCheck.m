function booleanVal = passCheck(i,j, yVal, xVal, MAP)
%PASSCHECK Summary of this function goes here
%   Detailed explanation goes here
alpha = 10; 
region = MAP(i-yVal-alpha:i+yVal + alpha, j-xVal-alpha:j+xVal+alpha); 
region(alpha:(size(regionSmall,1)-alpha), alpha:(size(region,2)-alpha)) = 0; 
region1 = region(:,1:round(size(region,2)/3)); 
region2 = region(:,round(size(region,2)/3):2*round(size(region,2)/3)); 
region3 = region(:,2*round(size(region,2)/3):3*round(size(region,2)/3)); 

booleanVal = true; 
if region1(:) 
end

