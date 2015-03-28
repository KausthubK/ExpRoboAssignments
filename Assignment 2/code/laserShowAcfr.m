%
% Author: Stefan Williams (stefanw@acfr.usyd.edu.au)
%
%

clear 
close all

% load laser files
laser_scans=load('..\datasets\captureScanshornet.txt');

t0 = laser_scans(1,1);

%figure
for i = 1:length(laser_scans)
     tlaser = laser_scans(i,1) - t0;
     xpoint = zeros(1);
     ypoint = zeros(1);
     for j = 2:size(laser_scans,2)
         range = laser_scans(i,j) / 1000;
         bearing = ((j-1)/2 - 90)*pi/180;
         if (range < 75)
             xpoint = [xpoint range*cos(bearing)];
             ypoint = [ypoint range*sin(bearing)];
         end
     end
     %dataPoint=[xpoint,ypoint];
     %dataSet(i,j-1,1)=datapoint(1);
     
     %plot(xpoint(:), ypoint(:), '.');
     %axis equal;
     %axis([0 10 -5 5]);
     %xlabel('X (meter)')
     %ylabel('Y (meter)')
     %title(sprintf('ACFR indoor SICK data: scan %d',i))
     %drawnow
end

[a,b]=LSM(xpoint,ypoint);  %find a,b of the line y=ax+b using least_squares_minimization
pDist=perpendicular_distance(xpoint,ypoint,a,b);  %Find perpendicular_distance from each point to the assumed line
