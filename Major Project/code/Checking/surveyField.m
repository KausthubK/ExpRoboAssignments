% % Survey Field V1.1 
% % Modifications: surveyField has been modified to include an input of an image "I" which was previously not there in V0


function [numCards, numFUP, numFDWN, coordsFUP, coordsFDWN, flag] = surveyField(I)

% surveyField captures an image of the playing field from the camera
% OUTPUTS
% %     numcards  - number of cards on the playing field
% %     numFUP    - number of cards that were found face up
% %     numFDWN   - number of cards that were found face down
% %     coordsFUP - 3 column array [x1, y1, pose1; ... ; xn, yn, posen] for face ups
% %     coordsFDWN- 3 column array [x1, y1, pose1; ... ; xn, yn, posen] for face down

% INPUTS
% %     I         - input image

% will require the following subsidiary functions
% % findFiducials(image)


BW=double(I)/255; %convert to double

%FIND FACEDOWN CARDS
T1=BW<0.1;
T2=imclearborder(T1,4);
T3=imfill(T2,'holes');
FDWN=bwareaopen(T3,1000);
CC1=bwconncomp(FDWN);
numFDWN=CC1.NumObjects;

sFDWN=regionprops(CC1,'centroid'); %find centroids of face down cards
centroidsFDWN=cat(1,sFDWN.Centroid); %cetroids of face downs
coordsFDWN=centroidsFDWN; %%%%%%%%Need to match with WORLD

%FIND FACEUP CARDS
I2=BW>0.91;  %identify faceup card
I3=imfill(I2,'holes'); %fill all holes but the shape was gone

LB=3000;
UB=4000;
I4=xor(bwareaopen(I3,LB),bwareaopen(I3,UB));%remove blobs greater than UB area and less than LB

Iout=imclearborder(I4,4); %remove blobs attached to the border
Iout=bwareaopen(Iout,1000); %remove smalle pixels

Bwoutline=bwperim(Iout); %create a outline
border=BW;
border(Bwoutline)=0;

%ISOLATE FACEUP
cards=BW;
mask=Iout<0.5; %create a mask to isolate the face up
cards(mask)=0;
CC2=bwconncomp(cards); %find the connected blobs
numFUP=CC2.NumObjects; %number of Faceup cards
numCards=numFUP+numFDWN; %number of cards

s2=regionprops(CC2,'BoundingBox'); %identify the card boundary

    for i=1:numFUP
    %EXTRACT ISOLATED FACEUP
    face_up(i).image=imcrop(BW,s2(i).BoundingBox);
    
    %DETECT FEATURES
    E=edge(face_up(i).image,'canny');
    T10=imfill(E,'holes');
    T11=bwareaopen(T10,200);

    CC3=bwconncomp(T11);
    s3=regionprops(CC3,'Perimeter');
    face_up(i).perim=s3.Perimeter;
    
    %DEFINING CARD
        if s3.Perimeter<82 && s3.Perimeter>75;
            face_up(i).flag=1; %1 rectangle in set card
        else s3.Perimeter<71 && s3.Perimeter>64;
            face_up(i).flag=2; %1 trangle in set card
        end
    end


%POSITION OF FACEUPS
sFUP=regionprops(CC2,'centroid'); %find centroids of face ups
centroids=cat(1,sFUP.Centroid); %centroids of faceups
coordsFUP=centroids; %%%%%%%%Need to match with WORLD

flag=face_up(1).flag;

end