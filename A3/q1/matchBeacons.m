function mb = matchBeacons(ourX, ourY, ourHeading, lasFeat, thisrange, beaconCentreInds)
% Summary of this function goes here
%   Detailed explanation goes here
    beta1 = degtorad(beaconCentreInds(1)/2);
    beta2 = degtorad(beaconCentreInds(2)/2);
    
    if(beaconCentreInds(1) < pi/2)
        theta1 = pi/2 - beta1;
    else
        theta1 = beta1 - pi/2;
    end
    
    
    if(beaconCentreInds(1) < pi/2)
        theta2 = pi/2 - beta2;
    else
        theta2 = beta2 - pi/2;
    end
    
    Tx1 = ourX + thisrange(1,beaconCentreInds(2))*cos(theta1+ourHeading);
    Ty1 = ourY + thisrange(1,beaconCentreInds(2))*sin(theta1+ourHeading);
    T1 = [Tx1 Ty1];
    lf = lasFeat;
    distances = sqrt(sum(bsxfun(@minus, lf, T1).^2,2));
    T1 = lf(find(distances==min(distances)),:);
    
    
    Tx2 = ourX + thisrange(1,beaconCentreInds(3))*cos(theta2+ourHeading);
    Ty2 = ourY + thisrange(1,beaconCentreInds(3))*sin(theta2+ourHeading);
    T2 = [Tx2 Ty2];
    lf = lasFeat;
    distances = sqrt(sum(bsxfun(@minus, lf, T2).^2,2));
    T2 = lf(find(distances==min(distances)),:);
    
    Tx1 = T1(1);
    Ty1 = T1(2);
    Tx2 = T2(1);
    Ty2 = T2(2);
    
    ourHeading = atan((Ty2-Ty1)/Tx2-Tx1) - atan(thisrange(beaconCentreInds(3))*sin(theta2+ourHeading)-thisrange(beaconCentreInds(2))*sin(theta1+ourHeading))/(thisrange(beaconCentreInds(3))*cos(theta2+ourHeading)-thisrange(beaconCentreInds(2))*cos(theta1+ourHeading));
    ourX = Tx1 - thisrange(beaconCentreInds(2))*cos(theta1+ourHeading);
    ourY = Ty1 - thisrange(beaconCentreInds(2))*sin(theta1+ourHeading);

    mb = [ourX, ourY, ourHeading];
end

