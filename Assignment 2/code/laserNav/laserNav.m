close all
clear

% load data
velObs=load('velocityObs.txt');
posObs=load('positionObs.txt');
compassObs=load('compassObs.txt');
laserObs=load('laserObs.txt');
%fid = fopen('laserObs.txt');

lasttime = velObs(1,1) + velObs(1,2)/1000000;

pos = zeros(3,1);

k = 1;

figure
axis([-20 20 -20 20]);
axis equal;
hold on;
posHandle = plot(pos(1), pos(2), '*');
set(posHandle, 'EraseMode','xor');

posStorage = zeros(3,1);

% read in the first laser line
laserSec = 0; laseruSec = 0;
%fscanf(fid, '%d %d', [laserSec, laseruSec]);
lasertime = laserObs(1,1) + laserObs(1,2)/1000000;
scan = zeros(722,1);
scanHandle = plot(scan(1:8:722), '.');
set(scanHandle, 'EraseMode', 'xor');

for i = 2:size(velObs,1)
    % compute delta time
    time = velObs(i,1) + velObs(i,2)/1000000;
    dt = time - lasttime;
 
    % perform a prediction
    Vel = velObs(i,3);
    dYaw = velObs(i,4);
    pos = doPrediction(pos, Vel, dYaw, dt);
    posStorage = [posStorage pos];

    set(posHandle, 'Xdata',pos(1),'Ydata', pos(2));
    lasttime = time;  
    
    if (lasertime >= lasttime & k < size(laserObs,1) - 1)
        % take a laser observation
        Ranges = laserObs(k, 3:2:724);
        Bearings = -pi/2:0.5*pi/180:pi/2;
        laserPositions = [pos(1) + Ranges.*cos(Bearings + pos(3)); pos(2) + Ranges.*sin(Bearings + pos(3))];
        set(scanHandle, 'Xdata', laserPositions(1,1:4:361), 'Ydata', laserPositions(2,1:4:361));
        
        % read the timestamp of the next laser line
        k = k + 1;
        lasertime = laserObs(k,1) + laserObs(k,2)/1000000;
    end
    drawnow;
end

% plot resulting path estimates
figure
hold on
plot(posStorage(1,:), posStorage(2,:),'b.');
plot(posObs(:,3), posObs(:,4), 'g.');
legend('Vel/Turn', 'Odom');
xlabel('X(m)');
ylabel('Y(m)');


