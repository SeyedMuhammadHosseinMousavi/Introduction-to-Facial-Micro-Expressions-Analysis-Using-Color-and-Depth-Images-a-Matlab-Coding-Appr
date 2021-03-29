clc;
clear;
%% Read the input images
path='Network';
fileinfo = dir(fullfile(path,'*.png'));
filesnumber=size(fileinfo);
for i = 1 : filesnumber(1,1)
images{i} = imread(fullfile(path,fileinfo(i).name));
    disp(['Loading image No :   ' num2str(i) ]);
end;
%% Contrast Adjustment
for i = 1 : filesnumber(1,1)
adjusted{i}=imadjust(images{i}); 
    disp(['Image Adjust :   ' num2str(i) ]);
end;
%% Resize Images
for i = 1 : filesnumber(1,1)
resized{i}=imresize(adjusted{i}, [256 256]); 
    disp(['Image Resized :   ' num2str(i) ]);
end;
%% Calculating Local Phase Quantization Features
% winsize= should be an odd number greater than 3. 
% the bigger the number the more accuracy
winsize=19;
for i = 1 : filesnumber(1,1)
tmp{i}=lpq(resized{i},winsize);
    disp(['No of LPQ :   ' num2str(i) ]);
end;
for i = 1 : filesnumber(1,1)
    lpq(i,:)=tmp{i};
end;
%% Labeling For Classification (Classification Learner APP)
sizefinal=size(lpq);
sizefinal=sizefinal(1,2);
lpq(1:50,sizefinal+1)=1;
lpq(51:100,sizefinal+1)=2;
lpq(101:150,sizefinal+1)=3;
lpq(151:200,sizefinal+1)=4;
lpq(201:250,sizefinal+1)=5;

%% Labeling For Classification (Neural Network Pattern Recognition APP)
lpqdata=lpq(:,1:end-1);
lpqlbl=lpq(:,end);
sizelpq=size(lpq);
sizelpq=sizelpq(1,1);
for i=1 : sizelpq
            if lpqlbl(i) == 1
               lpqlbl2(i,1)=1;
        elseif lpqlbl(i) == 2
               lpqlbl2(i,2)=1; 
        elseif lpqlbl(i) == 3
               lpqlbl2(i,3)=1;
        elseif lpqlbl(i) == 4
               lpqlbl2(i,4)=1; 
        elseif lpqlbl(i) == 5
               lpqlbl2(i,5)=1; 
        end
end
nprtool