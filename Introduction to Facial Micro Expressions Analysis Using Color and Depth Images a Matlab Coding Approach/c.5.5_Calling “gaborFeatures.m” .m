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

%% extract gabor features
for i = 1 : filesnumber(1,1)
gaborArray = gaborFilterBank(5,8,39,39);  % Generates the Gabor filter bank
featureVector{i} = gaborFeatures(gray{i},gaborArray,8,8);   % Extracts Gabor feature vector, 'featureVector', from the image, 'img'.
disp(['Extracting Gabor Vector :   ' num2str(i) ]);
end;
for i = 1 : filesnumber(1,1)
    Gaborvector(i,:)=featureVector{i};
    disp(['to matrix :   ' num2str(i) ]);
end;

