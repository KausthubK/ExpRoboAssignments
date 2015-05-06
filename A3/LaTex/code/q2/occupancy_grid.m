clear
close all
clc

% load output from the obtain_obstacles code
positionData = load('laserPosiitons.txt');

xPos = positionData(:,1);
yPos = positionData(:,2);

%Get maximum and minimum x-y values
xMin = min(xPos);
xMax = max(xPos);

yMin = min(yPos);
yMax = max(yPos);

%define a square grid size
gridSize = 100;

grid = zeros(gridSize);

%Determine the difference between each grid location
yDiff = (yMax - yMin)/(gridSize - 2);
xDiff = (xMax - xMin)/(gridSize - 2);

%Determine which grid loaction each coordinate corresponds to.
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

%Generate occupancy grid
HeatMap(grid);