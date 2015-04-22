function [deltaPose_bar, deltaPose_bar_Cov, N] = ICPv4(deltaPose, a, b)

% function: ICP algorithm version 3.0
% a: point set, 2 x Na
% b: point set, 2 x Nb
% Xab: the relative tranformation between a and b 
%
%
%
% Author: Chieh-Chih (Bob) Wang [bobwang@cs.cmu.edu]
% Created: Dec. 2, 2002. 
% Last Modified: Dec. 27, 2003.
% (C) 2002-2004 Chieh-Chih (Bob) Wang. All Rights Reserved.


max_delta_g = 0.005;
max_iter = 40; 
WinSize = 80;

% Cell 5cm x 5cm
grid_size =   0.05; % Changing this value may affect the accuracy of the ICP algorithm.
Map_x_min =   min(a(1,:));
Map_y_min =   min(a(2,:));
Map_x_max =   max(a(1,:));
Map_y_max =   max(a(2,:));

% Step 1: Create a grid map foo speed up correspondence search
GridMap_X = ceil((Map_x_max - Map_x_min)/grid_size);
GridMap_Y = ceil((Map_y_max - Map_y_min)/grid_size);
GridMap = zeros(GridMap_X, GridMap_Y);

for k=1:size(a,2)          
    [Map_i,Map_j] = XY2IJ(a(1,k), a(2,k), grid_size, Map_x_min, Map_y_min);
    if Map_i>0 & Map_i<= GridMap_X & Map_j>0 & Map_j<= GridMap_Y
        if GridMap(Map_i,Map_j)~= 0
            %disp(sprintf('points collide %d,%d', Map_i, Map_j))            
        end
        GridMap(Map_i,Map_j) = k;
    end        
end

WinSize_org = WinSize;
delta_g = 1000000000;
j=0;
g = deltaPose;

% method 2:
Z = [];
M = [];

NoMatch_flag = 0;

while (j < max_iter) & (delta_g > max_delta_g)	
    j = j+1;
	old_g = g;    
	% Step 1:
	
    % Finding Correspondence
	Match_Pairs = [];
    %New_Scan1_Index = Scan1_Index;
    %New_Scan2_Index = Scan2_Index;
	    
    %WinSize = round(WinSize_org/j);
    WinSize = WinSize_org- 4*j;
    if WinSize < 2
        WinSize = 2;
    end
    
	for k=1:size(b,2)    
		            
        Point_X = head2tail_no_theta(g,b(:,k));
        
        [Map_i,Map_j] = XY2IJ(Point_X(1), Point_X(2), grid_size, Map_x_min, Map_y_min);        
        % Search ...
        % Define search area
        % WinSize = 10;
        Win_i_min = Map_i - WinSize;
        if Win_i_min < 1
            Win_i_min = 1;
        end            
        Win_i_max = Map_i + WinSize;
        if Win_i_max > GridMap_X
            Win_i_max = GridMap_X;
        end            
        Win_j_min = Map_j - WinSize;
        if Win_j_min < 1
            Win_j_min = 1;
        end            
        Win_j_max = Map_j + WinSize;
        if Win_j_max > GridMap_Y
            Win_j_max = GridMap_Y;
        end            
        [Search_i, Search_j] = find(GridMap(Win_i_min:Win_i_max, Win_j_min:Win_j_max) > 0);        
        if size(Search_i,1)>0
            min_dis = 100000000000000;
            match_index = 0;
            for m=1:size(Search_i,1)
                a_index = GridMap(Search_i(m)+Win_i_min-1, Search_j(m)+Win_j_min-1);
                dis = sqrt((Point_X(1) - a(1,a_index))^2 ...
                    + (Point_X(2) - a(2,a_index))^2);
                if (dis < min_dis)
                    min_dis = dis;
                    match_index = a_index;
                end                    
            end            
            % method 1:
            Match_Pairs = [Match_Pairs; ...
                    b(1,k) b(2,k) a(1,match_index) a(2,match_index)];
            % method 2:
            Mk = [1 0 -Point_X(2,1); 0 1 Point_X(1,1)];
            M = [M; Mk];
            Z = [Z; Point_X - a(:,match_index)];
            
            %MatchedPoints(1,k) = 1;
            %New_Scan1_Index(1, match_index) = 2; % see Readme.txt for the definition
            %New_Scan2_Index(1, k) = 2;                
        end                
    end
	%Method 1: the closed form solution without covariance estimate
	N = size(Match_Pairs,1);
    %disp(sprintf('Inside ICPv4: iter %d, match pairs %d',j, N));
    if N == 0
        NoMatch_flag = 1;
        break
    end

	X2_bar = sum(Match_Pairs(:,1))/N;
	Y2_bar = sum(Match_Pairs(:,2))/N;
	X1_bar = sum(Match_Pairs(:,3))/N;
	Y1_bar = sum(Match_Pairs(:,4))/N;
	Sx2x1 = sum((Match_Pairs(:,1) - X2_bar).*(Match_Pairs(:,3) - X1_bar));
	Sy2y1 = sum((Match_Pairs(:,2) - Y2_bar).*(Match_Pairs(:,4) - Y1_bar));
	Sx2y1 = sum((Match_Pairs(:,1) - X2_bar).*(Match_Pairs(:,4) - Y1_bar));
	Sy2x1 = sum((Match_Pairs(:,2) - Y2_bar).*(Match_Pairs(:,3) - X1_bar));
	
	g(3,1) = atan2(Sx2y1-Sy2x1, Sx2x1+ Sy2y1);
	g(1,1) = X1_bar - (X2_bar*cos(g(3,1))- Y2_bar*sin(g(3,1))); 
	g(2,1) = Y1_bar - (X2_bar*sin(g(3,1))+ Y2_bar*cos(g(3,1)));	
        
	delta_g = sqrt((old_g(1) - g(1))^2 + (old_g(2) - g(2))^2);
    
    %Method 2:
%     InvMM = inv(M'*M);
%     D_bar = InvMM*M'*Z;
%     ZminusMD_bar =Z-M*D_bar;
%     s_square = ZminusMD_bar'*ZminusMD_bar/(2*N-3);
%     Cov_ICP = s_square*InvMM;
    
    %pause        
end
% Xab_bar = g+D_bar;
% Xab_Cov = Cov_ICP;
if NoMatch_flag == 0
    InvMM = inv(M'*M);
    D_bar = InvMM*M'*Z;
    ZminusMD_bar =Z-M*D_bar;
    s_square = ZminusMD_bar'*ZminusMD_bar/(2*N-3);
    Cov_ICP = s_square*InvMM;
    
    deltaPose_bar = g;
    deltaPose_bar_Cov = Cov_ICP; 
else
    deltaPose_bar = [];
    deltaPose_bar_Cov = [];
end
