%% LEASTSQMIN -  Least Squares Minimisation Algorithm
%
% Usage:  lineDetails = leastsqmin(xpoint,ypoint, iStart, iEnd)
%
% Arguments:   
%            xpoint - set of x coordinates
%            ypoint - set of y coordinates
%            iStart - starting index
%            iEnd   - ending index
%
% Returns:
%            lineDetails - array of 4 values
%               (1) gradient of estimated line
%               (2) y-intercept of estimated line
%               (3) x-intercept of estimated line
%               (4) flag value 1 or 0 (1 if line is vertical; 0 if not)
%
%
% Author: 
% Kausthub Krishnamurthy
% The University of Sydney
% kkri3182@uni.sydney.edu.au
% April 2015

function lineDetails = leastsqmin(xpoint,ypoint, iStart, iEnd)

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
    
    %plotLSM(xpoint, ypoint, iStart, iEnd, lineDetails);
end
    
%% plotLSM -  plot based on the output of Least Squared Minimisation
%               algorithm
%
% Usage:  plotLSM(xpoint, ypoint, iStart, iEnd, lineDetails);
%
% Arguments:   
%            xpoint - set of x coordinates
%            ypoint - set of y coordinates
%            iStart - starting index
%            iEnd   - ending index
%            lineDetails - array of 4 values
%               (1) gradient of estimated line
%               (2) y-intercept of estimated line
%               (3) x-intercept of estimated line
%               (4) flag value 1 or 0 (1 if line is vertical; 0 if not)
%
%
% Author: 
% Kausthub Krishnamurthy
% The University of Sydney
% kkri3182@uni.sydney.edu.au
% April 2015
function plotLSM(xpoint, ypoint, iStart, iEnd, lineDetails)
    hold on
    if lineDetails(4) == 1
        %if vertical plot points at very small increments (0.01) at x-int
        y = [ypoint(iStart):0.01:ypoint(iEnd)];
        plot(lineDetails(3), y);
    else
        %plot based on y = mx+b
        x = [xpoint(iStart):0.1:xpoint(iEnd)];
        plot(x, lineDetails(1)*x+lineDetails(2));
    end
end