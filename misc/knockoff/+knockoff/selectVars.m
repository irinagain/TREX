function S = selectVars(W, q, method)
% SELECTVARS  Select variables based on the knockoff statistics
%   S = SELECTVARS(W, q) select using 'knockoff' method
%   S = SELECTVARS(W, q, method) select with given method
%
%   Inputs:
%       W - statistics W_j for testing null hypothesis beta_j = 0.
%       q - target FDR
%       method - either 'knockoff' or 'knockoff+'
%
%   Outputs:
%       S - array of selected variable indices
%
%   See also THRESHOLD.

if ~exist('method', 'var')
    method = [];
end

W = reshape(W, 1, []);
T = knockoff.threshold(W, q, method);
S = find(W >= T);

end