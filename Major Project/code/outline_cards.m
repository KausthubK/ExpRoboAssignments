close all
clear
clc

I=imread('test_image11.png');
I2=im2double(I);

%binary gradient mask
[~,threshold]=edge(I2,'sobel'); %find threshold according to the gradient of the image
factor=1;
Bw=edge(I2,'sobel',threshold*factor); %tuning threshold

%dilate image
se90=strel('line',3,90);
se0=strel('line',3,0);
bwdil=imdilate(Bw,[se90 se0]);

%fill interior gaps
bwfill=imfill(bwdil,'holes');

%remove objects connected on border
bwnobord=imclearborder(bwfill,4);

%remove pixel areas less than 500
bwr=bwareaopen(bwnobord,500);

%close areas using a structred element
seS=strel('square',20);
BWfinal=imclose(bwr,seS);

%create a outline
Bwoutline=bwperim(BWfinal);
border=I2;
border(Bwoutline)=255;
imshow(border)

