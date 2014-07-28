im1 = imTrimmer(rgb2gray(imread('faces.jpg'))); 

%% Find Delta Values 
disp('Running deltas'); 
deltas3 = zeros(size(im1,1), size(im1,2)); 
n = 3; 
for i=(n-1):size(im1,1)-(n-2)
    for j=(n-1):size(im1,2)-(n-2)
        deltas3(i,j) = getDelta(im1, n,i,j); 
    end
end


deltas3abs = abs(deltas3);
%imshow(deltas3abs); 
%% Take Away Slivers and accentuate

newAbs = deltas3abs; 
for i=1:35
newAbs = dxRemover(newAbs, .03);
newAbs = 1./exp(1./newAbs);
multiplier = 1./mean(newAbs(~isnan(newAbs))); 
newAbs = multiplier.*newAbs; 
end

disp('Accentuating deltas'); 
%% Remove big threshold
newDeltas = dxRemover(newAbs, .50); 
newDeltas = dxRemover(newDeltas, .75); 

%newDeltas = newAbs; 


%% Deltas on deltas (Doesn't do anything) 

newDeltas(isnan(newDeltas)) = 0; 
deltas = zeros(size(newDeltas,1), size(newDeltas,2)); 
n = 3; 
for i=(n-1):size(newDeltas,1)-(n-2)
    for j=(n-1):size(newDeltas,2)-(n-2)
        deltas(i,j) = getDeltaMod(newDeltas, n,i,j); 
    end
end


%% Find Clusters
disp('Finding clusters'); 
X = newDeltas; 
X(isnan(X)) = 0; 
X = logical(X); 
Y = makeGroups(X, 64); 
Z = zeros(size(im1,1),size(im1,2),64); 
for i=1:64
    f = Y; 
    f(f~=i) = 0; 

    Z(:,:,i) = f; 
end
for i=64:-1:1
   f = Z(:,:,i); 
   if length(f(f~=0)) < 100
       Z(:,:,i) = []; 
   end
end

for i=1:1
    f = Z(:,:,i);
    %figure();
    %mesh(f); 
end

%% Get Tracing 
%{
firstCluster = Z(:,:,1);
firstCluster = logical(firstCluster);
T = deltas3abs.*firstCluster;
path = tracing(T, [103, 200]); % Specific to first image
pathImg = zeros(420,640);
for i=1:size(path,1)
pathImg(path(i,1), path(i,2)) = 1;
end
figure();
imshow(pathImg)
%}

%% Get Axis Points for Circle 
%{
AxisPoints = struct('yPts', [], 'xPts', [], 'Pairs', []); 
AxisPoints = repmat(AxisPoints, size(firstCluster,1), size(firstCluster, 2)); 

imshow(firstCluster); 
hold on
workingPos = []; 
boundaryDimensions = [59,306,139,405]; 
startTime = tic; 
for i=boundaryDimensions(1):boundaryDimensions(2)
    list = getNewAxisPoints(i, true, firstCluster);
    for j=boundaryDimensions(3):boundaryDimensions(4)
        AxisPoints(i,j).xPts = list - j; 
    end
end
for i=boundaryDimensions(3):boundaryDimensions(4)
    list = getNewAxisPoints(i, false, firstCluster);
    for j=boundaryDimensions(1):boundaryDimensions(2)
        if ~isempty(AxisPoints(j,i).xPts)
            AxisPoints(j,i).yPts = list - j; 
            [z,w] = meshgrid(AxisPoints(j,i).xPts, AxisPoints(j,i).yPts); 
            AxisPoints(j,i).Pairs = [z(:), w(:)]; 
        end
    end
end
toc(startTime)
count = 0; 
for i=boundaryDimensions(1):boundaryDimensions(2)
    for j=boundaryDimensions(3):boundaryDimensions(4)
        if ~isempty(AxisPoints(i,j).xPts) && ~isempty(AxisPoints(i,j).yPts)
           % [z,w] = meshgrid(AxisPoints(i,j).xPts, AxisPoints(i,j).yPts); 
            %AxisPoints(i,j).Pairs = [z(:), w(:)]; 
            %{
            K = AxisPoints(i,j).xPts; L = AxisPoints(i,j).yPts; 
            for k=1:length(K)
                for l=1:length(L)
                    if abs(L(l)) > abs(K(k))
                        count = count + 1; 
                    end
                end
            end
            %}
             %count = count + length(AxisPoints(i,j).xPts)+length(AxisPoints(i,j).yPts);
        end
    end
end
%{
for i=boundaryDimensions(1):boundaryDimensions(2)
    for j=boundaryDimensions(3):boundaryDimensions(4)
        [AxisPoints(i,j).yPts, AxisPoints(i,j).xPts] = getAxisPoints([i,j], firstCluster); 
    end
end
%}
%{
heatMap = zeros(420,640); 
for i=59:306
    for j=139:405
        value1 = AxisPoints(i,j).xPts; 
        value2 = AxisPoints(i,j).yPts; 
        heatMap(i,j) = length(value1)*length(value2); 
    end
end
%}
hold on
imshow(firstCluster)
for i=1:size(AxisPoints,1)
    for j=1:size(AxisPoints,2)
        Pairs = AxisPoints(i,j).Pairs; 
        for k=1:size(Pairs,1)
            if abs(Pairs(k,1)) < abs(Pairs(k,2))
                if passCheck(i,j,Pairs(k,2), Pairs(k,1), firstCluster)
                    drawCircle(i,j,Pairs(k,2),Pairs(k,1), firstCluster); 
                end
            end
        end
    end
end
%% Working with one individual pixel to see the circles 
%{
close all; 
MAP = firstCluster;
imshow(MAP); 
hold on;
MAP = outputCircles(AxisPoints, MAP);
%}
%}
%}

  
