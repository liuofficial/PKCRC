function mydemo
n = 2;
[img, img_gt, nClass, rows, cols, bands] = load_datas(n);

switch n
    case 2, pkcr_sig = 1; pkcr_lam = 1e-3; beta = 430; gam = 1e-6;
end

nt = 3; it = 1;
location = 'paviaU_'; types = 'n';
load([location types num2str(nt) '_' num2str(it) '.mat']);
[Train, Test] = set_train_test(train_idx, test_idx, img, img_gt);

A = Train.dat; X = img;
opt = []; opt.lab = Train.lab; opt.sca = 0; opt.lam = pkcr_lam;
tic;
pkcr_pdf = SpRegPKCR(X, A, pkcr_sig, opt);
toc;
tic;
awg_pdf = Graph(img, pkcr_pdf, rows, cols, beta, gam);
toc;
[~,awg_pred] = max(awg_pdf);
awg_acc = class_eval(awg_pred(Test.idx), Test.lab);
OA = awg_acc.OA; AA = mean(awg_acc.ratio); KA = awg_acc.KA;
disp([OA AA KA]);
end

function pd = Graph(img, pdf, rows, cols, beta, gam)
pcs = 3; con = 1;
pdf = max(pdf,0);
pdf = bsxfun(@times, pdf, 1./max(sum(pdf),eps));
PCs = myPCA(img,pcs)'*img;
PCs = normalization(PCs, 0, 1);
[~, edges] = lattice(rows, cols, con);
imgVals = PCs';
weights = makeweights(edges, imgVals, beta);
L = laplacian(edges, weights);
pd = gam*pdf / (L + gam*speye(size(L)));
end
