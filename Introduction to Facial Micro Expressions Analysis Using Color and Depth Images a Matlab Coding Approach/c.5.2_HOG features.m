%% Read the input images
clear;
path='VAP\color';
fileinfo = dir(fullfile(path,'*.jpg'));
filesnumber=size(fileinfo);
for i = 1 : filesnumber(1,1)
images{i} = imread(fullfile(path,fileinfo(i).name));
    disp(['Loading image No :   ' num2str(i) ]);
end;
% RGB to gray convertion
for i = 1 : filesnumber(1,1)
gray{i}=rgb2gray(images{i});
    disp(['To Gray :   ' num2str(i) ]);
end;
%% Extract hog feature
for i = 1 : filesnumber(1,1)
% Decreasing "CellSize" increases matrix size but more features extracts
hog{i} = extractHOGFeatures(gray{i},'CellSize',[16 16]);
    disp(['Extract HOG :   ' num2str(i) ]);
end;
% Converting feature vectors to a feature matrix
for i = 1 : filesnumber(1,1)
    hogfeature(i,:)=hog{i};
    disp(['to matrix :   ' num2str(i) ]);
end;
