close all
clear
clc

I=imread('test_image27.png');%read the image
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
% LB=3000;
% UB=4000;
% I4=xor(bwareaopen(IE,LB),bwareaopen(IE,UB));%remove blobs greater than UB area and less than LB
% Iout=imclearborder(I4,4); %remove blobs attached to the border
% Iout=bwareaopen(Iout,1000); %remove smalle pixels
%figure,imshow(Iout);

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
if s3.Perimeter<162 && s3.Perimeter>155;
    face_up(1).flag=1; %1 rectangle in set card
elseif s3.Perimeter<90 && s3.Perimeter>85;
    face_up(1).flag=2; %1 trangle in set card
elseif s3.Perimeter<137 && s3.Perimeter>132;
    face_up(1).flag=3; %1 elipse in set card
end

if face_up(1).flag==1
    disp 'RECTANGLE'
elseif face_up(1).flag==2
    disp 'TRANGLE'
elseif face_up(1).flag==3
    disp 'ELIPSE'
end
imshow(cards);