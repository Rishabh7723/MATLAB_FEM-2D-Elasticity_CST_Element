% examples/Lab4_UniformBar2D_Distmesh/main.m
clear; clc; close all;

addpath("........./PostProcessing");
addpath('........./utils)
addpath(pwd);

% 1) Problem setup
p   = params();
dom = domain(p);

fprintf('Mesh: %d nodes, %d triangles\n', dom.nNodes, dom.nElems);
if dom.usedDistmesh
    fprintf('Mesher: DistMesh\n');
    fprintf('distmesh2d path: %s\n', which('distmesh2d'));
else
    fprintf('Mesher: structured fallback (rectTriMesh)\n');
end

% 2) Assemble global K and F (2 dofs per node)
ndof = 2 * dom.nNodes;
K = sparse(ndof, ndof);
F = zeros(ndof, 1);

for e = 1:dom.nElems
    nodes_e = dom.conn(e, :);
    xe      = dom.nodes(nodes_e, :);
    Ke = bilinear(xe, p);
    Fe = linear_body(xe, p);
    dofs = reshape([2*nodes_e-1; 2*nodes_e], [], 1);

    K(dofs, dofs) = K(dofs, dofs) + Ke;
    F(dofs)       = F(dofs) + Fe;
end

% Add traction contribution on x = L
F = F + linear_point(dom, p);

% 3) Dirichlet boundary conditions
leftNodes = dom.leftNodes(:);
fixedDofs = 2*leftNodes-1;
fixedVals = zeros(size(fixedDofs));

[~, iPin] = min(dom.nodes(leftNodes, 2));
pinNode = leftNodes(iPin);
fixedDofs = [fixedDofs; 2*pinNode];
fixedVals = [fixedVals; 0.0];

% 4) Solve
[u, R] = solveLinearSystem(K, F, fixedDofs, fixedVals);

%Rx = sum(R(2*dom.leftNodes-1));
Rx = sum(R(1:2:end));
fprintf('Applied force P = %.6e N\n', p.P);
fprintf('Reaction (x) at x=0: %.6e N\n', Rx);

% 5) Post-process
props = properties(dom, u, p);

xq = [0.25; 0.50; 0.75];
yq = [0.00; 0.03; -0.04];
uq = interpolation_FEM_2D(dom, u, [xq, yq]);
disp('Interpolated displacements [ux uy] at query points:');
disp(uq);

% 6) Plots
if p.plotDeformed
    plotDeformedMesh(dom, u, p.deformScale, 'Deformed mesh (scaled)');
end

plotTriField(dom, props.sxx, '\sigma_{xx} on triangles', '\sigma_{xx} [Pa]');
