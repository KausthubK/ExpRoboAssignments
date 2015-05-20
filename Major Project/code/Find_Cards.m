close all
clear
clc

I=imread('test_image18.png');
BW=double(I)/255; %convert to double

I2=BW>0.91;  %identify faceup card
I3=imfill(I2,'holes'); %fill all holes but the shape was gone

%remove blobs greater than some area and less than some area
LB=3000;
UB=4000;
I4=xor(bwareaopen(I3,LB),bwareaopen(I3,UB));

Iout=imclearborder(I4,4);
imshow(Iout);

%create a outline
Bwoutline=bwperim(Iout);
border=BW;
border(Bwoutline)=0;
imshow(border)