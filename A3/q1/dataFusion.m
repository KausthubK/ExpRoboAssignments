clear
close all
clc

DEGREES = 180/pi;
RADIANS = pi/180;

% % Prediction Stage

%Load data
velocityObs = load('velocityObs.txt');
positionObs = load('positionObs.txt');
compassObs = load('compassObs.txt');

%Get velocity data
time1 = (velocityObs(:,1)*10^6) + velocityObs(:,2); %get in microseconds
velocity = velocityObs(:,3);
turnRate = velocityObs(:,4);

velObs = [time1 velocity turnRate];

%Get GPS position data
time2 = (positionObs(:,1)*10^6) + positionObs(:,2);
xPos = positionObs(:,3);
yPos = positionObs(:,4);

posObs = [time2 xPos yPos];

%Get GPS compass data
time3 = (compassObs(:,1)*10^6) + compassObs(:,2);
heading = compassObs(:,3);

compObs = [time3 heading];

%%postInput parsing

alphaP = 0.5;
alphaTH = 0.5;

currTime = 0;
lastTime = 0;
deltaT = 0;

latestVel = 0;
latestTurnRate = 0;

ourX;
ourY;
ourHeading;

%%for loop starts
for i = i:length(velObs);    
   
%if velocityobs 

    if (velObs(i,1) <= posObs(i,1)) && (velObs(i,1) <= compObs(i,1))    %(velObs(i,1) <= laserObs(i,1))

        currTime = velObs(i,1);
        
        if i ~= 1
            deltaT = currTime - lastTime;
        end
                 
        latestV = velObs(i,2);%
        latestTurnRate = velObs(i,3);%
        pr = predictionStage(ourX, ourY, ourHeading, deltaT, latestTurnRate, latestVel);
        ourX = pr(1);
        ourY = pr(2);
        ourHeading = pr(3);
        lastTime = velObs(i,1);%
    end
    
%if GPS
    
    if (posObs(i,1) <= velObs(i,1)) && (posObs(i,1) <= compObs(i,1))    %(posObs(i,1) <= laserObs(i,1))
        
        currTime = posObs(i,1);

        if i ~= 1
            deltaT = currTime - lastTime;
        end

        pr = predictionStage(ourX, ourY, ourHeading, deltaT, latestTurnRate, latestVel);
        gUpd = updateStageGPS(pr(1), pr(2), posObs(i,2), posObs(i,3), alphaP) %xvobs and yvobs need to come from the file
        ourX = gUpd(1);
        ourY = gUpd(2);
        ourHeading = pr(3);
        lastTime = posOBs(i,1);%
    
    end
% if compass    

    if (compObs(i,1) <= velObs(i,1)) && (compObs(i,1) <= posObs(i,1))    %(compObs(i,1) <= laserObs(i,1))
        
        currTime = compObs(i,1);

        if i ~= 1
            deltaT = currTime - lastTime;
        end

        pr = predictionStage(ourX, ourY, ourHeading, deltaT, latestTurnRate, latestVel);
        cUpd = updateStageCompass(pr(3), compObs(i,2), alphaTH);
        ourX = pr(1);
        ourY = pr(2);
        ourHeading = cUpd;
        lastTime = compObs(i,1);
    
    end
% if laser data
    %%fill this in Kausthub

end
%%for loop ends



velocityPtr;
positionPtr;
compassPtr;
laserPtr;
i = 0;
j = 0;
k = 0;
l = 0;





% deltaT = zeros(length(time),1);
% 
% for i = 2:length(time)
%     deltaT(i) = time(i) - time(i-1);           
% end
% 
% predictions = zeros(length(velocity),3);
% 
% 
% %check this
% for i = 2:length(velocity)
%     
%     [ XvPred, YvPred, THvPred ] = predictionStage(predictions(i-1,1), predictions(i-1,2), predictions(i-1,3), deltaT(i), turnRate(i), velocity(i));
%     predictions(i,1) = XvPred;
%     predictions(i,2) = YvPred;
%     predictions(i,3) = THvPred;
%     
% end
% 
% velObs = [time deltaT predictions];
% 
% %convert to world coordinates!
% %......
% %?????
% 
% 
% % % Observation Stage
% % 
% beaconPosition = load('laserFeatures.txt');
% % -pi/2 to pi/2, half *degree* increments
% % range then intensity
% rangeIntensity = load('laserObs.txt');
% angle = -pi/2:(0.5*DEGREES):pi/2;
% observations = zeros(length(predictions), 3);
% % 
% % for i = 1:length(radii)
% %     
% %     [XvObs, YvObs, THvObs] = observationStage(beaconPosition(1,1), beaconPosition(2,1), beaconPosition(1,2), beaconPosition(2,2), radii(i,1), radii(i,2), angles(i,1), angles(i,2));
% %     observations(i,1) = XvObs;
% %     observations(i,2) = YvObs;
% %     observations(i,3) = THvObs;
% %     
% % end
% % 
% 
% 
% % % Update Stage
% % 
% % 
% % updated = zeros(length(predictions),3);
% % 
% % alphaP = 0.1;
% % alphaTH = alphaP;
% % 
% % for i = 1:length(updated)
% %     
% %     [XvUpd, YvUpd, THvUpd] = updateStage(predictions(i,1), predictions(i,2), predictions(i,3), observations(i,1), observations(i,2), observations(i,3), alphaP, alphaTH);
% %     updated(i,1) = XvUpd;
% %     updated(i,2) = YvUpd;
% %     updated(i,3) = THvUpd;
% %     
% % end
% % 
