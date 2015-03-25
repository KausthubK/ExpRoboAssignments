%%Q5 - Determine the Configuration Space of the System
close all;clear;clc

%Declare the boundaries of the angles (theta1, theta2, theta3)
theta1 = [-pi/3, pi/3];
theta2 = [-2*pi/3, 2*pi/3];
theta3 = [-pi/2, pi/2];

%Send to a function that will generate the graph
config_space_3dof(theta1, theta2, theta3);
title('Configuration Space of the System');
xlabel('-pi/3 < theta1 < pi/3');
ylabel('-2pi/3 < theta2 < 2pi/3');
zlabel('-pi/2 < theta3 < pi/2');
