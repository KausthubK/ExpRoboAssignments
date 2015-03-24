close all
clear
clc

syms t1 t2 t3
mat = jacobian([.25*cos(t1)+.25*cos(t1+t2)+.315*cos(t1+t2+t3),.25*sin(t1)+.25*sin(t1+t2)+.315*sin(t1+t2+t3),0],[t1,t2,t3]);
mat(3,3)=1;
display(det(mat))


