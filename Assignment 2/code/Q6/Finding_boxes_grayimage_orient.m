close all
clear
clc

I=imread('tt1.png'); % read image

I2=imcrop(I,[68.5 4.5 491 472]); %isolate the workingspace
I3=double(I2)/255;  %convert to double
I4=adapthisteq(I3); %enhance contrast using adaptive histogram equalization
I5=I4<0.10;%0.1 %0.11 % find boxes using a threshold

C1=bwareaopen(I5,1000); %remove objects less than 1000 pixels/ Remove unnessosary regions
se=strel('square',25);  %create a structuring element of size 15 square
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

hold off

x1=centroids(:,1);
y1=centroids(:,2);

%find fiducial box_1 (-270,220)

for i=1:length(x1)
    if ((x1(i)< 60 & x1(i)>50)& (y1(i)<442 & y1(i)>432 ))
        B1=[x1(i),y1(i)];
    end
end
x1
aaa = B1(1,1)==x1
x1(B1(1,1)==x1)

x1(B1(1,1)==x1)=[]; %remove cordinates of fiducial boxes
y1(B1(1,2)==y1)=[];

%find fiducial box_2 (270,220)
for i=1:length(x1)
    if ((x1(i)< 459 & x1(i)>249)& (y1(i)<431 & y1(i)>421 ))
        B2=[x1(i),y1(i)];
    end
end
bbb =B2(1,1)==x1;
x1(B2(1,1)==x1)=[];
y1(B2(1,2)==y1)=[];

%find fiducial box_3 (-270,523)
for i=1:length(x1)
    if ((x1(i)< 53 & x1(i)>43)& (y1(i)<223 & y1(i)>213 ))
        B3=[x1(i),y1(i)];
    end
end
ccc= B3(1,1)==x1;
x1(B3(1,1)==x1)=[];
y1(B3(1,2)==y1)=[];

%When only fiducial boxes present
TF=isempty(x1);
if TF==1
    warning('No objects detected other than fiducial boxes')
end

Yr=abs(p_dist_q6(B1,B2,x1,y1)); %distance from line going along centroids of box1 & box 2 (reference)
Xr=p_dist_q6(B1,B3,x1,y1);  %distance from line going along centroids of box1 & box 3 (reference)

%find the reference point according to the world cordinates
    %X 792.8691 = 540 real , %Y 433.3300 = 303 real                                    
Yreal=((Yr*303)/219.3306)+220;    %REAL Y CORDINATE 
Xreal=((Xr*540)/399.4796)-270;    %REAL x CORDINATE



% 
% figure
% subplot(2,2,1),imshow(I2);
% subplot(2,2,2),imshow(I5);
% subplot(2,2,3),imshow(C2);
% subplot(2,2,4),imshow(C4);


% b = regionprops(C4, 'BoundingBox');
% for k = 1 : length(b)
%   thisBB = b(k).BoundingBox;
%   rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
%   'EdgeColor','r','LineWidth',2 )
% end

TL = 1;
TR = 2;
RT = 3;
RB = 4;
BR = 5;
BL = 6;
LB = 7;
LT = 8;


o=regionprops(C4,'orientation');
p = regionprops(C4, 'Extrema');
c = regionprops(C4, 'Centroid');
m = regionprops(C4, 'MajorAxisLength');

hold on

for i = 1:length(p)
    X(1) = p(i).Extrema(BL,1);
    Y(1) = p(i).Extrema(BL,2);
    X(2) = p(i).Extrema(LB,1);
    Y(2) = p(i).Extrema(LB,2);
    X(3) = p(i).Extrema(LT,1);
    Y(3) = p(i).Extrema(LT,2);
    X(4) = p(i).Extrema(TL,1);
    Y(4) = p(i).Extrema(TL,2);
    X(5) = p(i).Extrema(TR,1);
    Y(5) = p(i).Extrema(TR,2);
    X(6) = p(i).Extrema(RT,1);
    Y(6) = p(i).Extrema(RT,2);
    X(7) = p(i).Extrema(RB,1);
    Y(7) = p(i).Extrema(RB,2);
    X(8) = p(i).Extrema(BR,1);
    Y(8) = p(i).Extrema(BR,2);
    X(9) = p(i).Extrema(BL,1);
    Y(9) = p(i).Extrema(BL,2);
    X(10) = p(i).Extrema(TR,1);
    Y(10) = p(i).Extrema(TR,2);     
    plot(X,Y,'g');
end


boxPixelWidth = 80*(540/792.8691);
for i = 1:length(p)

%     TR to LT  -    Best so far
    sides1 = p(i).Extrema(TR,:) - p(i).Extrema(LT,:); % Returns the sides of the square triangle that completes the two chosen extrema:
    plot(p(i).Extrema(LT,1),p(i).Extrema(LT,2),'bx','MarkerSize',20);
    plot(p(i).Extrema(TR,1),p(i).Extrema(TR,2),'bx','MarkerSize',20);
    length(i) = sqrt( (p(i).Extrema(TR,1) - p(i).Extrema(LT,1))^2 + (p(i).Extrema(TR,2) - p(i).Extrema(LT,2))^2);

    OrAn1(i) = rad2deg(atan(-sides1(2)/sides1(1)));  % Note the 'minus' sign compensates for the inverted y-values in image coordinates    
    
%     BL to RB - Decent
    sides2 = p(i).Extrema(BL,:) - p(i).Extrema(RB,:);
    plot(p(i).Extrema(RB,1),p(i).Extrema(RB,2),'rx','MarkerSize',20);
    plot(p(i).Extrema(BL,1),p(i).Extrema(BL,2),'rx','MarkerSize',20);
        
    OrAn2(i) = rad2deg(atan(-sides2(2)/sides2(1)));  % Note the 'minus' sign compensates for the inverted y-values in image coordinates
       

%     %TL to LB - Good
    sides3 = p(i).Extrema(TL,:) - p(i).Extrema(LB,:);
    plot(p(i).Extrema(LB,1),p(i).Extrema(LB,2),'mx','MarkerSize',20);
    plot(p(i).Extrema(TL,1),p(i).Extrema(TL,2),'mx','MarkerSize',20);
    
    OrAn3(i) = rad2deg(atan(-sides3(2)/sides3(1)));  % Note the 'minus' sign compensates for the inverted y-values in image coordinates
       
    
%     %BR to RT - ok ish
    sides4 = p(i).Extrema(BR,:) - p(i).Extrema(RT,:);
    plot(p(i).Extrema(RT,1),p(i).Extrema(RT,2),'cx','MarkerSize',20);
    plot(p(i).Extrema(BR,1),p(i).Extrema(BR,2),'cx','MarkerSize',20);
    
    OrAn4(i) = rad2deg(atan(-sides4(2)/sides4(1)));  % Note the 'minus' sign compensates for the inverted y-values in image coordinates
           
end

OrAn1(aaa) = []
OrAn1(bbb) = []
OrAn1(ccc) = []


for i = 1:length(OrAn1)
    
    Average1(i) = (OrAn1(i) + OrAn2(i))/2;
    Average2(i) = (OrAn3(i) + OrAn4(i))/2;
    fprintf('%d -->\tExt1: %f\t\tExt2: %f\t\tAvg1: %f\n', i,  OrAn1(i), OrAn2(i), Average1(i));
    fprintf('\t\t\tExt3: %f\t\tExt4: %f\t\tAvg2: %f\n\t\tX: %f\t\tY: %f\n', OrAn3(i), OrAn2(i), Average2(i), c(i).Centroid(1), -c(1).Centroid(2));

end
% 

boxPixelWidth = 80*(540/792.8691);
% boxDiagonal = sqrt(2*boxPixelWidth^2)
% m = regionprops(C4, 'MajorAxisLength');
% disp('MajorAxisLength');
% for i = 1:length(m)
%     disp(m(i).MajorAxisLength);
% end

%%consider Harris?
% harris = detectHarrisFeatures(C4);
% plot(harris)
