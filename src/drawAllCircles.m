function MAP = drawAllCircles(vertStrip,horzStrip, pos, MAP, percent)
xPos = pos(1);
yPos = pos(2);
for i=(yPos+1):length(vertStrip)
    if vertStrip(i) ~= 0
        for j=xPos:length(horzStrip)
            try 
            if (horzStrip(j) ~= 0) && (horzStrip(xPos - abs(xPos-j)) ~= 0)
                if (abs(j-xPos)) > (abs(yPos - i))/2
                    break;
                else
                    drawCircle(xPos, yPos, abs(xPos-j), round(abs(yPos-i)/2), MAP, percent);
                end
            end
            catch err 
            end 
        end
    end
end
end
