% test the ICP algorithm
% Author: Chieh-Chih (Bob) Wang [bob.wang@cas.edu.au]
% Created: April 12, 2005. 
% Last Modified: April 12, 2005.


clear 
close all
% load laser files
laser_scans=load('..\datasets\captureScanshornet.txt');
t0 = laser_scans(1,1);

% Scan A
i = 500;
xA = zeros(1);
yA = zeros(1);
for j = 2:size(laser_scans,2)
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
for j = 2:size(laser_scans,2)
 range = laser_scans(i,j) / 1000;
 bearing = ((j-1)/2 - 90)*pi/180;
 if (range < 75)
     xB = [xB range*cos(bearing)];
     yB = [yB range*sin(bearing)];
 end
end

deltaPose = zeros(3,1);

[deltaPose_bar, deltaPose_bar_Cov, N] = ICPv4(deltaPose, [xA;yA], [xB;yB]);

newB = head2tail_no_theta(deltaPose_bar, [xB;yB]);
new_xB = newB(1,:);
new_yB = newB(2,:);

figure
clf
hold on    
plot(xA,yA,'b+')
plot(xB,yB,'r.')
plot(new_xB,new_yB,'kx')
axis equal
legend('Map','initial guess','ICP')
xlabel('X (meter)')
ylabel('Y (meter)')
title('The ICP algorithm')