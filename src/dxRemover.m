function newDeltas = dxRemover(deltas, dx)

stuff = deltas(:); 
stuff = sort(stuff(~isnan(stuff))); 
threshold = stuff(floor(dx.*length(stuff))); 

newDeltas = zeros(size(deltas)); 
for i=1:size(deltas, 1)
    for j=1:size(deltas, 2)
        if deltas(i,j) <= threshold
            newDeltas(i,j) = NaN; 
        else 
            newDeltas(i,j) = deltas(i,j); 
        end
    end
end

 


end

