function rsq = r_sq_lin_test(xPoints, yPoints)
%     from standard matlab functions
     pFit = polyfit(xPoints, yPoints, 1);
%     pFit = LSM(xPoints, yPoints);
%     p(1) is the slope and p(2) is the intercept for 
%     y = p(1)*x+p(2);
    yFit = polyval(pFit, xPoints);
    plot(yFit);
    yRes = yPoints - yFit;
     
%     Square the residuals and total them to obtain the residual sum of squares:
    SSresid = sum(yRes.^2);
%     Compute the total sum of squares of y by multiplying the variance of y by the number of observations minus 1:
    SStotal = (length(yPoints)-1) * var(yPoints);
%     Compute R2 using the formula given in the introduction of this topic:
    rsq = 1 - SSresid/SStotal;
end
