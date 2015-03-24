close all
clear
clc

DEGREES = pi/180;
RADIANS = 180/pi;

R1 = [0.7500, -0.4330, -0.5000; 0.2165,0.8750, -0.4330; 0.6250, 0.2165, 0.7500]


determinantR1 = det(R1)
inverseR1 = inv(R1)
transposeR1 = transpose(R1)

beta1 = asin(-1*R1(3,1));
gamma1 = asin(R1(3,2)/cos(beta1));
alpha1 = acos(R1(1,1)/cos(beta1));

alpha1 = alpha1*RADIANS
beta1 = beta1*RADIANS
gamma1 = gamma1*RADIANS

R2 = [0.7725, -0.4460, -0.5150; 0.2165, 0.8750, -0.4330; 0.6000, 0.2078, 0.7200]
determinantR2 = det(R2)
inverseR2 = inv(R2)
transposeR2 = transpose(R2)

beta2 = asin(-1*R2(3,1));
gamma2 = asin(R2(3,2)/cos(beta2));
alpha2 = acos(R2(1,1)/cos(beta2));

alpha2 = alpha2*RADIANS
beta2 = beta2*RADIANS
gamma2 = gamma2*RADIANS

R3 = [0, 0, 1; 0.8660, 0.500, 0; -0.500, 0.8660, 0]
determinantR3 = det(R3)
inverseR3 = inv(R3)
transposeR3 = transpose(R3)

beta3 = asin(-1*R3(3,1));
gamma3 = asin(R3(3,2)/cos(beta3));
alpha3 = acos(R3(1,1)/cos(beta3));

alpha3 = alpha3*RADIANS
beta3 = beta3*RADIANS
gamma3 = gamma3*RADIANS

R4 = [-0.7500, -0.2165, -0.6250; 0.4330, -0.8750, -0.2165; 0.500, 0.4330, -0.7500]
determinantR4 = det(R4)
inverseR4 = inv(R4)
transposeR4 = transpose(R4)

beta4 = asin(-1*R4(3,1));
gamma4 = asin(R4(3,2)/cos(beta4));
alpha4 = acos(R4(1,1)/cos(beta4));

alpha4 = alpha4*RADIANS
beta4 = beta4*RADIANS
gamma4 = gamma4*RADIANS