%% PERPDIST - Perpendicular Distance Calculator
%
% Usage:  perpDist = perpdist(p_x, p_y, grad, y_int, x_int, vertFlag)
%
% Arguments:   
%            p_x    - x coordinate of point
%            p_y    - y coordinate of point
%            grad   - gradient of line
%            y_int  - y intercept of the line
%            x_int  - x intercept of the line
%            vertFlag - 1 if the line is vertical; 0 if line is not
%
% Returns:
%            perpDist - perpendicular distance between the point (p_x, p_y) 
%                       and the line y = grad*x + y_int
%
%
% Author: 
% Kausthub Krishnamurthy
% The University of Sydney
% kkri3182@uni.sydney.edu.au
% April 2015

function perpDist = perpdist(p_x, p_y, grad, y_int, x_int, vertFlag)
	if vertFlag == 1
        %x-distance between mean of xvalues and point's x coordinate
		perpDist = abs(p_x-x_int);
    else
        %if not vertical use the y=mx+b form of the equation:
        % pdist = |y - mx - b|/sqrt(m^2 + 1)
		num = abs(p_y-(grad*p_x)-y_int);
		den = sqrt(grad*grad + 1);
		perpDist = num/den;
	end
	
end