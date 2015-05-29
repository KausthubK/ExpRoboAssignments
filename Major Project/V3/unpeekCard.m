%V1.0
% % % FUNCTION:	unpeekCard
% % % MTRX5700 Major Assignment 2015
% % % Authors: James Ferris & Sachith Gunawardhana & Kausthub Krishnamurthy

% % % REVISION HISTORY
% % % v1.0 function stub

% % % SUBFUNCTIONS LISTING
% % %


function peekFlag = unpeekCard(t, x, y, pose)
% given an x & y position will pick up the block at that point will move the arm to the peek coordinates

% move J2 to -90 degrees
% move J3 to +90 degrees
% move J5 to +90 degrees
% move to x, y
% move tool to pickUpHeight (30)
% open gripper
% move tool up 25

   
   sendCommand(t,'<u>\n');
   sendCommand(t,'<h2>\n');	%move to height 2
   sendCommand(t,sprintf('<x%.0f,y%.0f>\n',x,y));   %move to x y
   sendCommand(t,sprintf('<a%.0f>\n', pose));	%Set tool angle to pose deg
   sendCommand(t,'<h0>\n');	%move to height 0
   sendCommand(t,'<o>\n');	%grip
   
   sendCommand(t,'<h2>\n');	%move to height 2
   
   
   sendCommand(t,'<a0>\n');	%Set tool angle to 0 deg	%check this is correct default angle
   
peekFlag = 0;

end

