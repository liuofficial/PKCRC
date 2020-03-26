function [trainidx testidx] = load_train_test(n, type, i, j)
% 2014-06-14
switch n,
    case 1, 
        location = 'priv_data\indian\indian_';
    case 2, 
        location = 'priv_data\paviaU\paviaU_';
    case 3, 
        location = 'priv_data\ksc\ksc_';
    case 4,
        location = 'priv_data\paviaC\Pavia_';
    case 5,
        location = 'priv_data\center\center_';
end

switch type,
    case 1,
        types = 'n';
    case 2,
        types = 'r';
    case 10,
        switch n,
            case 2, [trainidx, testidx] = load_pavia_train_test(0);
            case 4, [trainidx, testidx] = load_paviaC_train_test();
            case 5, [trainidx, testidx] = load_center_train_test();
        end
        return;
end

load([location types num2str(i) '_' num2str(j) '.mat']);
trainidx = train_idx; testidx = test_idx;
end

function [train_idx, test_idx] = load_pavia_train_test(sub)
imTrain = imread('priv_data\paviaU_Train.bmp');
imTest = imread('priv_data\paviaU_Test.bmp');
imTrain = double(imTrain(:,1:340)); imTrain = imTrain(:);
imTest = double(imTest(:,1:340)); imTest = imTest(:);
if sub == 1,
    imTest(imTrain>0) = 0;
end
tmp = 1 : 610*340;
train_idx = tmp(imTrain>0); test_idx = tmp(imTest>0);
end

function [train_idx, test_idx] = load_paviaC_train_test()
imTrain = imread('priv_data\paviaC_Train.bmp');
imTest = imread('priv_data\paviaC_Test.bmp');
imTrain = double(imTrain(:,end-491:end)); imTrain = imTrain(:);
imTest = double(imTest(:,end-491:end)); imTest = imTest(:);
tmp = 1 : 1096*492;
train_idx = tmp(imTrain>0); test_idx = tmp(imTest>0);
end

function [train_idx, test_idx] = load_center_train_test()
imTrain = imread('priv_data\paviaC_Train.bmp');
imTest = imread('priv_data\paviaC_Test.bmp');
imTrain = double(imTrain(:,[1:223 605:end])); imTrain = imTrain(:);
imTest = double(imTest(:,[1:223 605:end])); imTest = imTest(:);
tmp = 1 : 1096*715;
train_idx = tmp(imTrain>0); test_idx = tmp(imTest>0);
end