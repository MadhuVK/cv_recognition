function [list] = getNewAxisPoints(index, yModifier, MAP)
list1 = []; 
list2 = [];
if yModifier
for i=1:size(MAP,2)
    if MAP(index,i) ~= 0 
        list1 = [list1, i];
    end
end
list = list1;
else 
for i=1:size(MAP,1)
    if MAP(i,index) ~= 0 
        list2 = [list2, i];
    end
end
list = list2; 
end

end

