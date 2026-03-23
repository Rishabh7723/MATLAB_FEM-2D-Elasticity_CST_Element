function [xi, w] = gaussQuadrature(n)
%GAUSSLEGENDRE n-point Gauss–Legendre nodes and weights on [-1, 1].
%   [xi, w] = gaussQuadrature(n)
%   xi, w are column vectors of length n.

    if ~(isscalar(n) && n == round(n) && n >= 1)
        error('gaussLegendre:InvalidN', 'n must be a positive integer.');
    end

    % Golub–Welsch Jacobi matrix for Legendre polynomials (weight = 1 on [-1,1])
    k = (1:n-1).';
    beta = k ./ sqrt(4*k.^2 - 1);

    J = diag(beta, 1) + diag(beta, -1);   % symmetric tridiagonal

    [V, D] = eig(J);
    xi = diag(D);

    [xi, idx] = sort(xi);
    V = V(:, idx);

    w = 2 * (V(1,:).').^2;
end
