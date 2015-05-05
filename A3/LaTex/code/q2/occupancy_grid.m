clear
close all
clc

% positionData = load('q1output1.txt');
positionData = load('q2Output4.txt');


% xPos = positionData(:,2);
% yPos = positionData(:,3);

xPos = positionData(:,1);
yPos = positionData(:,2);

xMin = min(xPos);
xMax = max(xPos);

yMin = min(yPos);
yMax = max(yPos);


gridSize = 100;

grid = zeros(gridSize);


yDiff = (yMax - yMin)/(gridSize - 2);
xDiff = (xMax - xMin)/(gridSize - 2);

for i = 1:length(xPos)
    tmpX = xPos(i);
    tmpY = yPos(i);
    j = 1;
    while (tmpX > xMin)
        tmpX = tmpX - xDiff; 
        j = j + 1;
    end
    k = 1;
    while (tmpY > yMin)
        tmpY = tmpY - yDiff; 
        k = k + 1;
    end
    
    grid(j,k) = grid(j,k) + 1;
end

% imagesc(grid);
HeatMap(grid);