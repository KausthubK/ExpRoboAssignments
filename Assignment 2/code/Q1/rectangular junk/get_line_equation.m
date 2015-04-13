%%Given two x point coordinats Pi(x,y)
%If FLAG == 0, return a and b values for Y = aX + b
%If FLAG == 1, return r and theta values for 

function [a b] = get_line_equation(P1, P2, FLAG)

    if FLAG == 0    %Y = aX + b
        a = (P2(2) - P1(2))/(P2(1) - P1(1));

        b = P1(2) - a*(P1(1));
    
    elseif FLAG == 1    %r,theta
        %Find vector R
        %%for V = P1 + alpha(P2-P1)
        %%%find alpha such that RdotV = 0
        %%Where R = (x;y) and x,y are on V
        alpha = ((P1(1)*(P1(1)-P2(1)))+(P1(2)*(P1(2)-P2(2))))/((P2(1)-P1(1))^2 + (P2(2)-P1(2))^2);
        R = transpose(P1) + alpha*(transpose(P2) - transpose(P1));
        
        a = sqrt(sum(R.*R));
        
        b = atan(R(2)/R(1));
        
    end
    
end