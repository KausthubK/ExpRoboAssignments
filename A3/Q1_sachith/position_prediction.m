function [X,Y,angle]=position_prediction(X0,Y0,angle0,current_vel,dt,TR)

X=X0+(dt*current_vel*cos(angle0));
Y=Y0+(dt*current_vel*sin(angle0));
angle=angle0+(dt*TR);









end