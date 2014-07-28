function [xVals, yVals] = ellipse(xRad, yRad, a, b)
xVals = []; 
yVals = []; 
x = 0; 
y = b; 
P = b^2 + (a^2*(1-4*b) - 2)/4; 
deltPE = 3*b^2; 
delt2PE = 2*b^2;
deltPSE = deltPE - 2*a^2*(b-1); 
delt2PSE = delt2PE + 2*a^2; 
[newxVals, newyVals] = drawEllipse(xRad, yRad, x,y); 
xVals = [xVals, newxVals]; 
yVals = [yVals, newyVals]; 
while deltPSE < (2*a^2 + 3*b^2)
    if (P < 0)
        P = P + deltPE; 
        deltPE = deltPE + delt2PE; 
        deltPSE = deltPSE + delt2PSE; 
    else 
        P = P + deltPSE; 
        deltPE = deltPE + delt2PE; 
        deltPSE = deltPSE + delt2PSE;
        y = y - 1; 
    end 
    x = x + 1; 
    [newxVals, newyVals] = drawEllipse(xRad, yRad, x,y); 
    xVals = [xVals, newxVals]; 
    yVals = [yVals, newyVals]; 
end
P = P - (a^2*(4*y - 3) + b^2*(4*x + 3) + 2)/4; 
deltPS = a^2*(3 - 2*y); 
deltPSE = 2*b^2 + 3*a^2; 
delt2PS = 2*a^2; 
while (y > 0)
    if ( P > 0)
        P = P + deltPE; 
        deltPE = deltPE + delt2PS; 
        deltPSE = deltPSE + delt2PS; 
    else 
        P = P + deltPSE; 
        deltPE = deltPE + delt2PS; 
        deltPSE = deltPSE + delt2PSE; 
        x = x + 1; 
    end
    y = y - 1; 
    [newxVals, newyVals] = drawEllipse(xRad, yRad, x,y); 
    xVals = [xVals, newxVals]; 
    yVals = [yVals, newyVals]; 
end
end





function [xVals, yVals] = drawEllipse(xRad, yRad, x,y)
    xVals = []; 
    yVals = []; 
    xVals = [xVals, (xRad + x)]; 
    yVals = [yVals, (yRad + y)]; 
    xVals = [xVals, (xRad + x)]; 
    yVals = [yVals, (yRad - y)]; 
    xVals = [xVals, (xRad - x)]; 
    yVals = [yVals, (yRad + y)]; 
    xVals = [xVals, (xRad - x)]; 
    yVals = [yVals, (yRad - y)]; 
end
    