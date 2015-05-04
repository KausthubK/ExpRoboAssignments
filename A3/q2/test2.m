close all
clear
clc

laserObs=load('laserObs.txt');
laserFeatureObs=load('laserFeatures.txt');
posObs=load('positionObs.txt');
positions=load('posValues.txt');

%Angular resolution= 0.5degrees  Intervals 361
%range=-pi/2 to pi/2 (scan angle=180) with x axis forward   =====> Beta=pi/2
%max= 8m intensity(0-1) =======> R=8m

%loading postions into X Y and Heading variables
X=positions(:,1);
Y=positions(:,2);
heading=positions(:,3);

f=1;
i=1;
j=3;
range = zeros(length(laserObs), (size(laserObs,2)-2)/2);
intensity = zeros(length(laserObs), (size(laserObs,2)-2)/2);
% test_x=X(1,1);
% test_y=Y(1,1);
% test_heading=heading(1,1);
while i<length(laserObs)

   while j<size(laserObs,2)
    range(i,f)=laserObs(i,j);
    intensity(i,f)=laserObs(i,j+1);
    f=f+1;  
    j=j+2;
   end
   i = i + 1;
end

LabDim=100;
workspace=zeros(LabDim);   %configure the workspace


%methodology

% xReal=x_robot+distance*cos(angle_sensor-robot_orientation)
% yReal=y_robot+distance*sin(angle_sensor-robot_orientation)
% use the intensity given to determine the obstacle
%change xReal and yReal data with intensities in a determined LabDim vector equals to the workspace

