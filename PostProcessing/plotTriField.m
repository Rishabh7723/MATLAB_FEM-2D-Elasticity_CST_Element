function plotTriField(dom, f, titleStr, cLabel)
%PLOTTRIFIELD Plot element-wise scalar field on a triangular mesh.
%   f: nElems-by-1 values (constant per triangle)

if nargin < 3
    titleStr = 'Triangle field';
end
if nargin < 4
    cLabel = 'value';
end

figure;
patch('Faces', dom.conn, ...
      'Vertices', dom.nodes, ...
      'FaceVertexCData', f, ...
      'FaceColor', 'flat', ...
      'EdgeColor', [0.2 0.2 0.2]);

axis equal; grid on;
xlabel('x'); ylabel('y');
title(titleStr);
cb = colorbar;
ylabel(cb, cLabel);
end
