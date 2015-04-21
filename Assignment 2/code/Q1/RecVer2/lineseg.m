function corners = lineseg(xPoints, yPoints, linThres)
	iStart = 1;
	iEnd = length(xPoints);
	cornerInds = [1, iEnd];
	newInds = lineseg_recurs(iStart, iEnd, xPoints, yPoints, linThres);
	cornerInds = [cornerInds, newInds];
	cornerInds = sort(cornerInds);
end

function tempToConcat = lineseg_recurs(iStart, iEnd, xPoints, yPoints, linThres)
	maxPDist = 0;
	maxPDInd = 0;
	tempLine = leastsqmin(xPoints, yPoints, iStart, iEnd)

	for n = iStart:iEnd
		temPDist = perpdist(xPoints(n), yPoints(n), tempLine(1), tempLine(2), tempLine(3), tempLine(4))
		if temPDist > maxPDist
			maxPDist = temPDist;
			maxPDInd = n;
		end
	end

	if maxPDist <= linThres
		disp 'linear... hell yeah'
		tempToConcat = [iEnd];
	else
		disp 'not linear'
		left_ttc = lineseg_recurs(iStart, maxPDInd, xPoints, yPoints, linThres);
		right_ttc = lineseg_recurs(maxPDInd, iEnd, xPoints, yPoints, linThres);
		tempToConcat = [left_ttc, right_ttc];
	end
end