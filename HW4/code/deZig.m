function[x] = deZig(y)
order = [1 9  2  3  10 17 25 18 11 4  5  12 19 26 33  ...
    41 34 27 20 13 6  7  14 21 28 35 42 49 57 50  ...
    43 36 29 22 15 8  16 23 30 37 44 51 58 59 52  ...
    45 38 31 24 32 39 46 53 60 61 54 47 40 48 55  ...
    62 63 56 64];% the sequence
mask = [1 1 0 0 0 0 0 0
1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0];
b=[1 1 0 0 0 0 0 0
1 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0];% the quantization
%%
rev = order;                          % ���㷴��
for k = 1:length(order)
    rev(k) = find(order == k);
end

xb = double(y.numblocks);             % ��ĸ���
sz = double(y.size);
xn = sz(2);                           % ����
xm = sz(1);                           % ����
x = y.r;                              % ѹ���������
eob = max(x(:));                      % ���ؿ�β��־

z = zeros(64, xb);   k = 1;           % ���� 64 * xb �������
for j = 1:xb                          % x�е�ֵ����z�У��������eob��ת����һ��
    for i = 1:64                       
        if x(k) == eob                  
            k = k + 1;   
            break;          
        else
            z(i, j) = x(k);
            k = k + 1;
        end
    end
end
%%
T=dctmtx(8);                                   %8*8 dct matrix  
z = z(rev, :);                                 % recover the sequence
x = col2im(z, [8 8], [xm xn], 'distinct');     % matrix
if y.flag==1
    x = blkproc(x, [8 8], 'x .* P1', mask);       % quantization inverse
else
    x = blkproc(x, [8 8], 'x .* P1', b);
end
x = blkproc(x, [8 8], 'P1 * x * P2', T', T);   % DCT inverse
end

