%%Function to plot the configuration space of a 3DOF system
%Creates a rectangular polygon with corners defined by the boundary values
%of the system

%Takes as input 3 arrays with 2 elements in each - these
%are the boundaries of the x, y, and z values respectively
function config_space_3dof(X,Y,Z)
    
    hold on
    grid
    axis equal

    %Generate one face of the rectangular polygon, with corners described
    %by the system boundaries.
    cornersX = [X(2), X(2), X(1), X(1)];
    cornersY = [Y(2), Y(1), Y(1), Y(2)];
    cornersZ = [Z(1), Z(1), Z(1), Z(1)];
    fill3(cornersX, cornersY, cornersZ,1);
    
    %Generate the rest of the faces, building the polygon
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
