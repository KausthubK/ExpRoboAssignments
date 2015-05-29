%V1.0
% % % FUNCTION:	unpeekCard
% % % MTRX5700 Major Assignment 2015
% % % Authors: James Ferris & Sachith Gunawardhana & Kausthub Krishnamurthy

% % % REVISION HISTORY
% % % v1.0 function stub

% % % SUBFUNCTIONS LISTING
% % %


function peekFlag = unpeekCard(x, y, pose)
% given an x & y position will pick up the block at that point will move the arm to the peek coordinates

% move J2 to -90 degrees
% move J3 to +90 degrees
% move J5 to +90 degrees
% move to x, y
% move tool to pickUpHeight (30)
% open gripper
% move tool up 25


   sendCommand(t,sprintf('<u,x%.0f,y%.0f>\n',x,y));
peekFlag = 0;

end

