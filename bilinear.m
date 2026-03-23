function Ke = bilinear(xe, p)
%BILINEAR Element stiffness for CST triangle (plane stress/strain).
%   xe: 3-by-2 coordinates of triangle nodes [x,y]

x1 = xe(1,1); y1 = xe(1,2);
x2 = xe(2,1); y2 = xe(2,2);
x3 = xe(3,1); y3 = xe(3,2);

A = 0.5 * det([1, x1, y1;
               1, x2, y2;
               1, x3, y3]);

% Ensure positive area (counter-clockwise)
if A < 0
    xe([2 3], :) = xe([3 2], :);
    x1 = xe(1,1); y1 = xe(1,2);
    x2 = xe(2,1); y2 = xe(2,2);
    x3 = xe(3,1); y3 = xe(3,2);

    A = -A;
end

b = [y2 - y3; y3 - y1; y1 - y2];
c = [x3 - x2; x1 - x3; x2 - x1];

dNdx = b / (2*A);
dNdy = c / (2*A);

B = [dNdx(1) 0        dNdx(2) 0        dNdx(3) 0;
     0       dNdy(1)  0       dNdy(2)  0       dNdy(3);
     dNdy(1) dNdx(1)  dNdy(2) dNdx(2)  dNdy(3) dNdx(3)];

% Constitutive matrix
E  = p.E;
nu = p.nu;

if strcmpi(p.plane, 'strain')
    D = E/((1+nu)*(1-2*nu)) * ...
        [1-nu, nu,   0;
         nu,   1-nu, 0;
         0,    0,   (1-2*nu)/2];
else
    % plane stress
    D = E/(1-nu^2) * ...
        [1,   nu,  0;
         nu,  1,   0;
         0,   0,  (1-nu)/2];
end

Ke = p.t * A * (B' * D * B);
end
