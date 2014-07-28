function [f, fakeGrid] = modifier(position, grid, n, N)
x = position(1); 
y = position(2); 

fakeGrid = zeros(N); 
for i=1:N
    for j=1:N
        if grid(position(1)-(N-((N+1)/2))+(i-1),position(2)-(N-((N+1)/2))+(j-1))~=0 && ~isnan(grid(position(1)-((N+1)/2)+(i-1),position(2)-(N-((N+1)/2))+(j-1))) && (logical(sum(i == [1,N]) || logical(sum(j == [1,N]))))
            fVal = n.*((x-i)^2+(y-j)^2)^(1/2) + (1-n).*(grid(position(1), position(2)) - grid(position(1)-(N-((N+1)/2))+(i-1),position(2)-(N-((N+1)/2))+(j-1))); 
            fakeGrid(i,j) =  fVal; 
        end
    end
end
fakeGrid(fakeGrid==0) = NaN; 

f=min(min(fakeGrid(~isnan(fakeGrid)))); 

end

