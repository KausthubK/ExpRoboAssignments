%test09
%vertical zig zag test (no error)
close all
clear
clc

diary 'test_results'
diary ON
% import basic test data
linearDataSetGenerator;

xvals = x_0to10;    %change these to change test data
yvals = nonperpzz;

%plot raw data
plot(xvals, yvals, 'rx'); %mark all true data values with red x

%plot our line approximation
errorThreshold = 0.1;
disp 'test09: non-perpendicular zigzag tst (no error)'                                        
vertices = lineseg(xvals, yvals, errorThreshold);
diary OFF