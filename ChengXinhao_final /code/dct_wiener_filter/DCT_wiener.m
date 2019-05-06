im1 = imread('apartments.jpg');
im1 = imnoise(im1,'gaussian',0,0.01);
%im1 = double(im1);
im2 = rgb2ycbcr(im1);
im2_1 = im2(:,:,1);% Y channel

%2D DCT 
im3 = dct2(im2_1);
s1 = size(im3);
x = [1:s1(1)];
y = [1:s1(2)];
imsample = log10(abs(im3)+1);
[x,y] = meshgrid(x,y);
figure;
surface(x,y,imsample');
view(45,45);
%choose the high fre sample 
coe = im3(400:end,300:end).*im3(400:end,300:end);
s2 = size(coe);

x1 = [1:s2(1)];
y1 = [1:s2(2)];
[x1,y1] = meshgrid(x1,y1);
figure;
surface(x1,y1,coe');
view(45,45);
%estimate the noise and create the wienerfilter
NoiseVariance = mean(mean(coe));
beta = 1.0;
NoiseVariance = beta*NoiseVariance;

SignalVariance = im3.*im3 + 0.01;
WienerFilter = 1 + (NoiseVariance./SignalVariance);
WiennerFilter = 1./WienerFilter;

%image !!!
IAfterFilter = im3.*WienerFilter;
im4 = idct2(IAfterFilter);
im2(:,:,1) = im4;
im2 = ycbcr2rgb(im2);
%im2 = uint8(im2);
figure;
imshowpair(im1,im2,'montage');
