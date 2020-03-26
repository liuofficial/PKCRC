function P = SpRegPKCR(X, A, sig, opt)
% 2015-12-19

% setting
J = size(A,2);
% param set
if ~isfield(opt, 'lam'),      lam   =  1e-3;          else     lam    =  opt.lam;   end
if ~isfield(opt, 'sca'),      sca   =  0;          else     sca    =  opt.sca;   end
dict_lab = opt.lab;

if isempty(sig),
    T = get_coef_lab(dict_lab);
    IF = (A + lam*eye(J)) \ eye(J);
    P = T * IF * X;
    P = max(P,0);
    P = bsxfun(@times, P, 1./max(sum(P),eps));
    return;
end

nBlock = 1000;

if sca == 0,
    AtA = RBF(A, A, sig, nBlock);
    T = get_coef_lab(dict_lab);
    IF = (AtA + lam*eye(J)) \ eye(J);
    P = MRBF(T*IF, A, X, sig, nBlock);
else
    [AtA, scale] = RBFS(A, A, sig, 0, nBlock);
    T = get_coef_lab(dict_lab);
    IF = (AtA + lam*eye(J)) \ eye(J);
    P = MRBF(T*IF, A, X, sig*sqrt(scale), nBlock);
end
P = max(P,0);
P = bsxfun(@times, P, 1./max(sum(P),eps));
end

function T = get_coef_lab(train_lab)
nClass = length(unique(train_lab));
train_size = length(train_lab);
T = zeros(nClass, train_size);
cls = unique(train_lab);
for k = 1 : nClass,
    c = cls(k);
    T(k, train_lab==c) = 1;
end
%T = sqrt(T*T') \ T;
end
