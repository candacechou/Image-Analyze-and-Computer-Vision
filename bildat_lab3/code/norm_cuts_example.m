colour_bandwidth = 60.0; % color bandwidth 30.0
radius = 6;             % maximum neighbourhood distance 3
ncuts_thresh = 0.4;      % cutting threshold 0.2
min_area = 20;          % minimum area of segment 200
max_depth = 10;           % maximum splitting depth 8
scale_factor = 0.6;      % image downscale factor 0.4
image_sigma = 1.0;       % image preblurring scale 2.0

I = imread('tiger3.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

segm = norm_cuts_segm(I, colour_bandwidth, radius, ncuts_thresh, min_area, max_depth);
Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
imwrite(Inew,'result/nc1tiger3.png')
imwrite(I,'result/nc2tiger3.png')

figure
subplot(1,2,1); 
imshow(Inew);
subplot(1,2,2);
imshow(I);



