close all
clear
clc

I=imread('tt.png');  % read the file
G=rgb2gray(I); %change it to gray scale
T=(G<75);       %manualy creating a image with boxes only, using a threshold of 75

T2=bwareaopen(T,3000);      %remove all objects less than 3000 pixels
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
