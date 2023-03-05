%     function prob = mixture_prob(image, K, L, mask)
%     
%
%      Let I be a set of pixels and V be a set of K Gaussian components in 3D (R,G,B).
%     

%      Store all pixels for which mask=1 in a Nx3 matrix
%      Randomly initialize the K components using masked pixels
%
%      Iterate L times
%
%      Expectation: Compute probabilities P_ik using masked pixels
%      Maximization: Update weights, means and covariances using masked pixels
%      Compute probabilities p(c_i) in Eq.(3) for all pixels I.




function prob = mixture_prob(image, K, L, mask)
%%%% I is a image with 170x308x3 
%%%% mask is the same size as I
I = image;
[h,we,rgb] = size(I);
Ivoc = double(reshape(I,h*we,3));
Mvoc = reshape(mask,h*we,1);
idx = find(Mvoc==1);
Imask = Ivoc(idx,:);
L_kmean = 200;
seed=400;
%%% randomly initialize the k components using masked pixels
[segmentation,centers] = kmeans_segm(image,K,L_kmean,seed);

cov = cell(K, 1);
cov(:) = {diag([1,1,1])*255^2};
w = (zeros(1, K)+1) * (1/size(Imask,1)); %%% weight
g_mask = zeros(size(Imask, 1), K);
g_all = zeros(we*h, K);

%%Step 1: Expectation Given the current estimates of the 
%%parameters wk, £gk and ?k compute how much of pixel i comes from kth Gaussian component,
%%initialize the weight

for i=1:L
    
    %%%%% Expectation: Compute probabilities P_ik using masked pixels
    for k = 1:K
        c_mu = bsxfun(@minus, Imask, centers(k,:));
        down = 1/sqrt((2*pi)^3 * det(cov{k}));
        foo = bsxfun(@times,(c_mu * inv(cov{k})),c_mu);
        foo = sum(foo,2);
        %%% too slow
        %foo = c_mu * inv(cov{k}) * c_mu';
        %foo = diag(foo);
        
        g_mask(:,k) = down * exp(-0.5 * foo);
    end
    p = bsxfun(@times, g_mask, w);
    pdown = sum(p, 2);
    p = bsxfun(@rdivide, p, pdown);
        
    %%%%% Maximization: Update weights, means and covariances using masked pixels
    %%%% weight
    w = sum(p,1)/size(p,1);
    for k=1:K
        %%% AVERAGE
        centers(k,:) = p(:,k)'* Imask / nansum(p(:,k),1);
        %%%% covariance
        c_mu = bsxfun(@minus,Imask,centers(k,:));
        foo = bsxfun(@times, c_mu, p(:,k));
        cov{k} = (c_mu' * foo) / nansum(p(:, k), 1);
    end
end
%%%%% Compute probabilities p(c_i) in Eq.(3) for all pixels I.

for k = 1:K
    c_mu = bsxfun(@minus, Ivoc, centers(k, :));
    down = 1/sqrt((2*pi)^3 * det(cov{k}));
    foo = bsxfun(@times,(c_mu * inv(cov{k})),c_mu);
    foo = sum(foo,2);
    %%% too slow
    %foo = c_mu * inv(cov{k}) * c_mu';
    %foo = diag(foo);
    g_all(:, k) = down * exp(-0.5*foo);
end
prob = nansum(bsxfun(@times, g_all, w), 2);
prob = reshape(prob, h, we, 1);
end


        
        
        
