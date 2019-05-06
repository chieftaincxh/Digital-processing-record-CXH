%function QIEGE1(img)
img = imread('123.png');
img = rgb2gray(img);
img=imadjust(img,[0 1],[1 0]);
img = ~im2bw(img);
img = bwareaopen(img,1500);
img(:,end) = 0;
figure;
imshow(img);
img=clip(img);

num=size(img,2);
s1 = 1;
i = 1;
row = size(img,1);
while sum(img(:,s1)) == 0 && s1 < num
s1 = s1 + 1;
end
s = s1 + 1;
while s <= num
    if sum(img(:,s)) == 0
        nm = img(:,1:s-1);  
        rm = img(:,s:end);
        fl = clip(nm);
        re=clip(rm);
        
        %figure;
        %imshow(fl);
        ii = int2str(i);
        imwrite(fl,[ii,'.jpg']); % read them to the disk
        img = re;
        if re == 0
            break;
        else
            i = i + 1;
        end
        if i > 7
           break
        end

        
        num=size(img,2);
        s1 = 1;
        while  s1 < num && sum(img(:,s1)) == 0 
        s1 = s1 + 1;
        end
        s = s1;
    else
        if s == size(img,2)
            img(:,s) = 0;
        else
            s = s + 1;
            continue
        end
        
        
    end
end



