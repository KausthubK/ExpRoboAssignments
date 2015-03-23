function config_space_3dof(X,Y,Z)
    
    hold on
    grid
    axis equal

    cornersX = [X(2), X(2), X(1), X(1)];
    cornersY = [Y(2), Y(1), Y(1), Y(2)];
    cornersZ = [Z(1), Z(1), Z(1), Z(1)];
    fill3(cornersX, cornersY, cornersZ,1);

    cornersX = [X(2), X(2), X(1), X(1)];
    cornersY = [Y(2), Y(1), Y(1), Y(2)];
    cornersZ = [Z(2), Z(2), Z(2), Z(2)];
    fill3(cornersX, cornersY, cornersZ,1);

    cornersX = [X(2), X(2), X(2), X(2)];
    cornersY = [Y(2), Y(1), Y(1), Y(2)];
    cornersZ = [Z(1), Z(1), Z(2), Z(2)];
    fill3(cornersX, cornersY, cornersZ,1);

    cornersX = [X(1), X(1), X(1), X(1)];
    cornersY = [Y(2), Y(1), Y(1), Y(2)];
    cornersZ = [Z(1), Z(1), Z(2), Z(2)];
    fill3(cornersX, cornersY, cornersZ,1);

    cornersX = [X(1), X(2), X(2), X(1)];
    cornersY = [Y(2), Y(2), Y(2), Y(2)];
    cornersZ = [Z(1), Z(1), Z(2), Z(2)];
    fill3(cornersX, cornersY, cornersZ,1);

    cornersX = [X(1), X(2), X(2), X(1)];
    cornersY = [Y(1), Y(1), Y(1), Y(1)];
    cornersZ = [Z(1), Z(1), Z(2), Z(2)];
    fill3(cornersX, cornersY, cornersZ,1);
    
    hold off
end