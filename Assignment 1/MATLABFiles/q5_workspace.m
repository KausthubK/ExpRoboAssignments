%q5 - workspace
%http://au.mathworks.com/help/fuzzy/examples/modeling-inverse-kinematics-in-a-robotic-arm.html
close all
clear
clc

mm = 10^-3;
DEGREES = pi/180;
RADIANS = 180/pi;

L1 = 250*mm;
L2= 250*mm;
L3 = 315*mm;

t1 = linspace(-pi/3,pi/3);
t2 = linspace(-2*pi/3, 2*pi/3);
t3 = linspace(-pi/2, pi/2);

[T1, T2, T3] = meshgrid(t1,t2,t3);

X = L1*cos(T1)+L2*cos(T1+T2)+L3*cos(T1+T2+T3);  %typo here put in final
Y = L1*sin(T1)+L2*sin(T1+T2)+L3*sin(T1+T2+T3);

plot(X(:), Y(:), 'r.'); %last column of X and Y
axis equal
grid
