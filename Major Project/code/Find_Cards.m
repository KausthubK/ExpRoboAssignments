close all
clear
clc

I=imread('test_image21.png');%read the image
BW=double(I)/255; %convert to double
% figure,imshow(BW);

%FIND FACEDOWN CARDS
T1=BW<0.1;
T2=imclearborder(T1,4);
T3=imfill(T2,'holes');
FDWN=bwareaopen(T3,1000);
CC1=bwconncomp(FDWN);
numFDWN=CC1.NumObjects;
%%%%%%%%%%%%%%%%%%%NEEED A STRUCTURE TO CLEAN%%%%%%%%%%%%%%%

sFDWN=regionprops(CC1,'centroid'); %find centroids of face down cards
centroidsFDWN=cat(1,sFDWN.Centroid); %cetroids of face downs


count=8; %decrease this as we remove a card from the table

%FIND FACEUP CARD
Icheck=imcrop(BW,[183.5 2.5 254 221]);
I2=Icheck>0.72;  %identify faceup card
I3=imfill(I2,'holes'); %fill all holes but the shape was gone
se=strel('square',9);
IE=imerode(I3,se);
I4=imclearborder(IE,4);
Iout=bwareaopen(I4,10800);
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
numFUP=CC2.NumObjects; %number of Faceup cards
numCards=numFUP+numFDWN; %number of cards
% figure, imshow(cards)
% imwrite(cards,'t3.png');

s2=regionprops(CC2,'BoundingBox'); %identify the card boundary


for i=1:numFUP
    %EXTRACT ISOLATED FACEUP
    face_up(i).image=imcrop(Icheck,s2(i).BoundingBox);

    %DETECT FEATURES
    E=edge(face_up(i).image,'canny');
    T10=imfill(E,'holes');
    T11=bwareaopen(T10,200);
%   figure,imshow(T11);

    CC3=bwconncomp(T11);
    s3=regionprops(CC3,'Perimeter');
    face_up(i).perim=s3.Perimeter;

    %DEFINING CARD
    if s3.Perimeter<162 && s3.Perimeter>155;
        face_up(i).flag=1; %1 rectangle in set card
    elseif s3.Perimeter<90 && s3.Perimeter>85;
        face_up(i).flag=2; %1 trangle in set card
    elseif s3.Perimeter<137 && s3.Perimeter>132;
        face_up(i).flag=3; %1 elipse in set card
    end
end


%POSITION OF FACEUPS
sFUP=regionprops(CC2,'centroid'); %find centroids of regions
centroids=cat(1,sFUP.Centroid); %make a array using centroids in the structured array
% figure, imshow(BW)
% hold on
% plot(centroids(:,1),centroids(:,2),'b*') %plot centorids with boxes
% hold off

% if numFUP==2
%     if face_up(1).flag==face_up(2).flag;
%         disp 'A Match Found Fuckkkerrrrssssss'
%     end
% end
if face_up(1).flag==1
    disp 'RECTANGLE'
elseif face_up(1).flag==2
    disp 'TRANGLE'
elseif face_up(1).flag==3
    disp 'ELIPSE'
end

%     numCards
%     numFUP
%     numFDWN
