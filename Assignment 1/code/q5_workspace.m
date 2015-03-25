%%Q5 - Determine the workspace of the system
close all;clear;clc

%Declare constants
mm = 10^-3;
L1 = 250*mm;
L2= 250*mm;
L3 = 315*mm;

%Generate an array of 100 values for each boundary conditions
theta1 = linspace(-pi/3,pi/3,100);
theta2 = linspace(-2*pi/3, 2*pi/3,100);
theta3 = linspace(-pi/2, pi/2,100);

%Create a grid matrix of the boundary values
[THETA1, THETA2, THETA3] = meshgrid(theta1,theta2,theta3);

%Using the above grid matrix, find X and Y
X = L1*cos(THETA1)+L2*cos(THETA1+THETA2)+L3*cos(THETA1+THETA2+THETA3);
Y = L1*sin(THETA1)+L2*sin(THETA1+THETA2)+L3*sin(THETA1+THETA2+THETA3);

%Take the final column of the resulting X and Y matrices
%These are the coordinates for a scatter plot
plot(X(:), Y(:), 'r.');
axis equal
grid
xlabel('x');
ylabel('y');
title('Workspace of the System');

%http://au.mathworks.com/help/fuzzy/examples/modeling-inverse-kinematics-in-a-robotic-arm.html
