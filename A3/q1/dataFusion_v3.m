clear
close all
clc

DEGREES = 180/pi;
RADIANS = pi/180;
SUN = 1.496*10^8;
% % Prediction Stage
% diary './q1output'
%Load observational data
velocityObs = load('velocityObs.txt');
positionObs = load('positionObs.txt');
compassObs = load('compassObs.txt');
laserObs = load('laserObs.txt');

%Get velocity data
time1 = velocityObs(:,1) + (velocityObs(:,2)*10^-6) - 1115116000;%get in microseconds
velocity = velocityObs(:,3);
turnRate = velocityObs(:,4);

velObs = [time1 velocity turnRate];

%Get GPS position data
time2 = positionObs(:,1) + (positionObs(:,2)*10^-6) - 1115116000;
xPos = positionObs(:,3);
yPos = positionObs(:,4);

posObs = [time2 xPos yPos];

%Get GPS compass data
time3 = compassObs(:,1) + (compassObs(:,2)*10^-6) - 1115116000;
heading = compassObs(:,3);

compObs = [time3 heading];

% % %get laser data
time4 = laserObs(:,1) + (laserObs(:,2)*10^-6) - 1115116000;
% % i = 1;
% % j = 4;
% % sizeLas = size(laserObs);
% % lasObs = zeros(sizeLas(1, 2));
% % while(i <= sizeLas(1))
% %     lasObs(i, 1) = [time4(i)];
% %     while(j<=sizeLas(2))
% %         lasObs(i, j) = laserObs(i, j);
% %         lasObs(i, j-1) = laserObs(i, j-1);
% %         
% %         j = j + 2;
% %     end
% %     
% %     i = i + 1;
% % end
% % size(time4)



%%postInput parsing

alphaP = 0.1;
alphaTH = 0.1;

lastTime = 0;
deltaT = 0;

latestVel = 0;
latestTurnRate = 0;

ourX = 0;
ourY = 0;
ourHeading = 0;

indLengths = [length(time1), length(time2), length(time3), length(time4)];
maxIters = max(indLengths);

% output = [lastTime, ourX, ourY, ourHeading];
output = zeros(maxIters, 6);

% deadreckonedpts = zeros(maxIters, 3);

%iters [velInd, posInd, compInd, lasInd];
iters = [2, 2, 2, 2];
runFlags = [0, 0, 0, 0];
loopFlag = 1;
loopCount = 2;
%%loop starts
while(loopFlag == 1)
    loopCount = loopCount + 1;
    time = [time1(iters(1)), time2(iters(2)), time3(iters(3)), time4(iters(4)),];
    nextT = min(time);
    
    
    for i = 1:4
        if time(i) == nextT
            runFlags(i) = 1;
        else
            runFlags(i) = 0;
        end
    end
    
    %if velocityobs
    if(runFlags(1) == 1)
        deltaT = time1(iters(1)) - lastTime;              
        latestVel = velObs(iters(1),2);%
        latestTurnRate = velObs(iters(1),3);%
        pr = predictionStage(ourX, ourY, ourHeading, deltaT, latestTurnRate, latestVel);
        ourX = pr(1);
        ourY = pr(2);
        ourHeading = pr(3);
        
%         deadreckonedpts(1) = ourX;
%         deadreckonedpts(2) = ourY;
%         deadreckonedpts(3) = ourHeading;
        lastTime = time1(iters(1));%
        runFlags(1) = 0;
        if iters(1) == length(time1)
            time1(iters(1)) = SUN;
        else
            iters(1) = iters(1) + 1;
        end
    end
    
% % if GPS
     if(runFlags(2) == 1)
        deltaT = time2(iters(2)) - lastTime;
        pr = predictionStage(ourX, ourY, ourHeading, deltaT, latestTurnRate, latestVel);
        gUpd = updateStageGPS(pr(1), pr(2), posObs(iters(2),2), posObs(iters(2),3), alphaP); %xvobs and yvobs need to come from the file
        ourX = gUpd(1);
        ourY = gUpd(2);
        ourHeading = pr(3);
        lastTime = time2(iters(2));%
        runFlags(2) = 0;
        if iters(2) == length(time2)
            time2(iters(2)) = SUN;
        else
            iters(2) = iters(2) + 1;
        end
     end
%     
% % if compass    
     if(runFlags(3) == 1)
        deltaT = time3(iters(3)) - lastTime;
        pr = predictionStage(ourX, ourY, ourHeading, deltaT, latestTurnRate, latestVel);
        cUpd = updateStageCompass(pr(3), compObs(iters(3),2), alphaTH);
        ourX = pr(1);
        ourY = pr(2);
        ourHeading = cUpd;
        lastTime = time3(iters(3));
        runFlags(3) = 0;
        if iters(3) == length(time3)
            time3(iters(3)) = SUN;
        else
            iters(3) = iters(3) + 1;
        end
    end
%     
% % if laser data
    if(runFlags(4) == 1)
% %       fill this in
        runFlags(4) = 0;
        time4(iters(4)) = SUN;   %remove this line
    end

%check loop
    if(time1(iters(1)) == SUN)
        if(time2(iters(2)) == SUN)
            if(time3(iters(3)) == SUN)
                if(time4(iters(4)) == SUN)
                     loopFlag = 0;
                end
            end
        end
    end
    
%plot stuff
hold on
title('Robot Path');
xlabel('x-axis');
ylabel('y-axis');
% legend('')
drawnow

plot(ourX, ourY, 'r.');
output(loopCount, 1) = lastTime;
output(loopCount, 2) = ourX;
output(loopCount, 3) = ourY;
output(loopCount, 4) = ourHeading;
output(loopCount, 5) = latestVel;
output(loopCount, 6) = latestTurnRate;
end

% diary ON
% output
% diary OFF

output(:,1) = output(:,1); %+ 1115116000;