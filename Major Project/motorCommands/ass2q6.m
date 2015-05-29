function ass2q6()

clear all;
close all;
clc;


%% SETUP CAMERA AND OBTAIN IMAGE
vid = videoinput('pointgrey',1,'Mono8_640x480');
% triggerconfig(vid, 'Manual')
% vid.FramesPerTrigger = 1;
% set(vid,'TriggerRepeat', Inf);
% start(vid);
% vid.ReturnedColorspace = 'rgb';

pause(1);
% trigger(vid)
% % figure('Position',get(0,'ScreenSize'));
I = getsnapshot(vid);
imwrite(I,'test_image18.png');
imshow(I);
% delete(vid)
% clear vid

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

%% OPEN NETWORK CONNECTION
t=tcpip('192.168.0.1', 2020, 'NetworkRole', 'client');
fopen(t);

%Example code
% sendCommand(t,'<o>\n')		%Open gripper
% sendCommand(t,'<x0,y490>\n')	%Move to (0,490)
% sendCommand(t,'<c>\n')		%Close gripper
% sendCommand(t,'<x0,y390>\n')	%Move to (0,390)
% sendCommand(t,'<o>\n')		%Open gripper
% sendCommand(t,'<h2>\n')		%Set tool height to 2 cubes
% sendCommand(t,'<a45>\n')	%Set tool angle to 45 deg
towerHeight=0;
gripperCoords='<x0,y0>\n';
towerCoords='<x0,y490>\n';
openGripper='<o>\n';
closeGripper='<c>\n';
toolAngle='<a90>\n';
pickupHeight='<h0>\n';
toolHeight='<h1>\n';

sendCommand(t,openGripper);     %open gripper
sendCommand(t,toolHeight);		%Set tool height to 1 cubes
sendCommand(t,toolAngle);	%Set tool angle to 90 deg

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

