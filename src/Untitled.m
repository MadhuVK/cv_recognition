startTime = tic; 
clearvars -global
global majorMinor;
global plotValues;
global plotValuesIndex;
global percentCoverage;
global numValues;
global supportVector;
plotValuesIndex = 1; 

Main;

disp('Finding generic ellipses'); 
firstCluster = Z(:,:,1); 
%figure(); 
%imshow(firstCluster)
horzStrip = logical(sum(firstCluster,1));
hold on
%startTime = tic; 
for i=1:size(firstCluster,2)
    currStrip = firstCluster(:,i); 
    for j=1:length(currStrip)
        if firstCluster(j,i) ~= 0
            %fprintf('hello\n');
            %disp([j,i])
            drawAllCircles(currStrip, horzStrip, [i,j], firstCluster, .35); 
            %pause;
        end
    end
end
% toc(startTime)

GROUPING_VALUE = 20; 
supportVector(6,:) = ceil(supportVector(3,:)/GROUPING_VALUE)*GROUPING_VALUE + ceil(supportVector(4,:)/GROUPING_VALUE); 
supportVector = getCount(supportVector, firstCluster);

%Support Vector Column Form: minorAxis, majorAxis, columnPos, rowPos,
%groupNumber, Z-Scored Fill Percentage 
supportVector = sortrows(supportVector', 7)'; 
%imshow(firstCluster); 
hold on; 
[idk, xcenters] = hist(supportVector(7,:)); 
prevValue = 1; 
numCircles = 0; 

%{
for i=1:length(xcenters)
    for j=prevValue:size(supportVector,2)
        if supportVector(7,j) > xcenters(i)
            outputCluster = supportVector(:,prevValue:j-1);
            disp('New Output Cluster');
            outputCluster = sortrows(outputCluster', 6')'
            minGroup = min(outputCluster(6,:));
            maxGroup = max(outputCluster(6,:));
            
            currGroup = minGroup;
            prevprevValue = 1;
            for k=1:size(outputCluster,2)
                if outputCluster(6,k) > currGroup
                    values = combineCircles(outputCluster(:,prevprevValue:k-1));
                    plot(values(:,2), values(:,1));
                    disp('Paused');
                    pause;
                    numCircles = numCircles + 1; 
                    currGroup = outputCluster(6,k); 
                    prevprevValue = k; 
                end
            end
            
            
            prevValue = j;
            break;
        end
    end
end
disp(numCircles); 
%}
%{
supportVector = sortrows(supportVector', 6)'; 
minGroup = min(supportVector(6,:)); 
maxGroup = max(supportVector(6,:)); 
currGroup = minGroup; 
prevprevValue = 1; 
for i=minGroup:maxGroup
    if supportVector(6,i) > currGroup
        outputCluster = supportVector(:,prevprevValue:i-1);
        outputCluster = sortrows(outputCluster', 7)'; 
        [idk, xcenters] = hist(outputCluster(7,:)); 
        prevValue = 1; 
        for j=2:length(xcenters)
            for k=prevValue:size(outputCluster,2)
                if outputCluster(7,k) > xcenters(j)
                    values = combineCircles(outputCluster(:,prevValue:k-1)); 
                    plot(values(:,2), values(:,1)); 
                    prevValue = k; 
                    pause; 
                    break; 
                end
            end
        end
        currGroup = supportVector(6,i); 
        prevprevValue = i; 
    end
end
%}
disp('Limiting ellipses'); 
values = [];
outputCluster = supportVector;
disp('New Output Cluster');
outputCluster = sortrows(outputCluster', 6')'; 
minGroup = min(outputCluster(6,:));
maxGroup = max(outputCluster(6,:));

currGroup = minGroup;
prevprevValue = 1;
for k=1:size(outputCluster,2)
    if outputCluster(6,k) > currGroup
        values = [values; [NaN, NaN]; combineCircles(outputCluster(:,prevprevValue:k-1), im1)];
        %plot(values(:,2), values(:,1));
        %pause;
        numCircles = numCircles + 1;
        currGroup = outputCluster(6,k);
        prevprevValue = k;
    end
end

disp('Blobbing'); 
PERCENT_OVERLAP = .10; 
currentImage = zeros(size(im1,1), size(im1,2)); 
localImage = zeros(size(im1,1), size(im1,2)); 
%figure(); 
values(1,:) = []; 
numRegions = 1; 
firstThing = true; 
for i=1:size(values,1)
    if isnan(values(i,1)) 
        hasOverlap = false;       
        localImage = imfill(localImage, 'holes'); 
        for j=1:numRegions
            currentImage(:,:,j) = localImage + currentImage(:,:,j); 
            stuff = currentImage(:,:,j);
            numOverlap = length(stuff(stuff==2));
            regionSize = length(localImage(localImage >= 1));
            if numOverlap/regionSize > PERCENT_OVERLAP
                disp('Has overlap'); 
                hasOverlap = true; 
                localImage = zeros(size(im1,1), size(im1,2)); 
                currentImage(:,:,j) = logical(currentImage(:,:,j)); 
                break; 
            elseif (numOverlap/regionSize < PERCENT_OVERLAP) && (numOverlap/regionSize > 0)
                hasOverlap = true; 
                currentImage(:,:,j) = currentImage(:,:,j) - localImage; 
                localImage = zeros(size(im1,1), size(im1,2)); 
                break; 
            else 
                currentImage(:,:,j) = currentImage(:,:,j) - localImage; 
            end
        end
        
        if hasOverlap == false 
            currentImage(:,:,j+1) = localImage; 
            numRegions = j+1; 
        end
            
    else 
        localImage(values(i,1), values(i,2)) = 1; 
    end
end
imshow(im1); 
figure(1); 
hold on;
for i=2:numRegions
    Point = NaN; 
    for j=1:size(im1,1)
        for k=1:size(im1,2)
            if currentImage(j,k,i) == 1; 
                Point = [j,k]; 
                break; 
            end
        end
    end
    points = bwtraceboundary(currentImage(:,:,i), Point, 'SW');
    plot(points(:,2), points(:,1), 'c', 'LineWidth', 1.5); 
end

clearvars -global; 
global majorMinor;
global plotValues;
global plotValuesIndex;
global percentCoverage;
global numValues;
global supportVector;
plotValuesIndex = 1; 
disp('Finding generic ellipses'); 
firstCluster = Z(:,:,3); 
%figure(); 
%imshow(firstCluster)
horzStrip = logical(sum(firstCluster,1));
hold on
%startTime = tic; 
for i=1:size(firstCluster,2)
    currStrip = firstCluster(:,i); 
    for j=1:length(currStrip)
        if firstCluster(j,i) ~= 0
            %fprintf('hello\n');
            %disp([j,i])
            drawAllCircles(currStrip, horzStrip, [i,j], firstCluster, .3); 
            %pause;
        end
    end
end
% toc(startTime)

GROUPING_VALUE = 20; 
supportVector(6,:) = ceil(supportVector(3,:)/GROUPING_VALUE)*GROUPING_VALUE + ceil(supportVector(4,:)/GROUPING_VALUE); 
supportVector = getCount(supportVector, firstCluster);

%Support Vector Column Form: minorAxis, majorAxis, columnPos, rowPos,
%groupNumber, Z-Scored Fill Percentage 
supportVector = sortrows(supportVector', 7)'; 
%imshow(firstCluster); 
%hold on; 
[idk, xcenters] = hist(supportVector(7,:)); 
prevValue = 1; 
numCircles = 0; 

%{
for i=1:length(xcenters)
    for j=prevValue:size(supportVector,2)
        if supportVector(7,j) > xcenters(i)
            outputCluster = supportVector(:,prevValue:j-1);
            disp('New Output Cluster');
            outputCluster = sortrows(outputCluster', 6')'
            minGroup = min(outputCluster(6,:));
            maxGroup = max(outputCluster(6,:));
            
            currGroup = minGroup;
            prevprevValue = 1;
            for k=1:size(outputCluster,2)
                if outputCluster(6,k) > currGroup
                    values = combineCircles(outputCluster(:,prevprevValue:k-1));
                    plot(values(:,2), values(:,1));
                    disp('Paused');
                    pause;
                    numCircles = numCircles + 1; 
                    currGroup = outputCluster(6,k); 
                    prevprevValue = k; 
                end
            end
            
            
            prevValue = j;
            break;
        end
    end
end
disp(numCircles); 
%}
%{
supportVector = sortrows(supportVector', 6)'; 
minGroup = min(supportVector(6,:)); 
maxGroup = max(supportVector(6,:)); 
currGroup = minGroup; 
prevprevValue = 1; 
for i=minGroup:maxGroup
    if supportVector(6,i) > currGroup
        outputCluster = supportVector(:,prevprevValue:i-1);
        outputCluster = sortrows(outputCluster', 7)'; 
        [idk, xcenters] = hist(outputCluster(7,:)); 
        prevValue = 1; 
        for j=2:length(xcenters)
            for k=prevValue:size(outputCluster,2)
                if outputCluster(7,k) > xcenters(j)
                    values = combineCircles(outputCluster(:,prevValue:k-1)); 
                    plot(values(:,2), values(:,1)); 
                    prevValue = k; 
                    pause; 
                    break; 
                end
            end
        end
        currGroup = supportVector(6,i); 
        prevprevValue = i; 
    end
end
%}
disp('Limiting ellipses'); 
values = [];
outputCluster = supportVector;
disp('New Output Cluster');
outputCluster = sortrows(outputCluster', 6')'; 
minGroup = min(outputCluster(6,:));
maxGroup = max(outputCluster(6,:));

currGroup = minGroup;
prevprevValue = 1;
for k=1:size(outputCluster,2)
    if outputCluster(6,k) > currGroup
        values = [values; [NaN, NaN]; combineCircles(outputCluster(:,prevprevValue:k-1), im1)];
        %plot(values(:,2), values(:,1));
        %pause;
        numCircles = numCircles + 1;
        currGroup = outputCluster(6,k);
        prevprevValue = k;
    end
end

disp('Blobbing'); 
PERCENT_OVERLAP = .10; 
currentImage = zeros(size(im1,1), size(im1,2)); 
localImage = zeros(size(im1,1), size(im1,2)); 
%figure(); 
values(1,:) = []; 
numRegions = 1; 
firstThing = true; 
for i=1:size(values,1)
    if isnan(values(i,1)) 
        hasOverlap = false;       
        localImage = imfill(localImage, 'holes'); 
        for j=1:numRegions
            currentImage(:,:,j) = localImage + currentImage(:,:,j); 
            stuff = currentImage(:,:,j);
            numOverlap = length(stuff(stuff==2));
            regionSize = length(localImage(localImage >= 1));
            if numOverlap/regionSize > PERCENT_OVERLAP
                disp('Has overlap'); 
                hasOverlap = true; 
                localImage = zeros(size(im1,1), size(im1,2)); 
                currentImage(:,:,j) = logical(currentImage(:,:,j)); 
                break; 
            elseif (numOverlap/regionSize < PERCENT_OVERLAP) && (numOverlap/regionSize > 0)
                hasOverlap = true; 
                currentImage(:,:,j) = currentImage(:,:,j) - localImage; 
                localImage = zeros(size(im1,1), size(im1,2)); 
                break; 
            else 
                currentImage(:,:,j) = currentImage(:,:,j) - localImage; 
            end
        end
        
        if hasOverlap == false 
            currentImage(:,:,j+1) = localImage; 
            numRegions = j+1; 
        end
            
    else 
        localImage(values(i,1), values(i,2)) = 1; 
    end
end


figure(1);
hold on; 
for i=2:numRegions
    Point = NaN; 
    for j=1:size(im1,1)
        for k=1:size(im1,2)
            if currentImage(j,k,i) == 1; 
                Point = [j,k]; 
                break; 
            end
        end
    end
    points = bwtraceboundary(currentImage(:,:,i), Point, 'SW');
    plot(points(:,2), points(:,1), 'c', 'LineWidth', 1.5); 
end

 toc(startTime); 
