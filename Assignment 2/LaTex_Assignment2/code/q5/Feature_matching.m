%This code is using harris algorithm to find corners and extractFeatures
%and matchFeatures Functions in matlab image toolbox to match features
%in two images.

close all
clear
clc
x=0;
y=0;


I1=imread('whitehouse.left.png');
I2=imread('whitehouse.right.png');

%Check whether the image is RGB and convert that to gray
if length(size(I1))==3 & length(size(I2))==3;
    BW1=rgb2gray(I1);
    BW2=rgb2gray(I2);
    x=1;
else
BW1=I1;
BW2=I2;
end

im=appendimages(I1,I2); %create a one image using two images

p1 = detectHarrisFeatures(BW1); %Find corners using Harris Algorithm
p2 = detectHarrisFeatures(BW2);


[features1, valid_points1] = extractFeatures(BW1, p1); %Extract Features and valid points using detected corners
[features2, valid_points2] = extractFeatures(BW2, p2);

indexPairs = matchFeatures(features1, features2,'MatchThreshold',80); %Finding Matching Features of two images

matchedPoints1 = valid_points1(indexPairs(:, 1), :);
matchedPoints2 = valid_points2(indexPairs(:, 2), :);

figure; showMatchedFeatures(BW1, BW2, matchedPoints1, matchedPoints2,'montage'); %show matching features
