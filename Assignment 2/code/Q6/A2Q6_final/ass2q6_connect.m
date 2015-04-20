function ass2q6_connect()

clear all;
close all;
clc;

%% SETUP CAMERA AND OBTAIN IMAGE
vid = videoinput('pointgrey',1, 'Mono8_640x480');
pause(1);
I = getsnapshot(vid);

%% INSERT IMAGE PROCESSING CODE HERE
%Should use image I, find cubes, and determine commands for arm
%
%
%
% I = imread('tt3.png');	%Can load an image from file instead of camera feed
imshow(I);
drawnow();
%
[CentroidsX, CentroidsY, OrientationAngle] = find_centroids_orientation_grey(I);
%
%


%% OPEN NETWORK CONNECTION
t=tcpip('192.168.0.1', 2020, 'NetworkRole', 'client');
fopen(t);


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

height = 0.1;

strings = zeros(11,8);
% t=1;
for i = 1:length(CentroidsX)
   
   sendCommand(t,'<h4>\n');
   sendCommand(t,'<o>\n');
   sendCommand(t,sprintf('<a%.0f>\n', OrientationAngle(i)));  
   sendCommand(t,sprintf('<x%.0f,y%.0f>\n',CentroidsX(i),CentroidsY(i)));
   sendCommand(t,'<h0>\n');
   sendCommand(t,'<c>\n');
   sendCommand(t,'<h4>\n');
   sendCommand(t,'<x0,y490>\n');
   sendCommand(t,'<a0>\n');
   sendCommand(t, sprintf('<h%.1f>\n', height));
   height = height + 1;   
   sendCommand(t,'<o>\n');
    
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



% CLOSE NETWORK PORT AND CAMERA
delete(vid)
fclose(t);

end