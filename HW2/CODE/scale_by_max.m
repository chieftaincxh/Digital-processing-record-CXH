Image = imread('redImage.jpg');
r=Image(:,:,1);
g=Image(:,:,2);
b=Image(:,:,3);
[x,y,z] = size(Image);
max = r(1,1) + g(1,1) + b(1,1);
avgR = 0;
avgG = 0;
avgB = 0;
avgR = int64(avgR);
avgG = int64(avgG);
avgB = int64(avgB);
count1 = 0;
k1 = 1;
k2 = 1;
k3 = 1;
S = 0;
for i=1:x
    for j=1:y
        sumR(k1) = r(i,j); 
        k1 = k1 + 1;
        sumG(k3) = g(i,j);
        k2 = k2 + 1;
        sumB(k3) = b(i,j);
        k3 = k3 + 1;
        if((r(i,j) + g(i,j) + b(i,j)) > max)
            max = r(i,j) + g(i,j) + b(i,j);
        end
        end
    end
for w1 = 1:k1-1
    for e1 = w1 + 1 : k1-1
        if (sumR(w1) < sumR(e1))
            temp = sumR(w1);
            sumR(w1) = sumR(e1);
            sumR(e1) = temp;
        end
    
    end
    
end
for w2 = 1:k2-1
    for e2 = w2 + 1 : k2-1
        if (sumG(w2) < sumG(e2))
            temp = sumR(w1);
            sumG(w2) = sumG(e2);
            sumG(e2) = temp;
        end
    
    end
    
end
for w3 = 1:k3-1
    for e3 = w2 + 1 : k3-1
        if (sumB(w3) < sumB(e3))
            temp = sumB(w1);
            sumB(w3) = sumB(e3);
            sumB(e3) = temp;
        end
    
    end
    
end
for i=1:x
    for j=1:y
        if((r(i,j) + g(i,j) + b(i,j)) > (sumR(int32(k1/14))+sumG(int32(k2/14))+sumB(int32(k3/14))))
             avgR = avgR + int64(r(i,j));
             avgG = avgG + int64(g(i,j));
             avgB = avgB + int64(b(i,j));
             count1 = count1 + 1;
        end
    end
end
disp(sumR(int32(k1/10))+sumG(int32(k2/10))+sumB(int32(k3/10)))
avgR = avgR/count1;
avgG = avgG/count1;
avgB = avgB/count1;

paraR = uint32(max)/uint32(avgR);
paraG = uint32(max)/uint32(avgG);
paraB = uint32(max)/uint32(avgB);

NI(:,:,1) = uint32(r)* paraR;
NI(:,:,2) = uint32(g)* paraG;
NI(:,:,3) = uint32(b)* paraB;
figure;
imshow(Image);
figure;
imshow(NI);
