function im = normalization(im, imin, imax, all)
% scale rows to [imin imax]
if nargin == 4,
    im_top = im - min(im(:));
    im = im_top * (imax - imin) / (max(im(:)) - min(im(:))+eps);
    im = im + imin;
else
    im_top = bsxfun(@minus, im, min(im,[],2));
    im = bsxfun(@times, im_top, (imax - imin) ./ (max(im,[],2) - min(im,[],2) + eps));
    im = im + imin;
end
end