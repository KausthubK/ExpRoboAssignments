function [ab, d] = LSM(xpoint,ypoint)

%%%%replace this entire thing with polar coordinate LMS instead)

% %
% Ax = b (matrix calculations) where:
% 
% A = [Mean(xx) Mean(x)]
%     [Mean(x)  1      ]
% 
% x = [Mean(xy)]
%     [Mean(y) ]
%
% b = [gradient]
%     [intercept]


Mx=mean(xpoint);
My=mean(ypoint);

xy=times(xpoint,ypoint);
Mxy=mean(xy);

xx=times(xpoint,xpoint);
Mxx=mean(xx);

%assebles our matrices A and Vector x
A_mat = [Mxx , Mx; Mx, 1];
x_vec = [Mxy; My];

%finds the determinant of A (if this is zero ignore all the ab values)
d = det(A_mat);

ab = pinv(A_mat)*x_vec;
ab = ab';

end