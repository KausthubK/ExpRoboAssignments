function [Map_i,Map_j] = XY2IJ(x, y, grid_size, Map_x_min, Map_y_min)

% XY2IJ
%
% Author: Chieh-Chih (Bob) Wang [bobwang@cs.cmu.edu]
% Created: Oct. 31, 2002.
% Modified: Nov. 6, 2003.
% (c) 2002-2003 Chieh-Chih Wang. All Rights Reserved.

% Changed to the vec form
Map_i = round((x - Map_x_min)/grid_size + 0.5);
Map_j = round((y - Map_y_min)/grid_size + 0.5);

