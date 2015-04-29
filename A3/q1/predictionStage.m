function [xKpre, yKpre, thetaKpre] = predictionStage (deltaT, veloK, thetaKdot, thetaK_1pre, xK_1pre, yK_1pre)

    xKpre = xK_1pre + deltaT*veloK*cos(thetaK_1);
    yKpre = yK_1pre + deltaT*veloK*sin(thetaK_1);
    thetaKpre = thetaK_1pre + deltaT*thetaKdot;
    
end
