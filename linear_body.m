function Fe = linear_body(xe, p)
%LINEAR_BODY Element load vector from constant body force [bx,by].
%   xe: 3-by-2 coordinates of triangle nodes [x,y]
%   Fe: 6-by-1 load vector (2 dofs per node)

x1 = xe(1,1); y1 = xe(1,2);
x2 = xe(2,1); y2 = xe(2,2);
x3 = xe(3,1); y3 = xe(3,2);

A = 0.5 * det([1, x1, y1;
               1, x2, y2;
               1, x3, y3]);
A = abs(A);

bx = p.bx;
by = p.by;

% For linear triangle: integral N_i dA = A/3

Fe_node = p.t * A / 3 * [bx; by];
Fe = [Fe_node;
      Fe_node;
      Fe_node];
end
