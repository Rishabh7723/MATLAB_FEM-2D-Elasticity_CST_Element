function uq = interpolation_FEM_2D(dom, u, pq)
%INTERPOLATION_FEM_2D Interpolate displacement at query points in a 2D triangle mesh.
%   uq = interpolation_FEM_2D(dom, u, pq)
%   dom.nodes: nNodes-by-2, dom.conn: nElems-by-3
%   u: 2*nNodes-by-1 (ux,uy interleaved)
%   pq: nQ-by-2 query points [x,y]
%   uq: nQ-by-2 interpolated [ux, uy]

TR = triangulation(dom.conn, dom.nodes);

ti = pointLocation(TR, pq);
if any(isnan(ti))
    error('Some query points are outside the mesh.');
end

bc = cartesianToBarycentric(TR, ti, pq);  % nQ-by-3

ux = u(1:2:end);
uy = u(2:2:end);

uq = zeros(size(pq,1), 2);

for q = 1:size(pq,1)
    nodes_e = dom.conn(ti(q), :);
    N = bc(q, :);

    uq(q, 1) = N * ux(nodes_e);
    uq(q, 2) = N * uy(nodes_e);
end
end
