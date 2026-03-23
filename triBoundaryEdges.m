function E = triBoundaryEdges(t)
%TRIBOUNDARYEDGES Boundary edges of a triangular mesh.
%   E = triBoundaryEdges(t)
%   t: nElems-by-3 connectivity
%   E: nBdryEdges-by-2 node ids (unique, unordered)

% All edges (unordered)
e12 = t(:, [1 2]);
e23 = t(:, [2 3]);
e31 = t(:, [3 1]);
Eall = [e12; e23; e31];

Eall = sort(Eall, 2);

% Count occurrences
[Eu, ~, ic] = unique(Eall, 'rows');
counts = accumarray(ic, 1);

E = Eu(counts == 1, :);
end
