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
imshow(T4)
hold on
plot(centroids(:,1),centroids(:,2),'b*') %plot centorids with boxes
hold off

%matching x,y in the world cordinates
x=centroids(:,1);
y=centroids(:,2);

Y=x*(523-220)/(724.1845-291.9483)+15.3426; %Y cordinate in the world cordinate
X=(y-480)*(540/(876.9374-85.0221)); %X cordinate in the world cordinate

