function [ab, d] = LSM(xpoint,ypoint)

Mx=mean(xpoint);
My=mean(ypoint);

xy=times(xpoint,ypoint);
Mxy=mean(xy);

xx=times(xpoint,xpoint);
Mxx=mean(xx)

A_mat = [Mxx , Mx; Mx, 1];
x_vec = [Mxy; My];

d = det(A_mat);

ab = pinv(A_mat)*x_vec;
ab = ab';

end