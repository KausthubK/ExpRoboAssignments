close all
clear
clc

I=imread('tt2.png');

%remove shadow
I2=rgb2hsv(I); %convert rgb to high saturation version
T=I2(:,:,2); %get the bw from G
T1=T<0.3; % find shadow using manual threshold
T2=T1<1; % transverse black n white
Tgray=I2(:,:,3); % Bw of Image
X=Tgray+T2; %remove shadow

X2=X<0.33; %find box

C1=bwareaopen(X2,3000);
se=strel('square',5);
C3=imclose(C1,se);
C4=imfill(C3,'holes');

%imshow(C4)
%subplot(2,2,1), imshow(I);
%subplot(2,2,2), imshow(C1);

s=regionprops(C4,'centroid');
centroids=cat(1,s.Centroid);
% imshow(C4)
% hold on
% plot(centroids(:,1),centroids(:,2),'b*') %plot centorids with boxes
% hold off

x1=centroids(:,1);
y1=centroids(:,2);


%find fiducial box_1 (-270,220)
% B1(1,1)=x1(x1(:,1)<297 & x1(:,1)>288);
% B1(1,2)=y1(y1(:,1)<88 & y1(:,1)>78);
% x1(B1(1,1)==x1)=[];
% y1(B1(1,2)==y1)=[];

for i=1:length(x1)
    if ((x1(i)< 297 & x1(i)>287)& (y1(i)<88 & y1(i)>78 ))
        B1=[x1(i),y1(i)];
    end
end

x1(B1(1,1)==x1)=[];
y1(B1(1,2)==y1)=[];

%find fiducial box_2 (270,220)
for i=1:length(x1)
    if ((x1(i)< 305 & x1(i)>295)& (y1(i)<881 & y1(i)>871 ))
        B2=[x1(i),y1(i)];
    end
end

x1(B2(1,1)==x1)=[];
y1(B2(1,2)==y1)=[];

%find fiducial box_3 (-270,523)
for i=1:length(x1)
    if ((x1(i)< 731 & x1(i)>721)& (y1(i)<81 & y1(i)>71 ))
        B3=[x1(i),y1(i)];
    end
end

x1(B3(1,1)==x1)=[];
y1(B3(1,2)==y1)=[];


TF=isempty(x1);
if TF==1
    warning('No objects detected other than fiducial boxes')
end

Yr=abs(p_dist_q6(B1,B2,x1,y1)); %distance from line going along centroids of box1 & box 2 (reference)
Xr=p_dist_q6(B1,B3,x1,y1);  %distance from line going along centroids of box1 & box 3 (reference)

%find the reference point according to the world cordinates
    %X 792.8691 = 540 real , %Y 433.3300 = 303 real                                    
Yreal=((Yr*303)/433.3300)+220;    %REAL Y CORDINATE 
Xreal=((Xr*540)/792.8691)-270;    %REAL x CORDINATE

% subplot(2,2,1), imshow(I); title 'Original' 
imshow(C4); title 'with centroids', hold on, plot(centroids(:,1),centroids(:,2),'b*'); hold off 
% subplot(2,2,3), imshow(T1); title 'shadow'


b = regionprops(C4, 'BoundingBox');
for k = 1 : length(b)
  thisBB = b(k).BoundingBox;
  rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
  'EdgeColor','r','LineWidth',2 )
end

o=regionprops(C4,'orientation');
p = regionprops(C4, 'Extrema');
for i = 1:length(p)
%     sides = p(i).Extrema(4,:) - p(i).Extrema(6,:); % Returns the sides of the square triangle that completes the two chosen extrema: Bottom-Right and Left-Bottom
    sides = p(i).Extrema(6,:) - p(i).Extrema(2,:);
%     OrientationAngle(i) = rad2deg(atan(-sides(2)/sides(1)));  % Note the 'minus' sign compensates for the inverted y-values in image coordinates
% 
%     disp(OrientationAngle(i));
% 
%     disp(o(i).Orientation);
end


% 
% boxPixelSize = 80*(792.8691/540)
% boxDiagonal = sqrt(2*boxPixelSize^2)
% m = regionprops(C4, 'MajorAxisLength');
% disp('MajorAxisLength');
% for i = 1:length(m)
%     disp(m(i).MajorAxisLength);
% end