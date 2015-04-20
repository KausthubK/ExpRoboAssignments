function lineDetails = leastsqmin(xpoint,ypoint, iStart, iEnd)

%input: xset, yset, index Start, index End
%output: grad, yint, xint, vertFlag

tempX = xpoint(iStart:iEnd);
tempY = ypoint(iStart:iEnd);

Mx=mean(tempX);

My=mean(tempY);

xy=times(tempX,tempY);
Mxy=mean(xy);

xx=times(tempX,tempX);
Mxx=mean(xx);

%assebles our matrices A and Vector x
A_mat = [Mxx , Mx; Mx, 1];
x_vec = [Mxy; My];

%finds the determinant of A (if this is zero ignore all the ab values)
d = det(A_mat);

ab = pinv(A_mat)*x_vec;
ab = ab';

if d == 0
	x_int = Mx;
	vertFlag = 1;
else
	x_int = (-1*ab(2))/ab(1);
	vertFlag = 0;
end


lineDetails = cat(2, ab, x_int);
lineDetails  = cat(2, lineDetails, vertFlag);

end