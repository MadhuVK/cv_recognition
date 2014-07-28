function path = pathFinder(startPos, endPos)

if startPos(2) < endPos(2)
    path1 = [repmat(startPos(1), [1,length(startPos(2)+1:endPos(2))]); startPos(2)+1:endPos(2)]'; 
elseif startPos(2) == endPos(2)
    path1 = []; 
else 
    path1 = [repmat(startPos(1), [1,length(startPos(2)-1:-1:endPos(2))]); startPos(2)-1:-1:endPos(2)]';
end

if startPos(1) < endPos(1)
    path2 = [startPos(1)+1:endPos(1); repmat(endPos(2), [1,length(startPos(1)+1:endPos(1))])]'; 
elseif startPos(1) == endPos(1)
    path2 = []; 
else 
    path2 = [startPos(1)-1:-1:endPos(1); repmat(endPos(2), [1,length(startPos(1)-1:-1:endPos(1))])]'; 
end

path = [path1; path2]; 


end

