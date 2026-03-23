function plotDeformedMesh(dom, u, scale, titleStr)
%PLOTDEFORMEDMESH Plot undeformed and deformed 2D triangle mesh.

if nargin < 3 || isempty(scale)
    scale = 1.0;
end
if nargin < 4
    titleStr = 'Deformed mesh';
end

ux = u(1:2:end);
uy = u(2:2:end);

V0 = dom.nodes;
Vd = V0 + scale * [ux, uy];

figure;
subplot(1,2,1);
trimesh(dom.conn, V0(:,1), V0(:,2), 0*V0(:,1));
view(2); axis equal; grid on;
title('Undeformed mesh');
xlabel('x'); ylabel('y');

subplot(1,2,2);
trimesh(dom.conn, Vd(:,1), Vd(:,2), 0*Vd(:,1));
view(2); axis equal; grid on;
title(titleStr);
xlabel('x'); ylabel('y');
end
