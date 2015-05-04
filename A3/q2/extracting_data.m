close all
clear
clc

laserObs=load('laserObs.txt');


f1=1;


range = zeros(length(laserObs), (size(laserObs,2)-2)/2);
intensity = zeros(length(laserObs), (size(laserObs,2)-2)/2);

%Extracting range & intensity data from LaserObs
for i=1:length(laserObs)  
   for f2=3:2:size(laserObs,2)
    range(i,f1)=laserObs(i,f2);
    intensity(i,f1)=laserObs(i,f2+1);
    f1=f1+1;
   end
   f1=1;
end
