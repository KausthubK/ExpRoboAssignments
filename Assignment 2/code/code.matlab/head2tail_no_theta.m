function Xik = head2tail_no_theta(Xij, Xjk)

% Compounding Operation: head2tail 
%
% Input:
%   Xij = [x_ij; y_ij; theta_ij] 
%   Xjk = [x_jk; y_jk]
% Output:
%   Xik = [x_ik; y_ik]
% 
% Author: Chieh-Chih (Bob) Wang [bobwang@cs.cmu.edu]
% Created: Nov. 8, 2002.
% Modified: Nov. 6, 2003.


cosTheta_ij = cos(Xij(3,1));
sinTheta_ij = sin(Xij(3,1));

% Xik(1,1) = Xjk(1,1)*cosTheta_ij - Xjk(2,1)*sinTheta_ij + Xij(1,1);
% Xik(2,1) = Xjk(1,1)*sinTheta_ij + Xjk(2,1)*cosTheta_ij + Xij(2,1);

% Change for Vec...
Xik(1,:) = Xjk(1,:)*cosTheta_ij - Xjk(2,:)*sinTheta_ij + Xij(1,1);
Xik(2,:) = Xjk(1,:)*sinTheta_ij + Xjk(2,:)*cosTheta_ij + Xij(2,1);