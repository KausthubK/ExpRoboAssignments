%test04
%inverse V LSM test (no error)
close all
clear
clc

diary 'test_results'
diary ON
% import basic test data
linearDataSetGenerator;

xvals = x_0to10;    %change these to change test data
yvals = y_inverseV;

%plot raw data
plot(xvals, yvals, 'rx'); %mark all true data values with red x

%plot our line approximation
errorThreshold = 0.1;   
disp 'test04: vertical inverse V LSM test (no error)'                                        
vertices = lineseg(xvals, yvals, errorThreshold);
diary OFF