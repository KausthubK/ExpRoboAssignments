%V1.2
% % % FUNCTION:	readCard
% % % MTRX5700 Major Assignment 2015
% % % Authors: Sachith Gunawardhana & Kausthub Krishnamurthy & James Ferris

% % % REVISION HISTORY
% % % v0 function stub
% % % v1.1 imported into function format
% % % v1.2 filler done (block needs testing)
%TODO
% - block
% - count
% - colour

% % % SUBFUNCTIONS LISTING
% % %

function [viewed, shape, colour, filler, count] = readCard(I)
% returns a set of feature values for the card on the image

% OUTPUTS
% % viewed    - flag returns 1 if a card is viewed
% % shape	  - 1 (rectangle), 2 (triangle), 3 (elipse), 0 (default unknown)
% % colour	  - 1 (red), 2 (green), 3 (blue), 0 (default unknown)
% % filler	  - 1 (empty), 2 (shaded), 3 (filled), 0 (default unknown)
% % count	  - number of shapes (1 for now)


% INPUTS
% % I 		  - Image captured from vid

% defaults set
viewed = 0;
face_up(1).shape = 0;
face_up(1).colour = 0;
face_up(1).filler = 0;
face_up(1).count = 1;


BW=double(I)/255; %convert to double
% figure,imshow(BW);

%FIND FACEUP CARD
Icheck=imcrop(BW,[183.5 2.5 254 221]);
I2=Icheck>0.72;  %identify faceup card
I3=imfill(I2,'holes'); %fill all holes but the shape was gone
se=strel('square',9);
IE=imerode(I3,se);
I4=imclearborder(IE,4);
Iout=bwareaopen(I4,1000);

Bwoutline=bwperim(Iout); %create a outline
border=Icheck;
border(Bwoutline)=0;
% figure, imshow(border);

%ISOLATE FACEUP
cards=Icheck;
mask=Iout<0.5; %create a mask to isolate the face up
cards(mask)=0;
CC2=bwconncomp(cards); %find the connected blobs
% figure, imshow(cards)
% imwrite(cards,'t3.png');

s2=regionprops(CC2,'BoundingBox'); %identify the card boundary


%EXTRACT ISOLATED FACEUP
face_up(1).image=imcrop(Icheck,s2(1).BoundingBox);

%DETECT FEATURES
E=edge(face_up(1).image,'canny');
T10=imfill(E,'holes');
T11=bwareaopen(T10,200);
%   figure,imshow(T11);

CC3=bwconncomp(T11);
s3=regionprops(CC3,'Perimeter');
face_up(1).perim=s3.Perimeter;

%DEFINING CARD
face_up(1).shape = 0;
if s3.Perimeter<162 && s3.Perimeter>155;
    face_up(1).shape=1; %1 rectangle in set card
elseif s3.Perimeter<90 && s3.Perimeter>85;
    face_up(1).shape=2; %1 trangle in set card
elseif s3.Perimeter<137 && s3.Perimeter>132;
    face_up(1).shape=3; %1 elipse in set card
end

TT=face_up(1).image;
st2=regionprops(T11,TT,'MeanIntensity');
if st2.MeanIntensity>0.6
    face_up(1).filler=1; %not shaded
elseif st2.MeanIntensity<0.6 && st2.MeanIntensity>0.5
    face_up(1).filler=2; %shaded
elseif st2.MeanIntensity<0.5
    face_up(1).filler=3; %block
end

shape = face_up(1).shape;
filler = face_up(1).filler;
colour = face_up(1).colour;
count = face_up(1).count;

%DISPLAY
if face_up(1).shape==1
    disp 'RECTANGLE'
    viewed = 1;
elseif face_up(1).shape==2
    disp 'TRANGLE'
    viewed = 1;
elseif face_up(1).shape==3
    disp 'ELIPSE'
    viewed = 1;
elseif face_up(1).shape==0
	disp 'UNABLE TO DETERMINE SHAPE'
	viewed = 0;
end

if face_up(1).filler == 3
    disp 'BLOCK'
elseif face_up(1).filler==2
    disp 'SHADED'
elseif face_up(1).filler==1
    disp 'NOT SHADED'
else
    disp 'UNABLE TO DETERMINE FILLER'
end

imshow(cards);

end

