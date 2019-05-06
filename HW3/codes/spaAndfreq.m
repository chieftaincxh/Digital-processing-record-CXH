close all 
clear
clc
im1 = imread('dog1.jpg');
im1 = rgb2ycbcr(im1);
figure;
imshow(im1);
im1_2 = im1(:,:,1);
figure;
imshow(im1_2);
%%
h1 = fspecial('gaussian',5,2.0);
im1_3 = uint8(conv2(im1_2,h1,'same'));
im1(:,:,1) = im1_3;
im1 = ycbcr2rgb(im1);
figure;
imshow(im1);
%%
im2 = imread('dog1.jpg');
im2 = rgb2ycbcr(im2);
im2_1 = im2(:,:,1);
[m,n]=size(im2_1);
Do=0.1*m;
F=fft2(im2_1);


u=0:(m-1);
v=0:(n-1);
idx=find(u>m/2);
u(idx)=u(idx)-m;
idy=find(v>n/2);
v(idy)=v(idy)-n;
[V,U]=meshgrid(v,u);
D=sqrt(U.^2+V.^2);

H=exp(-(D.^2)./(2*(Do^2)));

im2_2 = F.*H;
im2_3=real(ifft2(im2_2));
im2_3=uint8(im2_3);
im2(:,:,1) = im2_3;
im2 = ycbcr2rgb(im2);
figure;
imshow(im2);



%%



