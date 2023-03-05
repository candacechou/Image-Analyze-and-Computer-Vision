scale_factor = 0.5;          % image downscale factor
area = [ 80, 110, 570, 300 ];% image region to train foreground with
K = 16;                      % number of mixture components
alpha = 15;                 % maximum edge cost %%8
sigma = 18;                % edge cost decay factor %% 10

I = imread('tiger3.jpg');
I = imresize(I, scale_factor);
Iback = I;
area = int16(area*scale_factor);
[ segm, prior ] = graphcut_segm(I, area, K, alpha, sigma);

Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
imwrite(Inew,'result/graphcut1k2tig3.png')
imwrite(I,'result/graphcut2k2tig3.png')
imwrite(prior,'result/graphcut3k2tig3.png')
subplot(1,3,1); imshow(Inew);
subplot(1,3,2); imshow(I);
subplot(1,3,3); imshow(prior);
