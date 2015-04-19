function lineDetails = leastsqmin(xpoint,ypoint)

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

if d == 0
	x-int = Mx;
	vertFlag = 1;
else
	x-int = (-1*ab(2))/ab(1);
	vertFlag = 0;
end


lineDetails = cat(2, ab, x-point);
lineDetails  = cat(2, lineDetails, vertFlag);

end