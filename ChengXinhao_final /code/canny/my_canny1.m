im1 = imread('school5.jpg');
im1 = rgb2gray(im1);

%remove the noise
h_gaussian = fspecial('gaussian',[3,3],3);
im2 = imfilter(im1,h_gaussian,'replicate');
imshowpair(im1,im2,'montage');
%use sobel detector to calculate gradient in the image
f = double(im2);
[H,W] = size(im2);

Gx = [-1,-2,-1;0,0,0;1,2,1];
Gy = Gx';
sobel_threshold = 10;

for i = 2:H - 1
    for j = 2:W - 1
       temp = f(i-1:i+1,j-1:j+1);
       px(i,j) = sum(sum(Gx.*temp));
       py(i,j) = sum(sum(Gy.*temp));
       G = sqrt(px(i,j).^2+py(i,j).^2);
       
           im2(i,j) = G; 
       %the direction of the edge: Theta = invtan(Gy/Gx)
       Theta = atand(py(i,j)/px(i,j));
       %convert the angle in 4 ranges
        if (Theta >= 0 && Theta < 45)
            direction(i,j) = 2;
        elseif (Theta >= 45 && Theta < 90)
            direction(i,j) = 3;
        elseif (Theta >= 90 && Theta < 135)
            direction(i,j) = 0;
        else
            direction(i,j) = 1;
        end
    end
end
f2 = double(im2);
% two threhold in the edge determination(high and low):
high_thresh = 100;
low_thresh = 0.4*high_thresh;

%non-maximum suppression,trace along the edge and set the non-edge values to 0
for i = 2:H - 1
    for j = 2:W - 1
         right_d = f2(i,j+1);
         down_d = f2(i+1,j);
         left_d = f2(i,j-1);
         top_d = f2(i-1,j);
         top_right = f2(i-1,j+1);
         top_left = f2(i-1,j-1);
         down_right = f2(i+1,j+1);
         down_left = f2(i-1,j+1);
         px2 = f2(i,j);
         if direction(i,j) == 0
          d = abs(px(i,j)/py(i,j));
          G1 = right_d*(1-d) + top_right*d;
          G2 = left_d*(1-d) + down_left*d;
         elseif direction(i,j) == 1
           d = abs(px(i,j)/py(i,j));
           G1 = top_d*(1-d) + top_right*d;
           G2 = down_d*(1-d) + down_left*d;
         elseif direction(i,j) == 2
            d = abs(px(i,j)/py(i,j));
            G1 = top_d*(1-d) + top_left*d;
            G2 = down_d*(1-d) + down_right*d;
          elseif direction(i,j) == 3
             d = abs(px(i,j)/py(i,j));
             G1 = left_d*(1-d) + top_left*d;
             G2 = right_d*(1-d) + down_right*d;
         else
             G1 = high_thresh;
             G2 = high_thresh;
         end
          if px2 <= G1 || px2 <= G2
              im2(i,j) = 0;
          end 
    end
end
figure;
imshow(im2);
%two threshold to make strong , weak , 0
for i = 2:H - 1
    for j = 2:W - 1
        if im2(i,j) > high_thresh
            im2(1,2) = 255;
        elseif im2(i,j) > low_thresh
            im2(i,j) = low_thresh;
        else
            im2(i,j) = 0;
        end
    end
end
figure;
imshow(im2);
%detect the 8 pixels around the low edge to determine whether it is an edge
for i = 2:H - 1
    for j = 2:W - 1
        if im2(i,j) == low_thresh
            neighbors = im2(i-1:i+1,j-1:j+1);
        else
            continue
        end
        for k = 1:3
            for x = 1:3
            if neighbors(k,x)== 255
                flag = 1;
            end
            end
        end
        if flag==0
            im2(i,j) = 0;
        end
            
    end
end
figure;
im3 = edge(im1,'canny',0.2);
imshowpair(im2,im3,'montage');
