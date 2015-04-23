function ass2q6_connect()

clear all;
close all;
clc;

%% OPEN NETWORK CONNECTION
t=tcpip('192.168.0.1', 2020, 'NetworkRole', 'client');
fopen(t);

%% SETUP CAMERA AND OBTAIN IMAGE
vid = videoinput('pointgrey',1, 'Mono8_640x480');
pause(1);
I = getsnapshot(vid);

%% INSERT IMAGE PROCESSING CODE HERE
%Should use image I, find cubes, and determine commands for arm
%
%
%
%I = imread('imagename.png')	%Can load an image from file instead of camera feed
imshow(I);
drawnow();
%
[CentroidsX, CentroidsY, OrientationAngle] = find_centroids_orientation_grey(I);
%
%



%% CONTROL ARM
%Should send out commands via TCPIP as strings (format below)

%command_string = '<x0,y260>\n'
%sendCommand(t,command_string)      %Send command string to robot via network

%Include brackets in command

%Full list of commands: 
% <x0,y360>\n = PositionTool(0,360)
% <h0>\n = setToolHeight(0)
% <a90>\n = setToolAngle(90)
% <o>\n = OpenGripper
% <c>\n = CloseGripper

height = 1;

strings = zeroes(11,8);

for i = 1:length(CentroidsX)
   
   strings(1,i) = '<h5>\n';
   strings(2,i) = '<o>\n';   
   strings(3,i) = sprintf('<a%d>\n', OrientationAngle(i));   
   strings(4,i) = sprintf('<x%d,y%d>\n',CentroidsX(i),CentroidsY(i));
   strings(5,1) = '<h1>\n';
   strings(6,i) = '<c>\n';
   strings(7,i) = '<h5>\n';
   strings(8,i) = '<x0,y490>\n';
   strings(9,i) = '<a0>\n';
   strings(10,i) = sprintf('<h%d>\n', height);
   height = height + 1;   
   strings(11,i) = '<o>\n';
    
end

for i = 1:8
    for k = i:11
        sendCommand(t, strings(k,i));
    end
end
%Example code
% sendCommand(t,'<o>\n')		%Open gripper
% sendCommand(t,'<x0,y490>\n')	%Move to (0,490)
% sendCommand(t,'<c>\n')		%Close gripper
% sendCommand(t,'<x0,y390>\n')	%Move to (0,390)
% sendCommand(t,'<o>\n')		%Open gripper
% sendCommand(t,'<h2>\n')		%Set tool height to 2 cubes
% sendCommand(t,'<a45>\n')	%Set tool angle to 45 deg



%% CLOSE NETWORK PORT AND CAMERA
delete(vid)
fclose(t);

end