function delta = getDelta(image, n, i, j)
%surrounding = zeros(1, n^2-1); 
outsideRange = n - 2; 
%counter = 1; 
surrounding = image(i-outsideRange:i+outsideRange, j-outsideRange:j+outsideRange);
surrounding = surrounding - double(image(i,j)); 
delta = mean(surrounding(:)); 


end

