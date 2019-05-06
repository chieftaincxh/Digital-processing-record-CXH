im1 = imread('dog1.jpg');
im2 = imread('experiment1.jpg');
%%
% create gaussian filter(5*5)
h1 = fspecial('gaussian',5,2.0);
%trasnform to YCBCR and pick the Y channel
im1_1 = rgb2ycbcr(im1);
im2_1 = rgb2ycbcr(im2);
im1_2 = im1_1(:,:,1);
im2_2 = im2_1(:,:,1);
figure;
imshow(im1_2);
title('Y channel of im1');
figure;
imshow(im2_2);
title('Y channel of im2');
%%
%perform a spatial convolution 
im1_3 = imfilter(im1_2,h1);
im2_3 = imfilter(im2_2,h1);
imshowpair(im1_3,im2_3,'montage');
im1_1(:,:,1) = im1_3;
im1_4 = ycbcr2rgb(im1_1);
figure;
imshowpair(im1,im1_4,'montage');

im2_1(:,:,1) = im2_3;
im2_4 = ycbcr2rgb(im2_1);
figure;
imshowpair(im2,im2_4,'montage');

%%
