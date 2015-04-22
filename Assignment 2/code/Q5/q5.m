close all
clear
clc

I1=imread('image.seq10.png'); %Read image file 1
I2=imread('image.seq11.png');%Read image file 2

BW1=rgb2gray(I1); %convert to gray scale
BW2=rgb2gray(I2);

%a.1 Sobel Edge detector
E_sobel_I1=edge(BW1,'sobel');
figure
imshow(E_sobel_I1);
title('Sobel Edge Detector');
%E_sobel_I2=edge(BW2,'sobel'); 

%a.2 Canny Edge Detector
E_canny_I1=edge(BW1,'canny',[0.1,0.4]);
figure
imshow(E_canny_I1);
title('Canny Edge Detector');
%E_canny_I2=edge(BW2,'canny',[0.1,0.4]); %E_canny_I2=edge(I2_gray,'canny',[0.05,0.25]);

%Harris Corners
I1_harris=corner(BW1,'harris');
figure
imshow(BW1);
hold on
plot(I1_harris(:,1),I1_harris(:,2),'r*');
title('Harris corners');

%c. Sift Corners
[image, descrips, locs] = sift('tt.png');
showkeys(image, locs);

%d. Matching Features algorithom (Have used the example code given)
match('whitehouse.left.png','whitehouse.right.png');
