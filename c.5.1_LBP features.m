%% Read the input images
clear;
path='VAP\thermal';
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
%% Extract lbp feature
for i = 1 : filesnumber(1,1)
% Decreasing "CellSize" increases matrix size but more features extracts
lbp{i} = extractLBPFeatures(gray{i},'CellSize',[8 8]);
    disp(['Extract LBP :   ' num2str(i) ]);
end;
% Converting feature vectors to a feature matrix
for i = 1 : filesnumber(1,1)
    lbpfeature(i,:)=lbp{i};
    disp(['to matrix :   ' num2str(i) ]);
end;
