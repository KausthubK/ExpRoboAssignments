clear
close all
clc



velocityObs = load('velocityObs.txt');


time = (velocityObs(:,1)*10^6) + velocityObs(:,2); %get in microseconds
velocity = velocityObs(:,3);
turnRate = velocityObs(:,4);
deltaT = zeros(length(time),1);
for i = 2:length(time)
    deltaT(i) = time(i) - deltaT(i-1);           
end