% test the ICP algorithm
% Author: Chieh-Chih (Bob) Wang [bob.wang@cas.edu.au]
% Created: April 12, 2005. 
% Last Modified: April 12, 2005.
%
%Modified by James Ferris to Show ICP data in a plot


clear 
close all
clc

% load laser files
laser_scans=load('datasets\captureScanshornet.txt');
t0 = laser_scans(1,1);

% Scan A
i = 500;
xA = zeros(1);
yA = zeros(1);
for j = 2:size(laser_scans,2)   %Map
 range = laser_scans(i,j) / 1000;
 bearing = ((j-1)/2 - 90)*pi/180;
 if (range < 75)
     xA = [xA range*cos(bearing)];
     yA = [yA range*sin(bearing)];
 end
end

% Scan B
i = 520;
xB = zeros(1);
yB = zeros(1);
for j = 2:size(laser_scans,2)   %Initial Guess (source? stay 'constant'? trasformed by ICP)
 range = laser_scans(i,j) / 1000;
 bearing = ((j-1)/2 - 90)*pi/180;
 if (range < 75)
     xB = [xB range*cos(bearing)];
     yB = [yB range*sin(bearing)];
 end
end

deltaPose = zeros(3,1);

[deltaPose_bar, deltaPose_bar_Cov, N] = ICPv4(deltaPose, [xA;yA], [xB;yB]); %ICP

%%
%Added to show robot position and orientation
figure
clf
hold on  
Pose = deltaPose_bar;
h = 0.5;
Pose2 = [Pose(1)+h*cos(Pose(3)), Pose(2)+h*sin(Pose(3))];
plot(Pose(1),Pose(2),'gx');
plot(Pose2(1),Pose2(2),'go');
%%

newB = head2tail_no_theta(deltaPose_bar, [xB;yB]);
new_xB = newB(1,:);
new_yB = newB(2,:);
  
plot(xA,yA,'b+')
plot(xB,yB,'r.')
plot(new_xB,new_yB,'kx')
axis equal
legend('Robot Position', 'Robot Heading', 'Map','Initial Guess','ICP')
xlabel('X (meter)')
ylabel('Y (meter)')
title('The ICP algorithm')