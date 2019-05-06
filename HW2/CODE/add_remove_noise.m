im3_1 = imnoise(im3,'salt & pepper',0.02);
figure
imshowpair(im3,im3_1,'montage');
title('add sal&pepper noise');

im3_2 = imnoise(im3,'gaussian',0,0.02);%两个参数，均值和方差
figure
imshowpair(im3,im3_2,'montage');
title('add gaussian noise');


h3 = fspecial('average',5);
im3_3 = imfilter(im3_2,h3);
figure
imshowpair(im3,im3_3,'montage');
title('remove gaussian noise with averaging filter');

im3_4 = medfilt2(im3_1);
figure
imshowpair(im3_1,im3_4,'montage');
title('remove salt&pepper noise with median filter');


j= imnoise(im3,'gaussian',0,0.02);
figure
imshow(j);
title('after noise');
H1=zeros(size(im3));
for i=1:100
   j=imnoise(im3,'gaussian',0,0.02);
   H1=H1+double(j);
end
H=H1/100;
figure
imshow(uint8(H));
title('denoise by add and averaging');