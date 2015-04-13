close all
clear all
clc
    
% data randomiser

% % vertical straight line (fail case)
% xpoint = 4*ones(1, 100);
% ypoint = 1 + (5-1).*rand(1, 100);
%

% % % horizontal straight line
%  %ypoint = 4*ones(1, 100);
%  xpoint = 1 + (5-1).*rand(1, 100);
% % %  diagonal line
%  ypoint = (xpoint.*ones(1, 100));

xpoint = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15];
ypoint = [1 1 1 1 1 1 2 3 4 5 6 7  8 9 10];

%plot
plot(xpoint, ypoint, 'rx');
hold on;

corners = line_segmentation(xpoint, ypoint, 0.5)


%[L1, d1] = LSM(xpoint, ypoint);

% if(d1 == 0)
%     plot(xpoint, ypoint);
%     hold on;
% else
%     L1Fit = polyval(L1, xpoint);
%     plot(L1Fit, 'g');
%     hold on;
% end