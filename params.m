function p = params()
%PARAMS Parameters for 2D uniform bar (plane stress/strain) using triangles.
%
% Geometry: rectangle [0,L] x [-W/2, W/2]
% Thickness t is out-of-plane (used for forces and stiffness scaling).

% Geometry
p.L = 1.0;          % length [m]
p.W = 0.2;          % width  [m]
p.t = 0.01;         % thickness [m]

% Material
p.E  = 210e9;       % Young's modulus [Pa]
p.nu = 0.30;        % Poisson ratio [-]

% Kinematics: 'stress' or 'strain'
p.plane = 'stress';

% Mesh control
p.h0 = 0.05/5;        % target edge size
p.useDistmesh = true;

% Loading
p.P  = 1e7;       % total axial force on x=L [N]
p.bx= 0.0;         % body force x [N/m^3]
p.by= 0.0;         % body force y [N/m^3]

% Plot control
p.plotDeformed = true;
p.deformScale  = 10.0;   % scale for plotting

end
