function ass2q6()

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

%Example code
sendCommand(t,'<o>\n')		%Open gripper
sendCommand(t,'<x0,y490>\n')	%Move to (0,490)
sendCommand(t,'<c>\n')		%Close gripper
sendCommand(t,'<x0,y390>\n')	%Move to (0,390)
sendCommand(t,'<o>\n')		%Open gripper
sendCommand(t,'<h2>\n')		%Set tool height to 2 cubes
sendCommand(t,'<a45>\n')	%Set tool angle to 45 deg



%% CLOSE NETWORK PORT AND CAMERA
delete(vid)
fclose(t);

end


%Wrapper function to send command and wait for response from arm controller
function sendCommand(t,command)

    %Send command to TCPIP port
    fprintf(t,command)

    %Pause until a message is received
    while(~t.BytesAvailable)
    end
    %Then flush the input buffer
    flushinput(t)
end

