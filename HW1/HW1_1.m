im1 = imread('mammogram1.jpg');
im2 = imread('mammogram2.jpg');
im3 = imread('ultrasound1.jpg');
im4 = imread('ultrasound2.jpg');
figure
subplot(2,2,1);
imshow(im1);
subplot(2,2,2);
imshow(im2);
subplot(2,2,3);
imshow(im3);
subplot(2,2,4);
imshow(im4);%show the four imagine in a figure

s1 = size(im1);
s2 = size(im2);
s3 = size(im3);
s4 = size(im4);
disp(s1);
disp(s2);
disp(s3);
disp(s4);

im3_1 = imadjust(im3,[],[],0.45);
figure
imshowpair(im3,im3_1,'montage');%compare the initial imagine and the transformed imagine (gamma:0.45)
im4_1 = imadjust(im4,[],[],2.2);
figure
imshowpair(im4,im4_1,'montage');%compare the initial imagine and the transformed imagine (gamma:2.2)

im1_1 = imadjust(im1,[0,1],[1,0]);
figure
imshowpair(im1,im1_1,"montage");%compare the initial imagine and the transformed imagine
im2_1 = imadjust(im2,[0,1],[1,0]);
figure
imshowpair(im2,im2_1,'montage');%compare the initial imagine and the transformed imagine

im1_2 = imcomplement(im1);
figure
imshowpair(im1_1,im1_2,'montage');%compare the transformed imagine(imadjust) and the transformed imagine(imcomplement)




