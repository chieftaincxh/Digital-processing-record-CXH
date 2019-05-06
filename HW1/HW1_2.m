
  


im1 = imread('experiment1.jpg');
im1_1 = mat2gray(im1,[200,300]);
im1_2 = im2double(im1);

im1_3 = im2uint8(im1);


c = 1;
im1_4 = c * log(1+double(im1));
im1_5 = im2uint8(mat2gray(im1_4));
figure
imshow(im1_5);


im1_6 = imresize(im1,2.0);
figure
imshowpair(im1,im1_6,'montage');