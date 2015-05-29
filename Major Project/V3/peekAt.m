%V1.0
% % % FUNCTION:	peekAt
% % % MTRX5700 Major Assignment 2015
% % % Authors: James Ferris & Sachith Gunawardhana & Kausthub Krishnamurthy

% % % REVISION HISTORY
% % % v1.0 function stub

% % % SUBFUNCTIONS LISTING
% % %

function peekFlag = peekAt(t, x, y, pose)

% given an x & y position will pick up the block at that point will move the arm to the peek coordinates

% move to x, y & pickUpHeight (30)
% close gripper
% move tool up (Z) 25
% move J5 to +90 degrees
% move J3 to +90 degrees
% move J2 to -90 degrees
% move J1 to 0 degrees
% move J4 to 0 degrees
% move J6 to 0 degrees
   
   sendCommand(t,sprintf('<x%.0f,y%.0f>\n',x,y));   %move to x y
   sendCommand(t,sprintf('<a%.0f>\n', pose));	%Set tool angle to deg
   sendCommand(t,'<h0>\n');	%move to height 0
   sendCommand(t,'<c>\n');	%grip
   sendCommand(t,'<h2>\n');	%move to height 2
   sendCommand(t,'<a0>\n');	%Set tool angle to 0 deg	%check this is correct default angle
   
   sendCommand(t,'<p>\n');	%peek
   
peekFlag = 1;

end

