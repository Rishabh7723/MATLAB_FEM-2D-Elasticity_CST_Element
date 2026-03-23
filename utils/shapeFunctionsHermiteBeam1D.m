function [N, dN_dx, d2N_dx2] = shapeFunctionsHermiteBeam1D(xi, Le)
%SHAPEFUNCTIONSHERMITEBEAM1D Cubic Hermite beam shape functions for Euler--Bernoulli.
%   DOFs per node: [w; theta] (transverse deflection and slope).
%   Element DOF vector: [w1; theta1; w2; theta2].
%
%   xi: parent coordinate(s) in [-1, 1] (scalar or vector)
%   Le: element length
%
%   Outputs (4-by-n):
%     N       : shape functions
%     dN_dx   : first derivative wrt x
%     d2N_dx2 : second derivative wrt x

xi = xi(:).';              % row vector
s  = 0.5*(xi + 1.0);       % map to [0, 1]

% Hermite polynomials in s
H1 = 1 - 3*s.^2 + 2*s.^3;
H2 = Le*(s - 2*s.^2 + s.^3);
H3 = 3*s.^2 - 2*s.^3;
H4 = Le*(-s.^2 + s.^3);

N = [H1; H2; H3; H4];

% d/ds
dH1_ds = 0 - 6*s + 6*s^2;
dH2_ds = Le*(1 - 4*s + 3*s^2);
dH3_ds = 6*s - 6*s^2; 
dH4_ds = Le*(-2*s + 3*s.^2);

% d/dx = (1/Le) d/ds
dN_dx = (1/Le) * [dH1_ds; dH2_ds; dH3_ds; dH4_ds];

% d2/ds2
d2H1_ds2 = -6 + 12*s;
d2H2_ds2 = Le*(-4 + 6*s);
d2H3_ds2 =  6 - 12*s;
d2H4_ds2 = Le*(-2 + 6*s);

% d2/dx2 = (1/Le^2) d2/ds2
d2N_dx2 = (1/(Le^2)) * [d2H1_ds2; d2H2_ds2; d2H3_ds2; d2H4_ds2];
end
