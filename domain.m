function dom = domain(p)
%DOMAIN Mesh for 2D uniform bar using the original DistMesh repository.
%   Rectangle: [0,L] x [-W/2, W/2]
%   dom.nodes : nNodes-by-2 coordinates [x,y]
%   dom.conn  : nElems-by-3 connectivity (triangles)

useDM = isfield(p, 'useDistmesh') && p.useDistmesh;
hasDM = exist('distmesh2d', 'file') == 2 && ...
        exist('drectangle', 'file') == 2 && ...
        exist('huniform', 'file') == 2;

if useDM && hasDM
    fd   = @(pp) drectangle(pp, 0, p.L, -p.W/2, p.W/2);
    fh   = @huniform;
    bbox = [0, -p.W/2; p.L, p.W/2];
    pfix = [0, -p.W/2; 0, p.W/2; p.L, -p.W/2; p.L, p.W/2];
    [nodes, conn] = distmesh2d(fd, fh, p.h0, bbox, pfix);
    usedDistmesh = true;
elseif useDM
    error(['DistMesh repo not found on MATLAB path. ', ...
           'Make sure distmesh2d.m, drectangle.m, and huniform.m are accessible.']);
else
    [nodes, conn] = rectTriMesh(p.L, p.W, p.h0);
    usedDistmesh = false;
end

conn = orientTrianglesCCW(nodes, conn);
E = triBoundaryEdges(conn);

xmid = 0.5 * (nodes(E(:,1),1) + nodes(E(:,2),1));
ymid = 0.5 * (nodes(E(:,1),2) + nodes(E(:,2),2));

tol = max(1e-8, 1e-6 * max(p.L, p.W));
leftEdges   = E(abs(xmid - 0.0)   < tol, :);
rightEdges  = E(abs(xmid - p.L)   < tol, :);
topEdges    = E(abs(ymid - p.W/2) < tol, :);
bottomEdges = E(abs(ymid + p.W/2) < tol, :);

dom.nodes  = nodes;
dom.conn   = conn;
dom.nNodes = size(nodes, 1);
dom.nElems = size(conn, 1);
dom.edges.left   = leftEdges;
dom.edges.right  = rightEdges;
dom.edges.top    = topEdges;
dom.edges.bottom = bottomEdges;
dom.leftNodes  = unique(leftEdges(:));
dom.rightNodes = unique(rightEdges(:));
dom.tol = tol;
dom.usedDistmesh = usedDistmesh;
end

function conn = orientTrianglesCCW(nodes, conn)
for e = 1:size(conn,1)
    tri = conn(e,:);
    xe = nodes(tri,:);
    A2 = det([1, xe(1,1), xe(1,2); 1, xe(2,1), xe(2,2); 1, xe(3,1), xe(3,2)]);
    if A2 < 0
        conn(e,[2 3]) = conn(e,[3 2]);
    end
end
end
