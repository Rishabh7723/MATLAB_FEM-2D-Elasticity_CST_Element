function F = linear_point(dom, p)
%LINEAR_POINT Boundary traction on x = L side.
%   For this lab, "point" means an external load term on a boundary.
%
% Traction: t = [T; 0] on x=L
% with T = P / (t*W) so that total force is P.

ndof = 2 * dom.nNodes;
F = zeros(ndof, 1);

if ~isfield(dom.edges, 'right') || isempty(dom.edges.right)
    return;
end

Tx = p.P / (p.t * p.W);
Ty = 0.0;

edges = dom.edges.right;

for k = 1:size(edges, 1)
    n1 = edges(k, 1);
    n2 = edges(k, 2);

    x1 = dom.nodes(n1, 1); y1 = dom.nodes(n1, 2);
    x2 = dom.nodes(n2, 1); y2 = dom.nodes(n2, 2);

    Le = sqrt((x2 - x1)^2 + (y2 - y1)^2);

    % Linear edge: integral N1 dGamma = Le/2, integral N2 dGamma = Le/2
    f1 = p.t * Le/2 * [Tx; Ty];
    f2 = p.t * Le/2 * [Tx; Ty];

    dof1 = [2*n1-1; 2*n1];
    dof2 = [2*n2-1; 2*n2];

    F(dof1) = F(dof1) + f1;
    F(dof2) = F(dof2) + f2;
end
end
