function delta = getDeltaMod(image, n, i, j)
%surrounding = zeros(1, n^2-1); 
outsideRange = n - 2; 
%counter = 1; 
surrounding = image(i-outsideRange:i+outsideRange, j-outsideRange:j+outsideRange);
%{
for x = i-outsideRange:i+outsideRange
    for y = j-outsideRange:j+outsideRange
        surrounding(counter) = image(x,y); 
        counter = counter + 1; 
    end
end
%}
delta = mean(surrounding(:)); 
