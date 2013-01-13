function [cost,grad] = softmaxCost(theta, data, params)

W = stack2param(theta, decodeInfo);

pred = exp(W*data.imgs); % k by n matrix with all calcs needed
pred = bsxfun(@rdivide,pred,sum(pred));
m = length(data.categories);
truth_inds = sub2ind(size(pred),data.categories,1:m);
cost = -sum(log(pred(truth_inds)))/m + (params.lambda/2)*sum(sum(W.^2));

truth = zeros(size(pred));
truth(truth_inds) = 1;
error = pred - truth;
Wgrad = (error*data.imgs')/m + params.lambda*W;

grad = [ Wgrad(:) ];

end