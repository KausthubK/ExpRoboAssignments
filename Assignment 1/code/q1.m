close all
clear
clc

DEGREES = pi/180;
RADIANS = 180/pi;


fprintf('a)\n');
roll = 10*DEGREES; %alpha
pitch = 20*DEGREES; %beta
yaw = 30*DEGREES; %gamma

aPb = [1 2 3];
aRb = [cos(roll)*cos(pitch), cos(roll)*sin(pitch)*sin(yaw)-sin(roll)*cos(yaw), cos(roll)*sin(pitch)*cos(yaw)+sin(roll)*sin(yaw);
    sin(roll)*cos(pitch), sin(roll)*sin(pitch)*sin(yaw)+cos(roll)*cos(yaw), sin(roll)*sin(pitch)*cos(yaw)-cos(roll)*sin(yaw);
    -sin(pitch), cos(pitch)*sin(yaw), cos(pitch)*cos(yaw)];
%transpose(aPb)

aTb = [aRb transpose(aPb); 0 0 0 1]


fprintf('b)\n');

roll = 10*DEGREES; %alpha
pitch = 30*DEGREES; %beta
yaw = 30*DEGREES; %gamma

aPb = [3 0 0];
aRb = [cos(roll)*cos(pitch), cos(roll)*sin(pitch)*sin(yaw)-sin(roll)*cos(yaw), cos(roll)*sin(pitch)*cos(yaw)+sin(roll)*sin(yaw);
    sin(roll)*cos(pitch), sin(roll)*sin(pitch)*sin(yaw)+cos(roll)*cos(yaw), sin(roll)*sin(pitch)*cos(yaw)-cos(roll)*sin(yaw);
    -sin(pitch), cos(pitch)*sin(yaw), cos(pitch)*cos(yaw)];
%transpose(aPb)

aTb = [aRb transpose(aPb); 0 0 0 1]

fprintf('c)\n');

roll = 90*DEGREES; %alpha
pitch = 180*DEGREES; %beta
yaw = -90*DEGREES; %gamma

aPb = [0 0 1];
aRb = [cos(roll)*cos(pitch), cos(roll)*sin(pitch)*sin(yaw)-sin(roll)*cos(yaw), cos(roll)*sin(pitch)*cos(yaw)+sin(roll)*sin(yaw);
    sin(roll)*cos(pitch), sin(roll)*sin(pitch)*sin(yaw)+cos(roll)*cos(yaw), sin(roll)*sin(pitch)*cos(yaw)-cos(roll)*sin(yaw);
    -sin(pitch), cos(pitch)*sin(yaw), cos(pitch)*cos(yaw)];
%transpose(aPb)

aTb = [aRb transpose(aPb); 0 0 0 1]

roll = 90*DEGREES; %alpha
pitch = 180*DEGREES; %beta
yaw = 270*DEGREES; %gamma

aPb = [0 0 1];
aRb = [cos(roll)*cos(pitch), cos(roll)*sin(pitch)*sin(yaw)-sin(roll)*cos(yaw), cos(roll)*sin(pitch)*cos(yaw)+sin(roll)*sin(yaw);
    sin(roll)*cos(pitch), sin(roll)*sin(pitch)*sin(yaw)+cos(roll)*cos(yaw), sin(roll)*sin(pitch)*cos(yaw)-cos(roll)*sin(yaw);
    -sin(pitch), cos(pitch)*sin(yaw), cos(pitch)*cos(yaw)];
%transpose(aPb)

aTb = [aRb transpose(aPb); 0 0 0 1]
