%newnewdeltas
%newAbs 
function [path] = tracing(originalDelta, pos)
path = zeros(1, 2); %first position 
path(1, :) = pos;
%path(1,:) = [13,2]; 
MAP = originalDelta; 
%p=plot(path(1,1)+.5,path(1,2)+.5,'bo'); %visual stuff ignore
i = 2; % the index of the list path
MAP(path(1,1), path(1,2)) = 0; 
while  (max(MAP(:)) ~= 0) 
        position = path(end,:)
        [closestValue, f] = findClosestValue(position, MAP);
        %pause(); 
        MAP(closestValue(1),closestValue(2)) = 0; 
		newPos = pathFinder(position, closestValue);
        path = [path; newPos]; 
        i = i + 1
        % store the next step in the list path
        %set(p,'XData',path(size(path,1),1)+.5,'YData',path(size(path,1),2)+.5); %visual stuff ignore
        %plot(path(:,1)+.5,path(:,2)+.5); %visual stuff ignore
end


end

