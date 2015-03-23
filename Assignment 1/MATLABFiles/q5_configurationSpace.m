%q5 - configuration space
close all
clear
clc

mm = 10^-3;
DEGREES = pi/180;
RADIANS = 180/pi;

X = [-pi/3, pi/3];
Y = [-2*pi/3, 2*pi/3];
Z = [-pi/2, pi/2];

config_space_3dof(X,Y,Z);
