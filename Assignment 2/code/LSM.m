function ab = LSM(xpoint,ypoint)

Mx=mean(xpoint);
My=mean(ypoint);

xy=times(xpoint,ypoint);
Mxy=mean(xy);

xx=times(xpoint,ypoint);
Mxx=mean(xx);

a=Mxy/(Mxx+Mx);

b=My/(Mx+1);

ab = [a, b];

end