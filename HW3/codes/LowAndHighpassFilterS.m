
clear;
clc;
I = imread('cameraman.tif');
[m,n]=size(I);
Do=0.1*m;
F=fft2(I);
%figure;
%imshow(log(fftshift(abs(F))+1),[]);

u=0:(m-1);
v=0:(n-1);
idx=find(u>m/2);
u(idx)=u(idx)-m;
idy=find(v>n/2);
v(idy)=v(idy)-n;
[V,U]=meshgrid(v,u);

D=sqrt(U.^2+V.^2);%%Distance matrix, a matrix representing the distance between each pixel and the center of the image
%%
way=inputdlg('input the name of filter: ILPF,BLPF,GLPF,IHPF,BHPF,GHPF','filter');
way=char(way);
switch way
    case 'ILPF' 
        H=double(D<=Do);%%Ideal low pass filter
    case 'BLPF' 
        H=1./(1+(D./Do).^4);%%butterworth low pass filter
    case 'GLPF' 
        H=exp(-(D.^2)./(2*(Do^2)));%%guassian high pass filter
    case 'IHPF'
        H=double(D>=Do);%%Ideal high pass filter
    case 'BHPF'
        H=1./(1+(Do./D).^4);%%butterworth high pass filter
    case 'GHPF'
        H=1-exp(-(D.^2)./(2*(Do^2)));%%guassian high pass filter
    otherwise
        errordlg('false');
end
%%
Fout=F.*H;
figure;
imshow(log(fftshift(abs(F))+1),[]);%Display the spectrogram before filtering
figure;
imshow(log(fftshift(abs(Fout))+1),[]);%Display the spectrogram after filtering
f=real(ifft2(Fout));
f=uint8(f);
figure,imshow(f),title([way,'after filtering']);
figure,imshow(I),title('before filtering');