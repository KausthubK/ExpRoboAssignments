%Assignment_3 
%1) DATA FUSION *target: estimate of the robot's posiotion.
%input:encorder data(velocity) , Compass data(turnrate) (VelocityObs.txt)
%Prediction as a low pass filter
%GPS(position.txt),Laser stips(laserFeatures.txt: Bearing to beacons)

close all
clear
clc
velObs=load('velocityObs.txt');
compObs=load('compassObs.txt');
posObs=load('positionObs.txt');
laserFeatureObs=load('laserFeatures.txt');


initial = velObs(1,1) + velObs(1,2)/1000000; %initial velocity
pos= zeros(length(velObs),3); %assigning a variable to position for X,Y,Turnrate for operation
%posStore=zeros(1,3); %assigning a veriable to store predicted values X,Y,Turnrate

for i=2:size(velObs,1)
    
    %delta time
    time1=velObs(i,1)+velObs(i,2)/1000000;
    if i==2;
        time0=initial;
    else
    time0=velObs(i-1,1)+velObs(i-1,2)/1000000;
    end
    dt=time1-time0;
    
    %Inputs
    V=velObs(i,3); %velocity
    TR=velObs(i,4); %turb rate
    [X,Y,Yaw]=position_prediction(pos(i-1,1),pos(i-1,2),pos(i-1,3),V,dt,TR); %call the function to predict position
    pos(i,1)=X; 
    pos(i,2)=Y;
    pos(i,3)=Yaw;
    
end

%plot path estimate
figure
hold on
plot(pos(:,1), pos(:,2),'b*');

