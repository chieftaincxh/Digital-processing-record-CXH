%%
%the perwitt detection
%function im2 = my_perwitt(im1)
im1 = imread('lena.bmp');
if size(im1,3) == 3
im1 = rgb2gray(im1);
end
h_gaussian = fspecial('gaussian',[3,3],3);
im1 = imfilter(im1,h_gaussian,'replicate');
f = double(im1);
[H,W] = size(im1);

Gx = [-1,0,1;-1,0,1;-1,0,1];
Gy = Gx';
sobel_threshold = 100;

for i = 1:H - 2
    for j = 1:W - 2
       temp = f(i:i+2,j:j+2);
       px = sum(sum(Gx.*temp));
       py = sum(sum(Gy.*temp));
       G = sqrt(px.^2+py.^2);
       if G > sobel_threshold
           im1(i,j) = 255;
       else
           im1(i,j) = 0;
       end   
    end
end
figure;
im2 = im2uint8(im1);
imshow(im2);
%end