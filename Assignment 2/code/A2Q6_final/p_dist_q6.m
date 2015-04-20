function [pDist] = p_dist_q6(B1,B2,u,v)

LP1=[B1(1,1),B1(1,2)];
LP2=[B2(1,1),B2(1,2)];

D=sqrt((LP2(1)-LP1(1))^2+(LP2(2)-LP1(2))^2);

r=(u*(LP1(2)-LP2(2))+v*(LP2(1)-LP1(1))+LP2(2)*LP1(1)-LP1(2)*LP2(1));

pDist=r/D;


end
