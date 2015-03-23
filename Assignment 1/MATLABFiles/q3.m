close all
clear all
clc

%%uninitialised symbolic values
th = sym('th',[1 6]);
d = sym('d', [1 6]);
al = sym('al',[1 6]);
r = sym('a',[1 6]);

%%initialised known values
d(1) = 67;
d(2) = 0;
d(3) = 0;
d(4) = 0;
d(5) = 0;
d(6) = 0;

al(1) = pi()/2;
al(2) = 0;
al(3) = -pi()/2;
al(4) = pi()/2;
al(5) = -pi()/2;
al(6) = 0;

r(1) = 100;
r(2) = 250;
r(3) = 0;
r(4) = 250;
r(5) = 0;
r(6) = 250;
   
A_01 = [cos(th(1)) -sin(th(1))*cos(al(1)) sin(th(1))*sin(al(1)) r(1)*cos(th(1));sin(th(1)) cos(th(1))*cos(al(1)) -cos(th(1))*sin(al(1)) r(1)*sin(th(1));0 sin(al(1)) cos(al(1)) d(1);0 0 0 1];
A_12 = [cos(th(2)) -sin(th(2))*cos(al(2)) sin(th(2))*sin(al(2)) r(2)*cos(th(2));sin(th(2)) cos(th(2))*cos(al(2)) -cos(th(2))*sin(al(2)) r(2)*sin(th(2));0 sin(al(2)) cos(al(2)) d(2);0 0 0 1];
A_23 = [cos(th(3)) -sin(th(3))*cos(al(3)) sin(th(3))*sin(al(3)) r(3)*cos(th(3));sin(th(3)) cos(th(3))*cos(al(3)) -cos(th(3))*sin(al(3)) r(3)*sin(th(3));0 sin(al(3)) cos(al(3)) d(3);0 0 0 1];
A_34 = [cos(th(4)) -sin(th(4))*cos(al(4)) sin(th(4))*sin(al(4)) r(4)*cos(th(4));sin(th(4)) cos(th(4))*cos(al(4)) -cos(th(4))*sin(al(4)) r(4)*sin(th(4));0 sin(al(4)) cos(al(4)) d(4);0 0 0 1];
A_45 = [cos(th(5)) -sin(th(5))*cos(al(5)) sin(th(5))*sin(al(5)) r(5)*cos(th(5));sin(th(5)) cos(th(5))*cos(al(5)) -cos(th(5))*sin(al(5)) r(5)*sin(th(5));0 sin(al(5)) cos(al(5)) d(5);0 0 0 1];
A_56 = [cos(th(6)) -sin(th(6))*cos(al(6)) sin(th(6))*sin(al(6)) r(6)*cos(th(6));sin(th(6)) cos(th(6))*cos(al(6)) -cos(th(6))*sin(al(6)) r(6)*sin(th(6));0 sin(al(6)) cos(al(6)) d(6);0 0 0 1];

T_06 = A_01*A_12*A_23*A_34*A_45*A_56

T11 = T_06(1, 1);
T12 = T_06(1, 2);
T13 = T_06(1, 3);
T14 = T_06(1, 4);
T21 = T_06(2, 1);
T22 = T_06(2, 2);
T23 = T_06(2, 3);
T24 = T_06(2, 4);
T31 = T_06(3, 1);
T32 = T_06(3, 2);
T33 = T_06(3, 3);
T34 = T_06(3, 4);
T41 = T_06(4, 1);
T42 = T_06(4, 2);
T43 = T_06(4, 3);
T44 = T_06(4, 4);


for(i = 1:4)
    for(j = 1:4)
        disp(T_06(i,j));
    end
end