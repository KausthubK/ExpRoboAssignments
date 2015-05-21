close all
clear
clc

I(1).image=imread('test_image11.png');
I(2).image=imread('test_image14.png');
figure
subplot(1,2,1);imshow(I(1).image);
subplot(1,2,2);imshow(I(2).image);

for i=1:length(I)
    [numCards, numFUP, numFDWN, coordsFUP, coordsFDWN ,flag] = surveyField(I(i).image);
    I(i).flag=flag;
    
end

if I(1).flag==I(2).flag
    disp 'Match FOUND SUCKkkkkerrrs'
else
    disp 'Not Matching'
end
