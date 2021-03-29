%% Read the input images
clear;
path='VAP\depth';
fileinfo = dir(fullfile(path,'*.png'));
filesnumber=size(fileinfo);
for i = 1 : filesnumber(1,1)
images{i} = imread(fullfile(path,fileinfo(i).name));
    disp(['Loading image No :   ' num2str(i) ]);
end;
%% calculating Local phase quantization feature
% winsize= should be an odd number greater than 3. 
% the bigger the number the more accuracy
winsize=39;
for i = 1 : filesnumber(1,1)
f{i}=lpq(images{i},winsize);
    disp(['No of LPQ :   ' num2str(i) ]);
end;
clear fff;
for i = 1 : filesnumber(1,1)
    lpq(i,:)=f{i};
end;

