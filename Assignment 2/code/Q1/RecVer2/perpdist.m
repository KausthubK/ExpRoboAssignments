finction perpDist = perpdist(p_x, p_y, grad, y_int, x_int, vertFlag)
	
	if vertFlag == 1
		perpDist = abs(p_x-x_int);
	else
		num = abs(p_y-(grad*p_x)-y_int);
		den = sqrt(grad*grad + 1);
		perpDist = num/den;
	end
	
end