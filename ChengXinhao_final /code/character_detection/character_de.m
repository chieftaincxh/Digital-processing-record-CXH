
% read after QIEGE1();% read files
 
 liccode=char(['0':'9' 'A':'Z' '¾©','ÁÉ','Â³','ÉÂ','ËÕ','Ô¥','Õã','¹ó']);%the model character
 subBw2 = zeros(40,20);
 num = 1;   
 Code = '0';
 Code(1:end) = 0;
 for i = 1:7 
    ii = int2str(i);    
    word = imread([ii,'.jpg']); % load image
    %word = ~word;
    word = im2bw(word);
    segBw2 = imresize(word,[40 20]);
     if i == 1   % first is the province name
        kMin = 37;
        kMax = 44;
     else
     kMin = 1;
     kMax = 36;
     end

    l = 1;
    error = 0;
    for k = kMin : kMax

        fname = strcat('model/',liccode(k),'.jpg');
        
        samBw2 = imread(fname); 
        samBw2 = im2bw(samBw2); 
        samBw2 = imresize(samBw2,[40,20]);
        Dmax = 0;
        % resize the picture
        for i1 = 1:40
            for j1 = 1:20
                subBw2(i1, j1) = segBw2(i1, j1) - samBw2(i1 ,j1);
                if subBw2(i1, j1) ~= 0
                    Dmax = Dmax + 1;
                end
            end
        end
        error(l) = Dmax;
        l = l + 1;
    end
    
    % find the samllest error
    errorMin = min(error);
    findc = find(error == errorMin);
    disp(findc);
       
    %detect the character
    Code(num*2 - 1) = liccode(findc + kMin - 1);
    Code(num*2) = ' ';
    num = num + 1;
   
 end
 disp(Code);
 msgbox(Code,'car number');