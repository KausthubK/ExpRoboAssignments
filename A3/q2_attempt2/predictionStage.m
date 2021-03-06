function pr = predictionStage( XvPrev, YvPrev, THvPrev, deltaT, currTurnRate, currVel )
%Prediction Function given previous values
    XvPred = XvPrev + deltaT*currVel*cos(THvPrev);
    YvPred = YvPrev + deltaT*currVel*sin(THvPrev);
    THvPred = THvPrev + deltaT*currTurnRate;
    pr = [XvPred, YvPred, THvPred];
end