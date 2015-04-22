%
% Author: Chieh-Chih (Bob) Wang [bobwang@cs.cmu.edu, bob.wang@cas.eud.au]
% Created: Oct. 25, 2002
% Modified: April 12, 2005

clear all

SICK_filename = '..\datasets\Loop2\SICKFront.txt';

% Loading SICK data
disp('Loading SICK data')
tempdata = load(SICK_filename);
N_scan = size(tempdata,1)/363;
SICK.data = zeros(N_scan,361);
SICK.time = zeros(N_scan,1);
for i=1:N_scan
    SICK.data(i,:) = tempdata(1+(i-1)*363:361+(i-1)*363)'/100; % cm -> meter    
    SICK.time(i,1) = tempdata(362+(i-1)*363) +tempdata(363+(i-1)*363)/1000000; % sec
end
clear tempdata;

% Displaying SICK data
disp('Displaying SICK data')
angle = 90:-0.5:-90;
angle = angle*pi/180; 
for i=1:N_scan
    x = SICK.data(i,:).*cos(angle);
    y = SICK.data(i,:).*sin(angle);    
    figure(1)
    clf
    hold on    
    plot(y,x,'.')
    axis([-40 40 0 60])
    xlabel('Y (meter)')
    ylabel('X (meter)')
    title(sprintf('Navlab urban SICK data: scan %d',i))
    drawnow
end

