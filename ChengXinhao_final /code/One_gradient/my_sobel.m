% sboel edge detection
%im1 = imread('school.jpg');
%function im2 = my_sobel(im1)
im1 = imread('lena.bmp');
if size(im1,3) == 3
im1 = rgb2gray(im1);
end
h_gaussian = fspecial('gaussian',[3,3],3);
im1 = imfilter(im1,h_gaussian,'replicate');

im1 = mat2gray(im1);
f = double(im1);
[H,W] = size(im1);
im2 = im1;
Gx = [-1,-2,-1;0,0,0;1,2,1];
Gy = Gx';
sobel_threshold = 1.2;% set a threshold similar to what in the edge function

for i = 1:H - 2
    for j = 1:W - 2
       temp = f(i:i+2,j:j+2);
       px = sum(sum(Gx.*temp));
       py = sum(sum(Gy.*temp));
       G = sqrt(px.^2+py.^2);
       if G > sobel_threshold
           im2(i,j) = 255;
       else
           im2(i,j) = 0;
       end   
    end
end
figure;
im2 = im2uint8(im2);
imshow(im2);
%im3 = im2uint8(edge(im1,'sobel',0.08));
imshow(im2);
%end