function [coloredOutput] = makeGroups(logicalInput, numClust)
[row, column] = find(logicalInput == 1); 
X = [row,column]; 
Y = pdist(X); 
Z = linkage(Y); 
C = cluster(Z, 'maxclust', numClust); 
coloredOutput = zeros(size(logicalInput)); 
counter = 1; 
for i=1:size(logicalInput(:))
        if logicalInput(i) == 0
            coloredOutput(i) = 0; 
        else 
            coloredOutput(i) = C(counter); 
            counter = counter + 1; 
        end
end


end

