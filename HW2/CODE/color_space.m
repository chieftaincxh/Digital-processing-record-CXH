im1 = imread('color1.jpg');

im1_1 = rgb2lab(im1);
figure
imshowpair(im1,im1_1,'montage');
title('rgb color  to lab color');

im1_2 = rgb2lab(im1,'Whitepoint','d50');
figure
imshowpair(im1,im1_2,'montage');
title('rgb color  to lab color with parameter');

figure
imshow(im1_1(:,:,1),[0,100]);%display the L* component of the LAB image
title('show the L* component of the LAB image')

im2 = imread('color2.jpg');
im2_1 = rgb2xyz(im2);
figure
imshowpair(im2,im2_1,'montage');
title('convert from rgb color to xyz color')

im2_2 = xyz2rgb(im2_1);
figure
imshowpair(im2_1,im2_2,'montage');
title('reverse from the xyz color to rgb color')

im1_3 = rgb2ycbcr(im1);
figure
imshowpair(im1,im1_3,'montage');
title('convert from rgb color to ycbcr color');

im1_4 = ycbcr2rgb(im1_2);
figure
imshowpair(im1_2,im1_4,'montage');
title('reverse from the ycbcr color to rgb color');