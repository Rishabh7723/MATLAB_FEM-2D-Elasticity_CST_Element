function props = properties(dom, u, p)
%PROPERTIES Post-processing for 2D uniform bar.
%   Computes nodal displacement fields and element stresses.

props = struct();

% Nodal displacements
ux = u(1:2:end);
uy = u(2:2:end);

props.ux = ux;
props.uy = uy;
props.umag = sqrt(ux.^2 + uy.^2);

props.x = dom.nodes(:,1);
props.y = dom.nodes(:,2);

% Constitutive matrix (same as in bilinear)
E  = p.E;
nu = p.nu;

if strcmpi(p.plane, 'strain')
    D = E/((1+nu)*(1-2*nu)) * ...
        [1-nu, nu,   0;
         nu,   1-nu, 0;
         0,    0,   (1-2*nu)/2];
else
    D = E/(1-nu^2) * ...
        [1,   nu,  0;
         nu,  1,   0;
         0,   0,  (1-nu)/2];
end

% Element stresses
nE = dom.nElems;
sigma = zeros(nE, 3);    % [sxx, syy, txy]
cent  = zeros(nE, 2);

for e = 1:nE
    nodes_e = dom.conn(e, :);
    xe = dom.nodes(nodes_e, :);

    % centroid
    cent(e,:) = mean(xe, 1);

    % Build B for CST
    x1 = xe(1,1); y1 = xe(1,2);
    x2 = xe(2,1); y2 = xe(2,2);
    x3 = xe(3,1); y3 = xe(3,2);

    A = 0.5 * det([1, x1, y1;
                   1, x2, y2;
                   1, x3, y3]);

    if A < 0
        xe([2 3], :) = xe([3 2], :);
        x1 = xe(1,1); y1 = xe(1,2);
        x2 = xe(2,1); y2 = xe(2,2);
        x3 = xe(3,1); y3 = xe(3,2);
        A = -A;
        nodes_e = nodes_e([1 3 2]);
    end

    b = [y2 - y3; y3 - y1; y1 - y2];
    c = [x3 - x2; x1 - x3; x2 - x1];

    dNdx = b / (2*A);
    dNdy = c / (2*A);

    B = [dNdx(1) 0        dNdx(2) 0        dNdx(3) 0;
         0       dNdy(1)  0       dNdy(2)  0       dNdy(3);
         dNdy(1) dNdx(1)  dNdy(2) dNdx(2)  dNdy(3) dNdx(3)];

    ue = zeros(6,1);
    ue(1:2:end) = ux(nodes_e);
    ue(2:2:end) = uy(nodes_e);

    eps = B * ue;      % [exx; eyy; gxy]
    sig = D * eps;     % [sxx; syy; txy]

    sigma(e, :) = sig(:).';
end

props.centroids = cent;
props.sxx = sigma(:,1);
props.syy = sigma(:,2);
props.txy = sigma(:,3);

% "Exact" uniaxial state for plane stress
Tx = p.P / (p.t * p.W);    % traction = stress in x for uniaxial state

if strcmpi(p.plane, 'stress')
    exx = Tx / E;
    eyy = -nu * Tx / E;
else
    % Plane strain approximation with sigma_y = 0 and epsilon_z = 0
    exx = (1 - nu^2) * Tx / E;
    eyy = -(nu + nu^2) * Tx / E;
end

props.ux_exact = exx * props.x;
props.uy_exact = eyy * props.y;

props.sxx_exact = Tx * ones(nE,1);

% Errors
props.err_ux = props.ux - props.ux_exact;
props.err_uy = props.uy - props.uy_exact;

end
