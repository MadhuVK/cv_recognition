function supportVector = getCount(supportVector, cluster)


for i=1:size(supportVector,2)
    stuff1 = cluster; 
    stuff1 = stuff1 + ellipseMatrix(supportVector(:,i), zeros(size(cluster,1),size(cluster,2))); 
    supportVector(7,i) = length(stuff1(stuff1==2))/(supportVector(1,i)*supportVector(2,i)*pi); 
end
%supportVector(7,:) = abs(supportVector(7,:) - mean(supportVector(7,:)))/mean(supportVector(7,:)); 

end

