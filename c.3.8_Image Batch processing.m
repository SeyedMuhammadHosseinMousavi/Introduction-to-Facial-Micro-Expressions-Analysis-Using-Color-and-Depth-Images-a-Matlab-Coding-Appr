% Read the input images
path='c:\dataset';% Data Directory Path
fileinfo = dir(fullfile(path,'*.jpg')); % Files properties
filesnumber=size(fileinfo); % Number of files
for i = 1 : filesnumber(1,1) % Reading loop as number of files
images{i} = imread(fullfile(path,fileinfo(i).name)); %Creating cell array of "images"
    disp(['Loading image No :   ' num2str(i) ]); % Reading iterations in the loop as message
end;
%RGB to gray convertion
for i = 1 : filesnumber(1,1)
gray{i}=rgb2gray(images{i});
    disp(['To Gray :   ' num2str(i) ]);
end;
%Histogram equalization
for i = 1 : filesnumber(1,1)
histequation{i}=histeq(gray{i}); 
    disp(['Hist EQ :   ' num2str(i) ]);
end;
%Contrast adjustment
for i = 1 : filesnumber(1,1)
adjusted{i}=imadjust(histequation{i}); 
    disp(['Image Adjust :   ' num2str(i) ]);
end;
% Resize the final image size
for i = 1 : filesnumber(1,1)
resized{i}=imresize(adjusted{i}, [128 128]); 
    disp(['Image Resized :   ' num2str(i) ]);
end;
%Display multiple image frames as rectangular montage
montage(resized, 'Size', [10 20]);