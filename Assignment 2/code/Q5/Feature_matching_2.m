close all
clear
clc
x=0;
y=0;

I1=imread('kk1.jpg');
I2=imread('kk2.jpg');

% I1=imread('whitehouse.left.png');
% I2=imread('whitehouse.right.png');

% I1=imread('image.seq10.png');
% I2=imread('image.seq11.png');

if length(size(I1))==3 & length(size(I2))==3;
    BW1=rgb2gray(I1);
    BW2=rgb2gray(I2);
    x=1;
else
BW1=I1;
BW2=I2;
end

E_canny_I1=edge(BW1,'canny',[0.1,0.4]);
figure
imshow(E_canny_I1);
title('Canny Edge Detector');

E_canny_I2=edge(BW2,'canny',[0.1,0.4]);
figure
imshow(E_canny_I2);
title('Canny Edge Detector');