function [U,S,V,U_perp] = decompose(X, randomize)
% DECOMPOSE  Decompose design matrix X for knockoff creation
%   [U,S,V,U_perp] = DECOMPOSE(X)
%   [U,S,V,U_perp] = DECOMPOSE(X, randomize)

if ~exist('randomize', 'var') || isempty(randomize)
    randomize = false;
end

% Check dimensions.
[n, p] = size(X);
if (n < 2*p)
   error('knockoff:DimensionError', 'Data matrix must have n >= 2p')
end

% Factorize X as X = USV' (reduced SVD).
[U,S,V] = knockoff.private.canonicalSVD(X);

% Construct an orthogonal matrix U_perp such that U_perp'*X = 0.
[Q,~] = qr([U zeros(n,p)], 0); % Skinny QR.
U_perp = Q(:,p+1:2*p);
if randomize
    [Q,~] = qr(randn(p),0); 
    U_perp = U_perp * Q;
end

end