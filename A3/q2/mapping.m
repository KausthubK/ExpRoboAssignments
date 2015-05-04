close all
clear
clc

positions=load('q2Output1.txt');

X=positions(:,1);
Y=positions(:,2);

X=X-min(X)+1;
Y=Y-min(Y)+1;

Dim=300;
workspace=zeros(Dim);

for i=1:length(X)
  
    workspace(round(X(i)*10),round(Y(i)*10))= workspace(round(X(i)*10),round(Y(i)*10)) + 1;
    
end