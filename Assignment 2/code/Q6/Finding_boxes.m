close all
clear
clc

I=imread('tt.png');  % read the file

%remove shadow
I2=rgb2hsv(I); %convert rgb to high saturation version
C1=I2(:,:,2); %get the bw from G
C2=C1<0.4; % find shadow using manual threshold
C3=C2<1; % transverse black n white
Tgray=I2(:,:,3); % Bw of Image
X=Tgray+C3; %remove shadow

X2=X<0.33; 

T2=bwareaopen(X2,3000);      %remove all objects less than 3000 pixels
se=strel('square',5);   %fill gaps using squares with width of 20
T3=imclose(T2,se);
T4=imfill(T3,'holes'); %fill all holes

s=regionprops(T4,'centroid');  %create a stuctured array of s with centorids in all close regions
centroids=cat(1,s.Centroid); %create a array from s
%imshow(T4)
%hold on
%plot(centroids(:,1),centroids(:,2),'b*') %plot centorids with boxes
%hold off

%Rotating the image to make reference points vertical
x1=centroids(:,1);
y1=centroids(:,2);

%find fiducial box_1 (-270,220)
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
    warning('No objects detected')
end


theta=atand((x1(1)-x1(2))/(y1(1)-y1(2))); %theta degrees between 1st two centroids and y axis
T5=imrotate(T4,-theta);   %rotate image theta degrees

figure
s2=regionprops(T5,'centroid');  %create a stuctured array of s with centorids in all close regions
centroids2=cat(1,s2.Centroid); %create a array from s
imshow(T5)
hold on
plot(centroids2(:,1),centroids2(:,2),'b*') %plot centorids with boxes
hold off

%matching x,y in the world cordinates
x2=centroids2(:,1);
y2=centroids2(:,2);

Y=x2*(523-220)/(734.8936-302.6777)+7.8113; %Y cordinate in the world cordinate
X=(y2-480)*(540/(881.7552-89.8304))-3.95; %X cordinate in the world cordinate
