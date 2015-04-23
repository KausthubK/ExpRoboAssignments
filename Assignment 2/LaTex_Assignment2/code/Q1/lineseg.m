%% LINESEG -  Line Segmentation Algorithm Handler
% Purpose: Calls the Recursive Line Segmentation Algorithm and compiles
%           & formats the output
%           Also handles plotting of lines based on corner points
%
% Usage:  vertices = lineseg(xPoints, yPoints, linThres)
%
% Arguments:   
%            xpoint - set of x coordinates
%            ypoint - set of y coordinates
%            linThres - linearity threshold value (sets the variance limit)
%
% Returns:
%            2D Array coordinates of each corner in the form:
%                   x1 y1
%                   x2 y2
%                   x3 y3
%
%
% Author: 
% Kausthub Krishnamurthy
% The University of Sydney
% kkri3182@uni.sydney.edu.au
% April 2015
function vertices = lineseg(xPoints, yPoints, linThres)
	%set up indices
    iStart = 1;
	iEnd = length(xPoints);
    
	vertexInds = [1];%first corner will always be the first data point
    
    %call to recursive function
	newInds = lineseg_recurs(iStart, iEnd, xPoints, yPoints, linThres);
    
    %appends generated corner values to list
	vertexInds = [vertexInds, newInds];
    
    %sorts list of corner value (not strictly necessary as it should
        %naturally concatenate from left to right
	vertexInds = sort(vertexInds);
    
    %reformat from index values to x & values
    numVertices = length(vertexInds);
    vertices = zeros(numVertices, 2);
    for i = 1:numVertices
            vertices(i, 1) = xPoints(vertexInds(i));
            vertices(i, 2) = yPoints(vertexInds(i));
    end
    
    %call to plotter based on corner values
   %close all
   plotLSEG(vertices, numVertices);   
end

%% LINESEG_RECURS -  Recursive Line Segmentation Algorithm
%
% Purpose: To recursively compute and return each corner point individually
% Usage:  tempToConcat = lineseg_recurs(iStart, iEnd, xPoints, yPoints, linThres)
%
% Arguments:   
%            iStart - starting index
%            iEnd   - ending index
%            xpoint - set of x coordinates
%            ypoint - set of y coordinates
%            linThres - linearity threshold value (sets the variance limit)
%
% Returns:
%           1D array of index values of corner points from existing data
%           points
%
% Author: 
% Kausthub Krishnamurthy
% The University of Sydney
% kkri3182@uni.sydney.edu.au
% April 2015
function tempToConcat = lineseg_recurs(iStart, iEnd, xPoints, yPoints, linThres)
	maxPDist = 0;
	maxPDInd = 0;
    %generate first line estimation
	tempLine = leastsqmin(xPoints, yPoints, iStart, iEnd);
    
    %find max distance from line estimation
	for n = iStart:iEnd
		temPDist = perpdist(xPoints(n), yPoints(n), tempLine(1), tempLine(2), tempLine(3), tempLine(4));
		if temPDist > maxPDist
            if(n ~= iStart)
                if(n ~= iEnd)
                    maxPDist = temPDist;
                    maxPDInd = n;
                end
            end
		end
	end

	if maxPDist <= linThres
        %base exit case
		%disp 'linear... hell yeah' %debug line
		tempToConcat = [iEnd];
    else
        %recursively repeat this function to split left and right segments
            %left segment is from the starting index to the First (from the
            %left) max distance point
            %right segment is from the First max distance point to the
            %end index point
		%disp 'not linear'  %debug line
        left_ttc = lineseg_recurs(iStart, maxPDInd, xPoints, yPoints, linThres);
		right_ttc = lineseg_recurs(maxPDInd, iEnd, xPoints, yPoints, linThres);
        %concatenate corner index values returned from above (works similar
        %to a recursive merge
		tempToConcat = [left_ttc, right_ttc];
	end
end


%% PLOTLSEG -  Plot Segmented Lines
%
% Purpose: To plot the detected lines from the data after detecting valid
%           corner points
% Usage:  plotLSEG(cnr, n)
%
% Arguments:   
%            vrts	-   2D Array of corners
%                       x1 y1
%                       x2 y2
%                       x3 y3
%
% Author: 
% Kausthub Krishnamurthy
% The University of Sydney
% kkri3182@uni.sydney.edu.au
% April 2015
function plotLSEG(vrts, n)
    for i = 1: n-1
        
        xEnds = [vrts(i,1) vrts(i+1,1)];
        yEnds = [vrts(i,2) vrts(i+1,2)];
        line(xEnds, yEnds);
    end
end