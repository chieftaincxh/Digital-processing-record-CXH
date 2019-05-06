I = imread('school5.jpg');
figure;
imshow(I);
I = rgb2gray(I);

figure;
imshow(I);title('original image');
I = edge(I,'canny',0.10);
[Hough,Teta,Rho] =my_hough_line(I);%my_hough_line(I);%hough(I,'RhoResolution', 0.5);

Peaks=houghpeaks(Hough,20);
lines=houghlines(I,Teta,Rho,Peaks);

% draw the line
figure,imshow(I,[]),title('my Hough Transform Result'),hold on 
 for k=1:length(lines)
xy=[lines(k).point1;lines(k).point2];   
plot(xy(:,1),xy(:,2),'LineWidth',4,'color',[0 1 0]),hold on
 end
 %connect the line together
k = 2;
while(k<=length(lines))
    nlind = 0;
    while(lines(k).theta == lines(k-1).theta && lines(k).rho == lines(k-1).rho)
        nlind = nlind + 1;
        newlines(nlind) = lines(k-1);
        newlines(nlind).point2=lines(k).point2;
        newxy=[newlines(nlind).point1;newlines(nlind).point2];
        plot(newxy(:,1),newxy(:,2),'LineWidth',4,'color',[0 1 0]);
        k=k+1;       
        if(k>length(lines))
            break;
        end
    end 
    k = k + 1;
end
