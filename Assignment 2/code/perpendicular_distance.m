function pDist = perpendicular_distance(PT,LP1,LP2)

D=sqrt((LP2(1)-LP1(1))^2+(LP2(2)-LP1(1))^2);

r=PT(1)*(LP1(2)-LP2(2))+PT(2)*(LP2(1)-LP1(1))+LP2(2)*LP1(1)-LP2(1)*LP1(2);

pDist=r/D;

end
