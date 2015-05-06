function [XvObs, YvObs, THvObs] = observationStage(Tx1, Tx2, Ty1, Ty2, R1, R2, TH1, TH2)

THv = atan((Ty2-Ty1)/(Tx2-Tx1)) - atan((R2*sin(TH2) - R1*sin(TH1))/(R2*cos(TH2)-R1*cos(TH1)));
Xv = Tx1 - R1*cos(TH1+THv);
Yv = Ty1 - R1*sin(TH1+THv);

end