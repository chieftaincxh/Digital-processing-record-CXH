

h1 = fspecial('motion',20,45);
h2 = fspecial('gaussian',3,0.1);
figure;
imshow(im1(:,:,1));

im1_4 = imfilter(im1(:,1,:),h1);
figure
imshowpair(im1,im1_4,'montage');
title('create a filter and filter an image');

im1_5 = imfilter(im1(:,:,1),h2);
figure
imshowpair(im1,im1_5,'montage');
title('create a filter and filter an image');



