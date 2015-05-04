function THvUpd = updateStageCompass(THvPred, THvObs, alphaTH)
a = abs(THvObs - THvPred);
while(a > pi)
    if(THvObs > THvPred)
        THvObs = THvObs - 2*pi;
        THvPred = THvPred + 2*pi;
    else
        THvObs = THvObs + 2*pi;
        THvPred = THvPred - 2*pi;
    end
    a = abs(THvObs - THvPred);   
end

%THvUpd = (1 - alphaTH)*THvPred + alphaTH*THvObs;
THvUpd = THvPred - alphaTH*(THvObs - THvPred);

end