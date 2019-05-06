im1 = imread('dog.jpg');
figure;
subplot(1,2,1);
imshow(im1);
title('original picture');
im1 = rgb2ycbcr(im1);
im11 = im1(:,:,1);%Y channel
im12 = im1(:,:,2);
im13 = im1(:,:,3);
im2y = im2double(im11);
im2u = im2double(im12);
im2v = im2double(im13);
%%
%compression of  Y channel
T = dctmtx(8);
Imdcty = blkproc(im2y,[8 8],'P1*x*P2', T , T');
mask = [1 1 0 0 0 0 0 0
1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0];

im3y = blkproc(Imdcty,[8 8] ,'P1.*x',mask);% dct convert
Imidcty = blkproc(im3y , [8 8] , 'P1*x*P2' , T' , T);%quantization of the 8*8 matrix
Imidcty = im2uint8(Imidcty);%inverse dct
im1(:,:,1) = Imidcty;
%% 
%compression of  Cb channel
b=[1 1 0 0 0 0 0 0
1 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0];
Imdctu = blkproc(im2u,[8 8],'P1*x*P2', T , T');
im3u = blkproc(Imdctu,[8 8] ,'P1.*x',b);
Imidctu = blkproc(im3u , [8 8] , 'P1*x*P2' , T' , T);
Imidctu = im2uint8(Imidctu);
im1(:,:,2) = Imidctu;
%% 
%compression of Cr channel
b=[1 1 0 0 0 0 0 0
1 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0];
Imdctv = blkproc(im2v,[8 8],'P1*x*P2', T , T');
im3v = blkproc(Imdctv,[8 8] ,'P1.*x',b);
Imidctv = blkproc(im3v , [8 8] , 'P1*x*P2' , T' , T);
Imidctv = im2uint8(Imidctv);
im1(:,:,3) = Imidctv;
%%
%perfrom the result
im1 = ycbcr2rgb(im1);
subplot(1,2,2);
imshow(im1);title('after simple quantization');
%%
%compression with the zig consequence
imzigY = Zig(im3y,1);
imzigU = Zig(im3u,2);
imzigV = Zig(im3v,3);
%%
%decompression
im3y = deZig(imzigY);
im3u = deZig(imzigU);
im3v = deZig(imzigV);
imF(:,:,1) = im3y;
imF(:,:,2) = im3u;
imF(:,:,3) = im3v;
imF = ycbcr2rgb(imF);
%im1 = ycbcr2rgb(im1);
figure;
subplot(1,2,1);
imshow(im1);title('original image');
subplot(1,2,2);
imshow(imF);title('after compression and decompression');
