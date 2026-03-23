function [u, R] = solveLinearSystem(K, F, fixedDofs, fixedVals)
%SOLVELINEARSYSTEM Solve Ku = F with Dirichlet BCs by direct elimination.
%   [u, R] = solveLinearSystem(K, F, fixedDofs, fixedVals)
%   fixedDofs: vector of constrained DOF indices
%   fixedVals: vector of prescribed values (same size as fixedDofs)

n = length(F);

fixedDofs = fixedDofs(:);
fixedVals = fixedVals(:);

allDofs  = (1:n).';
freeDofs = setdiff(allDofs, fixedDofs);

u = zeros(n,1);
u(fixedDofs) = fixedVals;

% Modify RHS for known displacements
F_mod = F - K(:, fixedDofs) * fixedVals;

% Solve reduced system
u(freeDofs) = K(freeDofs, freeDofs) \ F_mod(freeDofs);

% Reaction vector
R = K*u - F;
end
