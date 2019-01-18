function [segmentation,centers] = kmeans_segm(image,k,L,seed)
  

sprev = rng(seed)
Ivec = image;
[w , h ,rgb] = size(Ivec);
pixnum = w * h;
Ivec = double(reshape(Ivec,pixnum,3));
segmentation = zeros(pixnum,1);
test = 1;
threshold = 0.01;
Compare_center = zeros(pixnum,1);
%rng(sprev);
%%%% initialize the clustering process
centers = abs(rand(k,3))*225;
if k > 1 
        centers(1,:)= [255,225,255];
        centers(2,:) = [0,0,0];
       
end
centerssum = zeros(k,4);
old_center = zeros(size(centers));

%%% 1: the number of pixels 2: the sum of R 3: the sum of G 4: the sum of B 
i = 0;
while (i < L) & test
    Dist = pdist2(centers,Ivec,'euclidean');
    [~,Compare_center] = min(Dist);
    
    for j = 1:k
            centerssum(j,1) = sum(Compare_center(:)==j);
            
            idx = find(Compare_center == j);
            if isempty(idx)
                centers(j,:)=rand(1,3)*255;
            else
            centerssum(j,2) = sum(Ivec(idx,1))/centerssum(j,1);
            centerssum(j,3) = sum(Ivec(idx,2))/centerssum(j,1);
            centerssum(j,4) = sum(Ivec(idx,3))/centerssum(j,1);
            centers(j,:) = centerssum(j,2:4);
            end
             
            
                
    end
        i = i+1;
           %% for question 1
            test1 = (abs(centers - old_center)> threshold);
            test = any(test1);
            old_center = centers;
        
end
i
for j = 1:k
     idx = find(Compare_center==j);
     segmentation(idx,1) = j;
end
segmentation = reshape(segmentation,w,h);



%     for j=1:k
%         D = [centers(j,:);image];
%         Dist = pdist(D,'euclidean');
%         idx = Compare_distance > Dist;
%         Compare_distance(idx) = Dist(idx);
%         Compare_center(idx) = j;
%     end
%     %%% calculate sum and move the center 
%         
%        for j = 1:k
%            centerssum(j,1) = sum(Compare_center(:)==j);
%            idx = (Compare_center == j);
%            centerssum(j,2) = sum(image(idx,1))/centerssum(j,1);
%            centerssum(j,3) = sum(image(idx,2))/centerssum(j,1);
%            centerssum(j,4) = sum(image(idx,3))/centerssum(j,1);
%            centers(j,:) = centerssum(j,2:4);
%        end
%       Compare_distance(:,:) = 256;
%       
%       
% end
% 
% 
end
        
        
        
        