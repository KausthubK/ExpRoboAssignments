function THvUpd = updateStageCompass(THvPred, THvObs, alphaTH)

THvUpd = (1 - alphaTH)*THvPred + alphaTH*THvObs;

end