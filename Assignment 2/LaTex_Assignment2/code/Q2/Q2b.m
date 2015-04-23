%
% Author: Stefan Williams (stefanw@acfr.usyd.edu.au)
%
%

clear 
close all

% load laser files
laser_scans=load('..\datasets\captureScanshornet.txt');

t0 = laser_scans(1,1);

figure
for i = 1
    tlaser = laser_scans(i,1) - t0;
     xpoint = zeros(1);
     ypoint = zeros(1);
     for j = 2:size(laser_scans,2)
         range = laser_scans(i,j) / 1000;
         bearing = ((j-1)/2 - 90)*pi/180;
         if (range < 75)
             xpoint = [xpoint range*cos(bearing)];
             ypoint = [ypoint range*sin(bearing)];
         end
     end
     
     p1 = plot(xpoint(:), ypoint(:), '.');
     axis equal;
     axis([0 10 -5 5]);
     xlabel('X (meter)')
     ylabel('Y (meter)')
     title(sprintf('ACFR indoor SICK data: scan %d',i))
     drawnow
     saveas(p1, 'laserACFRscan1.png');
end
     % Finding lines with Hough transform
% http://graphics.lcs.mit.edu/~ifni/tutorials/hough_line/find_hough_lines.html

% Load an image
%I = imread('indoor1.jpeg');
%I = imread('pacman_ctf.png');
I = imread('laserACFRscan1.png');
I = imcrop(I,[[264.5 81.5 713 708]]);
I = double(imresize(I(:,:,2),.2))/255;  

figure, imshow(I)
title ('Original Image')
% Compute magnitude of image gradient
% H = fspecial('sobel'); V = -H';
% E = sqrt(filter2(H,I).^2+filter2(V,I).^2);  

% or threshold its edges
E = edge(I, 'sobel');
figure, imshow(E);
title ('Gradient Image')

% Use matlab's radon function to compute the hough transform:
theta = (0:179)';
[R,xp] = radon(E,theta);
figure
imagesc(theta,xp,R), colorbar;
xlabel ('theta (deg)'), ylabel ('rho (pixels from center)')
title('Line Space');

% Find peaks in the linespace:
guessR = max(max(R))- 10;
% i = find(R>250); % Marked by Bob Wang 
i = find( R > guessR); 

% Sort the output and pick the top lines
[foo,ind] = sort(-R(i));
k = i(ind(1:size(ind))); % Modified by Bob Wang  

% Convert linear index into coordinates of the peaks.
[y,x] = ind2sub(size(R),k);  

% Note: this part need some more work or ingenuity.  
% It should find well defined peaks that are true local maxima, 
% and not just high values next to a maximum.
figure
imagesc(theta,xp,R), colorbar;
xlabel ('theta (deg)'), ylabel ('rho (pixels from center)')
% numplot([theta(x) xp(y)]), title('location of peaks'); % marked by Bob Wang


% Find the theta and rho values for the peak coordinates.  
% Note that matlab's radon function uses an upside-down convention 
% for specifying the rotation (theta).  Therefore, I just negate the 
% theta value to compensate.

t = -theta(x)*pi/180;
r = xp(y);  

% The lines parameters are computed as follows.  
% The line parameters have the coefficents of the equation Ax + By + C = 0, 
% and are invarient to scale.  However this particular scaling will produce 
% the distance of a point to the line with the dot product: [A; B; C]' * [x; y; 1].

lines = [cos(t) sin(t) -r];

% Transform the line from the center of the image to the upper left.  (The minus ones are for matlabs 1 based coordinates.)
cx = size(I,2)/2-1;
cy = size(I,1)/2-1;
lines(:,3) = lines(:,3) - lines(:,1)*cx - lines(:,2)*cy;

% Here are the top lines drawn on the gradient image
figure
imshow(E); title('Gradient image with lines');
draw_lines(lines);