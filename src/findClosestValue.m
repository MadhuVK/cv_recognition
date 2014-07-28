function [output, f] = findClosestValue(position, grid)
n = .5; 

f = []; 
N = 1; 
while (isempty(f))
    N = N + 2
    [f, fakeGrid] = modifier(position, grid, n, N); 
end

[y, x] = find(fakeGrid==f, 1, 'first')

output = [position(1) - (N-((N+1)/2)) + (y-1), position(2) - (N-((N+1)/2)) + (x-1)];
end
