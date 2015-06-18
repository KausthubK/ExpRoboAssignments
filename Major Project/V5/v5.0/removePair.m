%V1.0
% % % FUNCTION:	removePair
% % % MTRX5700 Major Assignment 2015
% % % Authors: Sachith Gunawardhana & Kausthub Krishnamurthy & James Ferris

% % % REVISION HISTORY
% % % v1.0 function stub

% % % SUBFUNCTIONS LISTING
% % %


function removePair(t, cards, matchIndex, currInd)

%cards(matchIndex).x
%cards(matchIndex).y
%cards(matchIndex).pose
  
	%unpeek
	%reveal cards
	%move arm to over the table edge
	%open gripper
	%j5 back down
	%move to matched Index's x, y
	%lower to height of 30
	%close gripper
	%height up
	%reveal card
	%%%check here???
	%move arm to over the table edge
	%open gripper
	
	sendCommand(t,'<u>\n');
	sendCommand(t,'<d>\n');		%display card
    pause(1)
	sendCommand(t,'<b>\n');
    
	sendCommand(t,sprintf('<x%.0f,y%.0f>\n',-1*cards(currInd).x,cards(currInd).y));
    sendCommand(t,sprintf('<a%.0f>\n', cards(currInd).pose));	%Set tool angle to deg
    
	sendCommand(t,'<h0>\n');	%move to height 0
	sendCommand(t,'<o>\n');    
	sendCommand(t,'<h1>\n');	%move to height 2
	
	sendCommand(t,sprintf('<x%.0f,y%.0f>\n',cards(matchIndex).x,cards(matchIndex).y)); 
	sendCommand(t,sprintf('<a%.0f>\n', cards(matchIndex).pose));	%Set tool angle to deg
	
	sendCommand(t,'<a0>\n');	%Set tool angle to 0 deg	%check this is correct default angle
	
	sendCommand(t,'<h0>\n');	%move to height 0
	sendCommand(t,'<c>\n');	%grip
	sendCommand(t,'<h1>\n');	%move to height 2
	
	sendCommand(t,'<d>\n');
    pause(1);    
	sendCommand(t,'<b>\n');
	sendCommand(t,sprintf('<x%.0f,y%.0f>\n',-1*cards(matchIndex).x,cards(matchIndex).y));
    sendCommand(t,sprintf('<a%.0f>\n', cards(matchIndex).pose));	%Set tool angle to deg
    sendCommand(t,'<h0>\n');	%move to height 0
	sendCommand(t,'<o>\n');    
	sendCommand(t,'<h1>\n');	%move to height 2
    sendCommand(t,'<a0>\n');	%Set tool angle to 0 deg	%check this is correct default angle
   
	
	
    disp 'FOUND IT!'
end
