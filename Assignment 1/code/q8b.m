%%Code to simultaneously solve for Angular acceleration 1 and 2, without reference to the other

close all;clear;clc;

% Torque 1&2
syms T1
syms T2
% Angles 1&2
syms theta1
syms theta2
% Angular Velocity 1&2
syms omega1
syms omega2
% Angular Acceleration 1&2
syms alpha1
syms alpha2

% Acceleration due to Gravity
g = 9.8;

% alpha1 = (T1 - alpha2*(0.7625 + 1.5*cos(theta2)) + omega1*omega2*(3*sin(theta2)) + omega2*3*sin(theta2) - 6.5*g*cos(theta1) + 1.5*g*cos(theta1 + theta2))/(5.1625 + 3*cos(theta2));
% alpha2 = (T2 - alpha1*(0.7625 + 1.5*cos(theta2) - omega1^2*(1.5*sin(theta2))) - 1.5*g*cos(theta1 + theta2))/0.2;
s = solve(alpha1 == (T1 - alpha2*(0.7625 + 1.5*cos(theta2)) + omega1*omega2*(3*sin(theta2)) + omega2*3*sin(theta2) - 6.5*g*cos(theta1) + 1.5*g*cos(theta1 + theta2))/(5.1625 + 3*cos(theta2)),alpha2 == (T2 - alpha1*(0.7625 + 1.5*cos(theta2) - omega1^2*(1.5*sin(theta2))) - 1.5*g*cos(theta1 + theta2))/0.2 ,alpha1,alpha2);

alpha1 = s.alpha1
alpha2 = s.alpha2

%% Function code for simulink - uses the equations found above to determine angular acceleration

% function [alpha1,alpha2] = fcn(omega1,theta1,T1,T2,theta2,omega2)
%#codegen

% alpha1 = (2*(3200*T1 - 12200*T2 + 226611*cos(theta1 + theta2) - 204048*cos(theta1) - 24000*T2*cos(theta2) + 9600*omega2*sin(theta2) + 353160*cos(theta1 + theta2)*cos(theta2) + 9600*omega1*omega2*sin(theta2)))/(5*(7320*omega1^2*sin(theta2) - 10800*cos(theta2) - 14400*cos(theta2)^2 + 14400*omega1^2*cos(theta2)*sin(theta2) + 2887));
% alpha2 = -(2*(12200*T1 - 82600*T2 + 1394982*cos(theta1 + theta2) - 777933*cos(theta1) - 1530360*cos(theta1)*cos(theta2) + 24000*T1*cos(theta2) - 48000*T2*cos(theta2) + 36600*omega2*sin(theta2) + 1059480*cos(theta1 + theta2)*cos(theta2) + 36600*omega1*omega2*sin(theta2) - 24000*T1*omega1^2*sin(theta2) + 72000*omega2*cos(theta2)*sin(theta2) - 353160*omega1^2*cos(theta1 + theta2)*sin(theta2) - 72000*omega1^2*omega2*sin(theta2)^2 - 72000*omega1^3*omega2*sin(theta2)^2 + 1530360*omega1^2*cos(theta1)*sin(theta2) + 72000*omega1*omega2*cos(theta2)*sin(theta2)))/(5*(7320*omega1^2*sin(theta2) - 10800*cos(theta2) - 14400*cos(theta2)^2 + 14400*omega1^2*cos(theta2)*sin(theta2) + 2887));
