function corners = line_segmentation(xPoints, yPoints, linThres)
   %%%%%%TEST VALUES
%     x = [0 1 2 3 4 5 6 7 8 9]
%     y = [4 3 8 5 2 1 9 5 4 3]
%     y = [0 1 2 3 4 5 6 7 8 9]
%       points = [xPoints;yPoints]
%       plot(points(1,:), points(2,:))
%   
    iMax = length(xPoints);
    toConcat = LSEG_recurs(1, iMax, xPoints, yPoints, linThres);
    cornerInd = [cornerInd, toConcat];
    corIndL = length(cornerInd);
    
    for i = 2:corIndL
        j = cornerInd(i);
        corners = [[xPoints(j);yPoints(j)]];
    end
end


function tempToConcat = LSEG_recurs(iStart, iEnd, xPoints, yPoints, linThres)
     maxPDist = 0;
     maxPDInd = 0;
     [tempL, tempD] = LSM(xPoints, yPoints);
     tempPDist = perpendicular_distance(xPoints, yPoints, tempL(1), tempL(2));
        if  tempPDist > maxPDist
            maxPDist = tempPDist;
            maxPDInd = i;
        end
     
     if(maxPDist <= linThres)
         tempToConcat = [iStart; iEnd]
         disp 'linear... hell yeah'
     else
         if(maxPDist > linThres)
            disp 'not linear'  
            xPoints(maxPDInd) = [];
            yPoints(maxPDInd) = [];
            t1 = LSEG_recurs(iStart, splitPoint-1, xPoints, yPoints, linThres);
            t2 = LSEG_recurs(splitPoint-1, iEnd, xPoints, yPoints, linThres);
            tempToConcat = [t1, t2];
         end
     end
end