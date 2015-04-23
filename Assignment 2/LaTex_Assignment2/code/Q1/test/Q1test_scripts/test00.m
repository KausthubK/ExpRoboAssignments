%test00
%horizontal line test (no error)
close all
clear
clc

diary './test_results'
diary ON
disp 'Q1 Test Result Corner Value outputs from LineSeg'
% import basic test data
linearDataSetGenerator;

xvals = x_0to10;    %change these to change test data
yvals = y_2;

%plot raw data
plot(xvals, yvals, 'rx'); %mark all true data values with red x

%plot our line approximation
errorThreshold = 0.1;
disp 'test00: horizontal line test (no error)'                                        
vertices = lineseg(xvals, yvals, errorThreshold);
diary OFF