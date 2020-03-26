function K = RBF(X, X2, sigma, block)
% RBF kernel
% 2013-12-24
% func:0; data: 0

if nargin < 3,
    dist = rbf(X, X2);
    sig = mean(dist(:).^0.5);
    K = exp(-dist/2/sig^2);
    return;
end

n1 = size(X,2);  n2 = size(X2,2);
if (n1 < block) && (n2 < block),
    K = ker_rbf(X, X2, sigma);
else
    K = zeros(n1, n2);
    n1_block = ceil(n1/block); n2_block = ceil(n2/block);
    for i = 1 : n1_block
        n1_idx = (i-1)*block+1 : min(i*block, n1);
        for j = 1 : n2_block
            n2_idx = (j-1)*block+1 : min(j*block, n2);
            K(n1_idx, n2_idx) = ker_rbf(X(:,n1_idx), X2(:,n2_idx), sigma);
        end
    end
end
end

function K = ker_rbf(A, X, sig)
nA = sum(A.^2); nX = sum(X.^2);
[mX,mA] = meshgrid(nX,nA);
dist = mA-2*A'*X+mX;
K = exp(-dist/2/sig^2);
end

function dist = rbf(A, X)
nA = sum(A.^2); nX = sum(X.^2);
[mX,mA] = meshgrid(nX,nA);
dist = mA-2*A'*X+mX;
end
