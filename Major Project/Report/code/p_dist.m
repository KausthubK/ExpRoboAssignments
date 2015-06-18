%V1.1
% % % FUNCTION:	p_dist
% % % MTRX5700 Major Assignment 2015
% % % Authors: Sachith Gunawardhana & Kausthub Krishnamurthy & James Ferris

% % % REVISION HISTORY
% % % v0 function stub
% % % v1.1 imported into function format (needs testing)

% % % SUBFUNCTIONS LISTING
% % %

function [pDist] = p_dist(B1,B2,u,v)
% Calculates the perpendicular distance between a point and a line

% Outputs:
% %     pDist 	  - perpendicular distance
% Inputs:
% %		B1 		  - 
% %		B2 		  - 
% %		v 		  - 
% %		u 		  - 


LP1=[B1(1,1),B1(1,2)];
LP2=[B2(1,1),B2(1,2)];

D=sqrt((LP2(1)-LP1(1))^2+(LP2(2)-LP1(2))^2);

r=(u*(LP1(2)-LP2(2))+v*(LP2(1)-LP1(1))+LP2(2)*LP1(1)-LP1(2)*LP2(1));

pDist=r/D;


end
