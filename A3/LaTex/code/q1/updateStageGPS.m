function gUpd = updateStageGPS(XvPred, YvPred, XvObs, YvObs, alphaP)

XvUpd = (1 - alphaP)*XvPred + alphaP*XvObs;
YvUpd = (1 - alphaP)*YvPred + alphaP*YvObs;
gUpd = [XvUpd, YvUpd];
end

