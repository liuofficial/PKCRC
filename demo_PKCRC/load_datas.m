function [img img_gt nClass rows cols bands] = load_datas(n)
% 2014-06-14
switch n
    case 2,
        load paviaU_info.mat;
        img = paviaU_im; img_gt = paviaU_gt;
        nClass = 9;
end

[rows, cols] = size(img_gt); bands = size(img,1);
img_gt = img_gt(:);
rdown = 0.001; rup = 0.999;
img = DPTailor(img, rdown, rup);
end
