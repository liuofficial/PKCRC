function [Up D Vp] = myPCA(X, k)
N = size(X,2);
mX = mean(X,2);
X = X - repmat(mX,1,N);
[Up, D, Vp] = svds(X*X'/N,k);
end