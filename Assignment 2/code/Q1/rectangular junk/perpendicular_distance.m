function [pDist] = perpendicular_distance(xpoint,ypoint,a,b)
 
LP1=[-b/a,0];
LP2=[0,b];
D=sqrt((LP2(1)-LP1(1))^2+(LP2(2)-LP1(2))^2);

r=(xpoint*(LP1(2)-LP2(2))+ypoint*(LP2(1)-LP1(1))+LP2(2)*LP1(1)-LP1(2)*LP2(1));

pDist=r/D;


end
