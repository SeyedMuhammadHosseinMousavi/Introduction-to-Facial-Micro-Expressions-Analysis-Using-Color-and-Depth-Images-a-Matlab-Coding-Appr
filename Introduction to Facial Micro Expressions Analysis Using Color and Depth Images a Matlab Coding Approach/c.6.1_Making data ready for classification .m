clc;
clear;
%% Read the input images
path='Four KDEF';
fileinfo = dir(fullfile(path,'*.jpg'));
filesnumber=size(fileinfo);
for i = 1 : filesnumber(1,1)
images{i} = rgb2gray(imread(fullfile(path,fileinfo(i).name)));
    disp(['Loading image No :   ' num2str(i) ]);
end;
%% Resize images
for i = 1 : filesnumber(1,1)
resized{i}=imresize(images{i}, [256 256]); 
    disp(['Image Resized :   ' num2str(i) ]);
end;
%% Extract LBP features
for i = 1 : filesnumber(1,1)
    % the less cell size the more accuracy 
lbp{i} = extractLBPFeatures(resized{i},'CellSize',[32 32]);
    disp(['Extract LBP :   ' num2str(i) ]);
end;
for i = 1 : filesnumber(1,1)
    lbpfeature(i,:)=lbp{i};
    disp(['to matrix :   ' num2str(i) ]);
end;

%% Lasso Regularization Algorithm 
% Labeling for lasso
label(1:50,1)=1;
label(51:100,1)=2;
label(101:150,1)=3;
label(151:200,1)=4;

[B Stats] = lasso(lbpfeature,label, 'CV', 5);
disp(B(:,1:5))
disp(Stats)

lassoPlot(B, Stats, 'PlotType', 'CV')
ds.Lasso = B(:,Stats.IndexMinMSE);
disp(ds)
sizemfcc=size(lbpfeature);
temp=1;       
for i=1:sizemfcc(1,2)
if ds.Lasso(i)~=0
lasso(:,temp)=lbpfeature(:,i);
temp=temp+1;
end;
end;
% Labeling feature extracted matrix for classification
sizefinal=size(lasso);
sizefinal=sizefinal(1,2);
lasso(1:50,sizefinal+1)=1;
lasso(51:100,sizefinal+1)=2;
lasso(101:150,sizefinal+1)=3;
lasso(151:200,sizefinal+1)=4;
classificationLearner