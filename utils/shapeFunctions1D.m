function [N, dN_dxi] = shapeFunctions1D(xi)
%SHAPEFUNCTIONS1D Linear 1D shape functions on parent domain [-1, 1].
%   [N, dN_dxi] = shapeFunctions1D(xi)
%   xi can be scalar or vector.
%
%   N is 2-by-n, dN_dxi is 2-by-n, where n = numel(xi).

xi = xi(:).';  % row vector for consistent sizing

N      = [0.5*(1 - xi); 0.5*(1 + xi)];
dN_dxi = [-0.5*ones(size(xi)); 0.5*ones(size(xi))];
end
