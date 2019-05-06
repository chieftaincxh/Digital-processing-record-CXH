close all;
clear;
clc;
I = imread('cameraman.tif');
figure;
imshow(I);
Inew = dct2(I);
%%
figure
imshow(log(abs(Inew)),[])
colormap(gca,jet(64))
colorbar
title('  most of the energy is in the upper left corner');
%%
way=inputdlg('input remove low or high frequencies ','DCT method');
way=char(way);
switch way
    case 'low' 
        Inew(abs(Inew) > 100) = 0;%%low filter
    case 'high' 
         Inew(abs(Inew) < 10) = 0;%%high filter
    otherwise
        errordlg('false');
end
%%
Inew3 = dct2(Inew);
figure;
imshowpair(I,Inew3,'montage');
title('Original Grayscale Image (Left) and Processed Image (Right)');









