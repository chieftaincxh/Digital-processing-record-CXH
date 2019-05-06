im2 = imread('showimage.jpeg');
im1 = imread('showimage1.jpeg');


im1_1 = rgb2ycbcr(im1);
im2_1 = rgb2ycbcr(im2);
im1_2 = im1_1(:,:,1);
im2_2 = im2_1(:,:,1);


im1_3 = imnoise(im1_2,'gaussian',0,0.02);
imshowpair(im1_2,im1_3,"montage");

%perform 2D DCT image
im1_4 = dct2(im1_3);
ima = log10(abs(im1_4)+1);
s1 = size(im1_4);
x = [1:s1(1)];
y = [1:s1(2)];
[x,y] = meshgrid(x,y);
figure;
surface(x,y,ima');
view(60,45);

%pick the high frequency corner as sample
sigma = im1_4(300:end,300:end).*im1_4(300:end,300:end);
s3 = size(sigma)

xs3 = [1:s3(1)];
ys3 = [1:s3(2)];

[xs3,ys3] = meshgrid(xs3,ys3);

figure
surface(xs3,ys3,sigma')
view(60,45)
%%
NoiseVariance = mean(mean(sigma));


beta = 2.0
NoiseVariance = beta*NoiseVariance;

% now use this value ns  for wiener filter

SignalVariance = im1_4.*im1_4 + 0.001;
WienerFilter = 1 + (NoiseVariance./SignalVariance);
WienerFilter = 1./WienerFilter;

% Now apply the Wiener Filter to the signal DCT coefficients

FilteredImageDCT = im1_4.*WienerFilter;

% Do the inverse DCT transform to go back to Gray Value

FilteredImage = idct2(FilteredImageDCT);

% Get rid of all values below 0 and highr than 255

imo = uint8(FilteredImage);

% Display filtered Image



figure;

imshowpair(imo,im1_3,'montage');
title(' Wiener(left) and Nonlocal means (right)')