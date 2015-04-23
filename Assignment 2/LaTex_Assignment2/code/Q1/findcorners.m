function corners = findcorners(xvals, yvals, linThresh)
    vertices = lineseg(xvals, yvals, linThresh);
    nVert = length(vertices);
    nVec = nVert-1;
    vectors = zeros(nVec, 2);
    
    vertices
    
    for i = 1:nVec
            vectors(i, 1) = vertices(i+1, 1)-vertices(i, 1);
            vectors(i, 2) = vertices(i+1, 2)-vertices(i, 2);
    end
    
    vectors
    
    cornerCount = 0;
    for i = 1:(nVec-1)
        v1 = [vectors(i, 1), vectors(i, 2)];
        v2 = [vectors(i+1, 1), vectors(i+1, 2)];
        dp = dot(v1, v2);
        if(dp < 0.00018 && dp > -0.00018)
            cornerCount = cornerCount + 1;
            corners(cornerCount, 1) = vertices(i+1, 1);
            corners(cornerCount, 2) = vertices(i+1, 2);
        end
    end
    
    if cornerCount == 0
        disp 'no corners'
        corners = 'N/A';
    end
    
    corners
    cornerCount
end