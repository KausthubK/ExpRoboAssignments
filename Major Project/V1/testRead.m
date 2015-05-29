% % % TEST: Read
% % % MTRX5700 Major Assignment 2015
% % % Authors: Kausthub Krishnamurthy & James Ferris & Sachith
% Gunawardhana

clear
close all
clc
cards = struct('index', {},'x', {}, 'y', {}, 'pose', {}, 'shape', {}, 'colour', {}, 'filler', {}, 'count', {}, 'viewedFlag', {});

%get images
I20 = imread('../test_images_gray/test_image20.png');
I21 = imread('../test_images_gray/test_image21.png');
I22 = imread('../test_images_gray/test_image22.png');
I23 = imread('../test_images_gray/test_image23.png');
I24 = imread('../test_images_gray/test_image24.png');
I25 = imread('../test_images_gray/test_image25.png');
I25 = imread('../test_images_gray/test_image26.png');
I27 = imread('../test_images_gray/test_image27.png');

disp 'I20:'
[cards(1).viewedFlag, cards(1).shape, cards(1).colour, cards(1).filler, cards(1).count] = readCard(I20);


