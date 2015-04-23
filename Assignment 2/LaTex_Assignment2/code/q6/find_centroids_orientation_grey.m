function [CentroidsX, CentroidsY, OrientationAngle] = find_centroids_orientation_grey(I)

% I=imread('tt1.png'); % read image

I2=imcrop(I,[68.5 4.5 491 472]); %isolate the workingspace
I3=double(I2)/255;  %convert to double
I4=adapthisteq(I3); %enhance contrast using adaptive histogram equalization
I5=I4<0.10;%0.1 %0.11 % find boxes using a threshold

C1=bwareaopen(I5,1000); %remove objects less than 1000 pixels/ Remove unnessosary regions
se=strel('square',15);  %create a structuring element of size 15 square
C2=imclose(C1,se); %morphologicaly close image
C4=imfill(C2,'holes'); %fill holes

s=regionprops(C4,'centroid'); %find centroids of regions
centroids=cat(1,s.Centroid); %make a array using centroids in the structured array
imshow(C4)
hold on
plot(centroids(:,1),centroids(:,2),'b*') %plot centorids with boxes

%Assigns numbers to each centroid
numbers = 1:length(centroids);
strValues = strtrim(cellstr(num2str(numbers(:),'(%d)')));
text(centroids(:,1),centroids(:,2),strValues,'VerticalAlignment','bottom');

%GetOrientation
TR = 2;
LT = 8;

p = regionprops(C4, 'Extrema');

hold on


for i = 1:length(p)

%     TR to LT  -    Best so far
    sides1 = p(i).Extrema(TR,:) - p(i).Extrema(LT,:); % Returns the sides of the square triangle that completes the two chosen extrema:
    plot(p(i).Extrema(LT,1),p(i).Extrema(LT,2),'bx','MarkerSize',20);
    plot(p(i).Extrema(TR,1),p(i).Extrema(TR,2),'bx','MarkerSize',20);

    OrAn1(i) = rad2deg(atan(-sides1(2)/sides1(1)));  % Note the 'minus' sign compensates for the inverted y-values in image coordinates    
    
end

hold off

%Find and remove fiducial boxes from centroids and orientation

x1=centroids(:,1);
y1=centroids(:,2);

for i=1:length(x1)
    if ((x1(i)< 60 & x1(i)>50)& (y1(i)<442 & y1(i)>432 ))
        B1=[x1(i),y1(i)];
    end
end

%Remove cordinates of fiducial boxes
OrAn1(B1(1,1)==x1)=[];
x1(B1(1,1)==x1)=[]; 
y1(B1(1,2)==y1)=[];

%find fiducial box_2 (270,220)
for i=1:length(x1)
    if ((x1(i)< 459 & x1(i)>249)& (y1(i)<431 & y1(i)>421 ))
        B2=[x1(i),y1(i)];
    end
end


OrAn1(B2(1,1)==x1)=[];
x1(B2(1,1)==x1)=[];
y1(B2(1,2)==y1)=[];

%find fiducial box_3 (-270,523)
for i=1:length(x1)
    if ((x1(i)< 53 & x1(i)>43)& (y1(i)<223 & y1(i)>213 ))
        B3=[x1(i),y1(i)];
    end
end

OrAn1(B3(1,1)==x1)=[];
x1(B3(1,1)==x1)=[];
y1(B3(1,2)==y1)=[];

%When only fiducial boxes present
TF=isempty(x1);
if TF==1
    warning('No objects detected other than fiducial boxes')
end

Yr=abs(p_dist_q6(B1,B2,x1,y1)); %distance from line going along centroids of box1 & box 2 (reference)
Xr=p_dist_q6(B1,B3,x1,y1);  %distance from line going along centroids of box1 & box 3 (reference)

%Find the reference point according to the world coordinates
    %X 792.8691 = 540 real , %Y 433.3300 = 303 real                                    
Yreal=((Yr*303)/219.3306)+220;    %REAL Y COORDINATE 
Xreal=((Xr*540)/399.4796)-270;    %REAL x COORDINATE

%Return X-Y coordinates of the centroid in real world coordinates, along
%with the orientation
CentroidsX = Xreal;
CentroidsY = Yreal;
OrientationAngle = OrAn1;

end

