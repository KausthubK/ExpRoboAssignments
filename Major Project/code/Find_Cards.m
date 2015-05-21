close all
clear
clc

%read the image
I=imread('test_image12.png');
BW=double(I)/255; %convert to double

%FIND FACEDOWN CARDS
T1=BW<0.1;
T2=imclearborder(T1,4);
T3=imfill(T2,'holes');
FDWN=bwareaopen(T3,1000);
CC1=bwconncomp(FDWN);
numFDWN=CC1.NumObjects;

%FIND FACEUP CARDS
I2=BW>0.91;  %identify faceup card
I3=imfill(I2,'holes'); %fill all holes but the shape was gone

LB=3000;
UB=4000;
I4=xor(bwareaopen(I3,LB),bwareaopen(I3,UB));%remove blobs greater than UB area and less than LB

Iout=imclearborder(I4,4); %remove blobs attached to the border
Iout=bwareaopen(Iout,1000); %remove smalle pixels
imshow(Iout);

Bwoutline=bwperim(Iout); %create a outline
border=BW;
border(Bwoutline)=0;
imshow(border)

%ISOLATE FACEUP
cards=BW;
mask=Iout<0.5; %create a mask to isolate the face up
cards(mask)=0;
figure, imshow(cards)
% imwrite(cards,'t3.png');

CC2=bwconncomp(cards); %find the connected blobs
numFUP=CC2.NumObjects; %number of Faceup cards
s2=regionprops(CC2,'BoundingBox'); %identify the card boundary
face_up=imcrop(BW,s2.BoundingBox);
figure,imshow(face_up);

numCards=numFUP+numFDWN; %number of cards

%find Features
corners = detectFASTFeatures(cards);
figure, imshow(BW); hold on
plot(corners)


numCards
numFUP
numFDWN