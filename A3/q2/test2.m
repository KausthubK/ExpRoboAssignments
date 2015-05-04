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
 
f1=1;
f2=3;


range = zeros(length(laserObs), (size(laserObs,2)-2)/2);
intensity = zeros(length(laserObs), (size(laserObs,2)-2)/2);
% test_x=X(1,1);
% test_y=Y(1,1);
% test_heading=heading(1,1);

%Extracting range & intensity data from LaserObs
for i=1:length(laserObs)
    
   while f2<size(laserObs,2)
    range(i,f1)=laserObs(i,f2);
    intensity(i,f1)=laserObs(i,f2+1);
    f1=f1+1;  
    f2=f2+2;
   end
   
end

%Transformation matrix
x_f=zeros(length(range),size(range,2));
y_f=zeros(length(range),size(range,2));

for i=1:length(range)
    
    for colm=1:size(range,2)
    
        x_f(i,colm)=X(i)+range(i,colm)*cos((colm*0.5)-heading(i));
        y_f(i,colm)=Y(i)+range(i,colm)*sin((colm*0.5)-heading(i));

    end

end

x_f=x_f+7.999;
y_f=y_f+8.2572;

LabDim=100;
workspace=zeros(LabDim);   %configure the workspace

%Assume 10 values= 1m 

% 
% for i=1:length(x_f)
%     for j=1:size(x_f,2)
%         if range(i,j)<8
%             hold on
%             plot(x_f(i,j),y_f(i,j),'.');
% 
%         end
%     end
% end


    
    
    
    
    
    
    
    
    
    
%methodology

% xReal=x_robot+distance*cos(angle_sensor-robot_orientation)
% yReal=y_robot+distance*sin(angle_sensor-robot_orientation)
% use the intensity given to determine the obstacle
%change xReal and yReal data with intensities in a determined LabDim vector equals to the workspace

