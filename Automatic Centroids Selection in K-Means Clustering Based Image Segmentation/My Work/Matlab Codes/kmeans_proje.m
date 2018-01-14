clear all; close all; clc;
tic

Im_org = double(rgb2gray(imread('badminton.jpg')));
%Im_org = medfilt2(Im_org);
[w1,h1] = size(Im_org);
figure; imshow(uint8(Im_org));      title('original image');

[pix_val,k] = auto_cluster(Im_org);                                                    
centers = pix_val(1, 2 : k+1);  
%  centers = round(rand(1,k) * 255);
% t= round(256/k);
% for i = 1 : k
%    centers(1,i) = t*(i-1);  
% end
[Im_out , PSNR , SSIM] = kmeans_func (k , centers , Im_org);

hist_array = histogram (Im_out);
figure; plot(hist_array);           title('histogram of segmented image');

T2 = round(otsuthresh(hist_array) * 255);
Im_morp = morphology(Im_org, Im_out, T2);

toc