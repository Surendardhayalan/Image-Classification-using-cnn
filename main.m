% % % % % % % % % % Dehaze image processing 
clc;
clear all;
close all;
warning('off','all');
[filename,pathname] = uigetfile('*.png');
img = imread([pathname,filename]);
% % % % Rescale image
img = imresize(img,[256,256]);
figure,imshow(img);
title('input image')
% % % Data Type Conversion
img = im2double(img);
% % Filtering
% % % % Red Channel
I = img(:,:,1);
[hei, wid] = size(I);
p = I;
r = 16;
eps = 0.1^2;

N = boxfilter(ones(hei, wid), r); % the size of each local patch; N=(2r+1)^2 except for boundary pixels.

mean_I = boxfilter(I, r) ./ N;
mean_p = boxfilter(p, r) ./ N;
mean_Ip = boxfilter(I.*p, r) ./ N;
cov_Ip = mean_Ip - mean_I .* mean_p; % this is the covariance of (I, p) in each local patch.

mean_II = boxfilter(I.*I, r) ./ N;
var_I = mean_II - mean_I .* mean_I;

a = cov_Ip ./ (var_I + eps); % Eqn. (5) in the paper;
b = mean_p - a .* mean_I; % Eqn. (6) in the paper;

mean_a = boxfilter(a, r) ./ N;
mean_b = boxfilter(b, r) ./ N;

q = mean_a .* I + mean_b;
 figure,imshow(q);
 title('Merging Rgb Images')
% % % % Green Channel
I1 = img(:,:,2);
[hei1, wid1] = size(I1);
p1 = I1;
r1 = 16;
eps1 = 0.2^2;

N1 = boxfilter(ones(hei1, wid1), r1); % the size of each local patch; N=(2r+1)^2 except for boundary pixels.

mean1_I = boxfilter(I1, r1) ./ N1;
mean1_p = boxfilter(p1, r1) ./ N1;
mean1_Ip = boxfilter(I1.*p1, r1) ./ N1;
cov1_Ip = mean1_Ip - mean1_I .* mean1_p; % this is the covariance of (I, p) in each local patch.

mean1_II = boxfilter(I1.*I1, r1) ./ N1;
var1_I = mean1_II - mean1_I .* mean1_I;

a1 = cov1_Ip ./ (var1_I + eps1); % Eqn. (5) in the paper;
b1 = mean1_p - a1 .* mean1_I; % Eqn. (6) in the paper;

mean1_a = boxfilter(a1, r1) ./ N1;
mean1_b = boxfilter(b1, r1) ./ N1;

q1 = mean1_a .* I1 + mean1_b;
figure,imshow(q1)
title('mean value gratient image')
% % % % Blue Channel
