%
% Author: Stefan Williams (stefanw@acfr.usyd.edu.au)
%
%

clear 
clc
close all

% load laser files
laser_scans=load('laserObs.txt');
robot = load('q1Output1.txt');

t0 = laser_scans(1,1);

figure
% for k = 1: length(robot(:,1))
    
for i = 1:length(laser_scans)
     tlaser = laser_scans(i,1) - t0;
     tlaser = laser_scans(i,1) + (laser_scans(i,2)*10^-6) - 1115116000;
     
     tRobot = robot(i,1);
     xRobot = robot(i,2);
     yRobot = robot(i,3);
     headingRobot = robot(i,4);
     
     xpoint = zeros(1);
     ypoint = zeros(1);
     for j = 3:2:size(laser_scans,2)
         
         range = laser_scans(i,j) / 1000;
         bearing = ((j-1)/2 - 90)*pi/180;
         if (range < 8.0)
             xpoint = [xpoint  xRobot+range*cos(bearing + headingRobot)];
             ypoint = [ypoint  yRobot+range*sin(bearing + headingRobot)];
         end
         
     end
     plot(xpoint(:), ypoint(:), '.');
%      axis equal;
%      axis([0 10 -5 5]);
%      xlabel('X (meter)')
%      ylabel('Y (meter)')
%      title(sprintf('ACFR indoor SICK data: scan %d',i))
%      drawnow
end

% end

% vertices = lineseg(xpoint, ypoint, 0.1);


xPos = xpoint;
yPos = ypoint;

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

HeatMap(grid);