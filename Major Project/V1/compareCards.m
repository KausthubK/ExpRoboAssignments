%V1.1
% % % FUNCTION:	compare cards
% % % MTRX5700 Major Assignment 2015
% % % Authors: Sachith Gunawardhana & Kausthub Krishnamurthy & James Ferris

% % % REVISION HISTORY
% % % v0 function stub
% % % v1.1 

% % % SUBFUNCTIONS LISTING
% % %
% % % 0000 1111
% % % 0000 1010
% % % 0000 1010

function [matchFlag, matchIndex] = compareCards(numCards, ind, cards, gameMode)

% % OUTPUTS
% matchFlag   - returns 1 if a match is found (0 if no match exists)
% matchIndex  - returns index of the card that matches the current one
% 
% % INPUTS
% index       - which instance of cards
% cards       - struct holding all cards details
% gameType    - binary mask filter for which features to compare
% %             1  = 0000 0001  (only count)
% %             2  = 0000 0010  (only filler)
% %             3  = 0000 0011
% %             4  = 0000 0100  (only colour)
% %             5  = 0000 0101
% %             6  = 0000 0110
% %             7  = 0000 0111  (no shape)
% %             8  = 0000 1000  (only shape)
% %             9  = 0000 1001
% %             10 = 0000 1010
% %             11 = 0000 1011  (no colour)
% %             12 = 0000 1100
% %             13 = 0000 1101  (no filler)
% %             14 = 0000 1110  (no count)
% %             15 = 0000 1111  (all)

matchFlag = 0;
matchIndex = -1;
% cards = struct('index', {},'x', {}, 'y', {}, 'pose', {}, 'shape', {}, 'colour', {}, 'filler', {}, 'count', {}, 'viewedFlag', {});

%compare
for i = 1:numCards
    matchChar = 0;% 0000 0000 -> xxxx sh col fi cnt
    if(cards(i).viewedFlag == 1)
        %shape
        if(cards(ind).shape == cards(i).shape)
            matchChar = bitset(matchChar, 4, 1);
        else
            matchChar = bitset(matchChar, 4, 0);
        end
    
        %colour
        if(cards(ind).colour == cards(i).colour)
            matchChar = bitset(matchChar, 3, 1);
        else
            matchChar = bitset(matchChar, 3, 0);
        end
    
        %filler
        if(cards(ind).filler == cards(i).filler)
            matchChar = bitset(matchChar, 2, 1);
        else
            matchChar = bitset(matchChar, 2, 0);
        end
    
        %count
        if(cards(ind).count == cards(i).count)
            matchChar = bitset(matchChar, 1, 1);
        else
            matchChar = bitset(matchChar, 1, 0);
        end
    
        %check
        if(bitand(matchChar, gameMode) == gameMode)
            if(cards(i).index ~= cards(ind).index)
%                 disp 'MATCH'
                matchFlag = 1;
                matchIndex = i;
                break
            else
                disp 'ERROR: Duplicate confusion'
                matchFlag = 0;
            end
        end
    end
end

if(gameMode < 0 || gameMode > 15)
    matchIndex = -1;
    matchFlag = -1;
    disp 'ERROR: INVALID NUMBER OF FEATURES'   
end

end