function [p, t] = rectTriMesh(L, W, h0)
%RECTTRIMESH Structured triangular mesh for a rectangle.
%   [p, t] = rectTriMesh(L, W, h0)
%   Domain: [0,L] x [-W/2, W/2]
%
% This is used when DistMesh is not on the MATLAB path.

nx = max(2, ceil(L / h0) + 1);
ny = max(2, ceil(W / h0) + 1);

x = linspace(0, L, nx);
y = linspace(-W/2, W/2, ny);

[X, Y] = meshgrid(x, y);
p = [X(:), Y(:)];

t = zeros(2 * (nx-1) * (ny-1), 3);
k = 1;

for j = 1:(ny-1)
    for i = 1:(nx-1)
        n1 = (j-1) * nx + i;
        n2 = n1 + 1;
        n3 = j * nx + i;
        n4 = n3 + 1;

        % Two triangles per cell
        t(k, :)   = [n1, n2, n4]; k = k + 1;
        t(k, :)   = [n1, n4, n3]; k = k + 1;
    end
end
end
