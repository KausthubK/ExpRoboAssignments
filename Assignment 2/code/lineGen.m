close all
clear all
clc
    
% data randomiser

% straight line
xpoint = 4*ones(1, 100);
ypoint = 1 + (5-1).*rand(1, 100);

%wonky line


%plot
plot(xpoint, ypoint, 'rx');
hold on;
[L1, d1] = LSM(xpoint, ypoint);

if(d1 == 0)
    plot(xpoint, ypoint);
    hold on;
else
    L1Fit = polyval(L1, xpoint);
    plot(L1Fit, 'g');
    hold on;
end