%
% Author: Stefan Williams (stefanw@acfr.usyd.edu.au)
%
%
%Modified by James Ferris to include ICP data in a plot

clear 
close all
clc

% load laser files
laser_scans=load('datasets\captureScanshornet.txt');

t0 = laser_scans(1,1);

%%
%Initialise ICP data
i = 20; %Let the 'initial guess' be starting point + 20, as in part A
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

%%

figure
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
     
     %%
     %Calculate ICP
     [deltaPose_bar, deltaPose_bar_Cov, N] = ICPv4(deltaPose, [xpoint;ypoint], [xB;yB]);
     newB = head2tail_no_theta(deltaPose_bar, [xB;yB]);
     new_xB = newB(1,:);
     new_yB = newB(2,:);  
     
     if i == 1 || mod(i,20)== 0

         Pose = deltaPose_bar;
         h = 0.5;
         Pose2 = [Pose(1)+h*cos(Pose(3)), Pose(2)+h*sin(Pose(3))];
         hold on     


         plot(xpoint(:), ypoint(:), '.');     

         plot(xB,yB,'r.')
         plot(new_xB,new_yB,'kx')

         plot(Pose(1),Pose(2),'gx');
         plot(Pose2(1),Pose2(2),'go');


         %%


         axis equal;

         legend('Robot Position', 'Robot Heading', 'Map','Initial Guess','ICP')
         axis([0 10 -5 5]);
         xlabel('X (meter)')
         ylabel('Y (meter)')
         title(sprintf('ACFR indoor SICK data: scan %d',i))
         drawnow
         
         pause
     end
     
     xB = new_xB;
     yB = new_yB;
     
     clf
         
end