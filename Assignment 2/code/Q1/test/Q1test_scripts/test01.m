%test01
%vertical line test (no error)
close all
clear
clc

diary 'test_results'
diary ON

% import basic test data
linearDataSetGenerator;

xvals = x_2;    %change these to change test data
yvals = y_0to10;

%plot raw data
plot(xvals, yvals, 'rx'); %mark all true data values with red x

%plot our line approximation
errorThreshold = 0.1;
disp 'test01: vertical line test (no error)'                                        
vertices = lineseg(xvals, yvals, errorThreshold);
diary OFF