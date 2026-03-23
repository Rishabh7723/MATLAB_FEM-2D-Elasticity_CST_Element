function [u, R] = solveLinearSystem(K, F, fixedDofs, fixedVals)
%SOLVELINEARSYSTEM Solve Ku=F with Dirichlet conditions.

ndof = size(K, 1);
u = zeros(ndof, 1);
fixedDofs = fixedDofs(:);
fixedVals = fixedVals(:);
u(fixedDofs) = fixedVals;
freeDofs = setdiff((1:ndof).', fixedDofs);

Fmod = F - K(:, fixedDofs) * fixedVals;
u(freeDofs) = K(freeDofs, freeDofs) \ Fmod(freeDofs);
R = K * u - F;
end
