function [XvUpd, YvUpd, THvUpd] = updateStage(XvPred, YvPred, THvPred, XvObs, YvObs, THvObs, alphaP, alphaTH)

XvUpd = (1 - alphaP)*XvPred + alphaP*XvObs
YvUpd = (1 - alphaP)*YvPred + alphaP*YvObs
THvUpd = (1 - alphaTH)*THvPred + alphaTH*THvObs

end