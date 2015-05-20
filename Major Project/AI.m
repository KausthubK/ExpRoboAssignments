% % % GamePlay AI for Concentration
% % % MTRX5700 Major Assignment 2015
% % % Author: Kausthub Krishnamurthy & James Ferris & Sachith
% Gunawardhana
% % % 
% % % AI control flow finished. Needs proper control flow testing
% % % Need following functions made:
% % % VISION
% % % [numCards, numFUP, numFDWN, coordsFUP, coordsFDWN] = surveyField();
% % % 
% % % [viewed, cards(nextUnknown).histVec] = readCard(flipX, flipY, flipPose);
% % % 
% % % [matchFlag, matchIndex] = compareCards(cards(nextUnknown).histVec, cards);
% % % 
% % % confirmedFlag = confirmMatch(peekedHistVec, cards(nextUnkown).histVec
% % % 
% % % ACTUATION
% % % flipCard(cards(nextUnknown).x, cards(nextUnknown).y, cards(nextUnknown).pose);
% % % 
% % % removePair(cards, matchIndex, nextUnknown);
% % % 
% % % unpeekCard(cards(matchIndex).x, cards(matchIndex).y, cards(matchIndex).pose);
% % % 
% % % unflipCard(cards(nextUnknown).x, cards(nextUnknown).y, cards(nextUnknown).pose);
% % % 
% % % 
% % % 
% % % FUSED
% % % peekedHistVec = peekAt(cards(matchIndex).x, cards(matchIndex).y, cards(matchIndex).pose);




clear all
close all
clc

% game setup
gameOver = 0;
[numCards, numFUP, numFDWN, coordsFUP, coordsFDWN] = surveyField();

%gameplay variables
numRemaining = numCards;
nextUnknown = 1;
%set x and y coordinates for peeking at the card
peekX = 0;
peekY = 0;
peekPose = 0;

%set x and y coordinate for flipped card
flipX = 0;
flipY = 0;
flipPose = 0;


% card struct: implementation
cards = struct('index', {},'x', {}, 'y', {}, 'pose', {}, 'histVec', {}, 'viewedFlag', {});
% cards = struct('index', {},'x', {}, 'y', {}, 'pose', {}, 'shape', {}, 'colour', {}, 'fill', {}, 'count', {});

if(numFUP ~= 0)
    disp 'ERROR: Incorrect Setup. All cards must begin Face Down'
    disp ':: ABORTING GAME ::'
    quit;
end
if(~(numFDWN > 0))
    disp 'ERROR: Incorrect Setup :: Not enough cards for a playable instance of the game'
    disp ':: ABORTING GAME ::'
    quit
end

%populate cards struct
for i = 1:numCards
    cards(i).index = i;
    cards(i).x = coordsFDWN(i,1);
    cards(i).y = coordsFDWN(i,2);
    cards(i).pose = coordsFDWN(i,3);
    cards(i).histVec = NULL;
    cards(i).viewedFlag = 0;
end




% start game
while(gameOver == 0)
%update field state
    [numRemaining, numFUP, numFDWN, coordsFUP, coordsFDWN] = surveyField();
    % if less than two are face down -> go to end game
    if(numFDWN >= 2)
    %play the game
        if(numFUP == 0)
%             flip the next unkown card
            flipCard(cards(nextUnknown).x, cards(nextUnknown).y, cards(nextUnknown).pose);
        elseif(numFUP == 1)
            [viewed, cards(nextUnknown).histVec] = readCard(flipX, flipY, flipPose);
            if(viewed ~= 1)
                disp 'ERROR: Card Reading Error'
                disp ':: ABORTING GAME ::'
                quit
            end
            
            matchFlag = 0;
            [matchFlag, matchIndex] = compareCards(cards(nextUnknown).histVec, cards);
            if(matchFlag == 1)
               disp 'Hey I have seen this before'
               
               peekedHistVec = peekAt(cards(matchIndex).x, cards(matchIndex).y, cards(matchIndex).pose); %will internally utilise readCard(x, y, pose)
               
               confirmedFlag = 0;
               confirmedFlag = confirmMatch(peekedHistVec, cards(nextUnkown).histVec);
               
               if(confirmedFlag == 1)
                   disp 'FOUND IT!'
                   removePair(cards, matchIndex, nextUnknown);
                   cards(nextUnkown).viewedFlag = viewed;
                   nextUnknown = nextUnknown + 1;
                   matchFlag = 0;
                   confirmedFlag = 0;
               else
%                    in case what we thought was a match isn't actually a match
                   disp 'I LOST IT! WHERE IS THE PRECIOUSSS!!'
                   unpeekCard(cards(matchIndex).x, cards(matchIndex).y, cards(matchIndex).pose);
                   unflipCard(cards(nextUnknown).x, cards(nextUnknown).y, cards(nextUnknown).pose);
                   cards(nextUnkown).viewedFlag = viewed;
                   nextUnknown = nextUnknown + 1;
                   matchFlag = 0;
                   confirmedFlag = 0;
                   disp ':: ABORTING GAME ::'
                   quit
               end
            else
                disp 'YAY! A NEW CARD!'
                unflipCard(cards(nextUnknown).x, cards(nextUnknown).y, cards(nextUnknown).pose);
                cards(nextUnkown).viewedFlag = viewed;
                nextUnknown = nextUnknown + 1;
            end            
        end
    else
        %end the game
        disp 'GAME OVER'
        gameOver = 1;
    end
end