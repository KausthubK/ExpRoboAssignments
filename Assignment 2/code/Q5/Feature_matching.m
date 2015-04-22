close all
clear
clc
x=0;
y=0;


I1=imread('whitehouse.left.png');
I2=imread('whitehouse.right.png');

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
points1=detectHarrisFeatures(BW1);
points2=detectHarrisFeatures(BW2);

im=appendimages(I1,I2);

points1 = detectHarrisFeatures(BW1);
points2 = detectHarrisFeatures(BW2);

[features1, valid_points1] = extractFeatures(BW1, points1);
[features2, valid_points2] = extractFeatures(BW2, points2);

indexPairs = matchFeatures(features1, features2,'MatchThreshold',80);

matchedPoints1 = valid_points1(indexPairs(:, 1), :);
matchedPoints2 = valid_points2(indexPairs(:, 2), :);

figure; showMatchedFeatures(BW1, BW2, matchedPoints1, matchedPoints2);
