% % % TEST: Motion
% % % MTRX5700 Major Assignment 2015
% % % Authors: Kausthub Krishnamurthy & James Ferris & Sachith
% Gunawardhana



clear all
close all
clc


saveNum = 100;

% Game Setup
stackHeight = 0.0;

% Open Network Connection
t = tcpip('192.168.0.1', 2020, 'NetworkRole', 'client');
disp 'Connecting....'
fopen(t);
disp 'Connected'

% Camera Setup
vid = videoinput('pointgrey',1, 'Mono8_640x480');
pause(1);

% card struct: implementation
% cards = struct('index', {},'x', {}, 'y', {}, 'pose', {}, 'histVec', {}, 'viewedFlag', {});
cards = struct('index', {},'x', {}, 'y', {}, 'pose', {}, 'shape', {}, 'colour', {}, 'filler', {}, 'count', {}, 'viewedFlag', {});

% Hide the arm
% Image Capture
hideArm(t);
I = getsnapshot(vid);
imshow(I);

    imwrite(I, sprintf('test_image%d.png',saveNum));
    saveNum = saveNum + 1;

[numCards, numFUP, numFDWN, coordsFUP, coordsFDWN] = surveyField(I);
% Unhide the arm
unHideArm(t);


% Gameplay Flags & Variables
gameOver = 0;
numRemaining = numCards;
nextUnknown = 1;
peekingFlag = 0;
gameMode = 10; % binary 00001010


% Pre-Game Error Checking
if(numFUP ~= 0)
    disp 'ERROR: Incorrect Setup. All cards must begin Face Down'
    disp ':: ABORTING GAME ::'
    % Close Network Port and Camera
    delete(vid)
    disp 'Disconnecting'
    fclose(t);
    disp 'Goodbye'
    quit;
end
if(~(numFDWN > 0))
    disp 'ERROR: Incorrect Setup :: Not enough cards for a playable instance of the game'
    disp ':: ABORTING GAME ::'
    % Close Network Port and Camera
    delete(vid)
    disp 'Disconnecting'
    fclose(t);
    disp 'Goodbye'
    quit
end

%populate cards struct
for i = 1:numCards
    cards(i).index = i;
    cards(i).x = coordsFDWN(i,1);
    cards(i).y = coordsFDWN(i,2);
    cards(i).pose = coordsFDWN(i,3);
    cards(i).viewedFlag = 0;
end

numCards
numFDWN
numFUP
coordsFUP
coordsFDWN


for i = 1:numCards
    
    peekAt(t, cards(i).x, cards(i).y, cards(i).pose);
    I2 = getsnapshot(vid);
    
    imwrite(I2, sprintf('test_image%d.png',saveNum));
    saveNum = saveNum + 1;
    imshow(I2);
    disp 'reading...'
%     viewed = 0;
    [viewed, cards(i).shape, cards(i).colour, cards(i).filler, cards(i).count] = readCard(I2);
    if(cards(i).viewedFlag == -1)
        disp 'oops i can not pick it the fuck up'
        if(i ~= numCards)
            disp 'Disconnecting'
            unpeekCard(t, cards(i).x, cards(i).y, cards(i).pose);
            fclose(t);
            disp 'Goodbye'
            delete(vid);
            quit
        else
            continue
        end
    end
    %cards(i).viewedFlag = viewed;
    disp 'compare...'
    [matchFlag, matchIndex] = compareCards(numCards,i , cards, gameMode)
    cards(i).viewedFlag = viewed;
    
    if matchFlag == 1
%         removePair(t, cards, matchIndex, i);
        stackHeight = stackPair(t, cards, matchIndex, i, stackHeight)
    else
        unpeekCard(t, cards(i).x, cards(i).y, cards(i).pose);
    end
end
disp 'Disconnecting'
fclose(t);
disp 'Goodbye'
delete(vid);
