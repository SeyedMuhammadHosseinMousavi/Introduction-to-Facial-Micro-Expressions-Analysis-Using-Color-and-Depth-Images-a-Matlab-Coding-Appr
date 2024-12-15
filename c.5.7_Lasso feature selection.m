%Detect objects using Viola-Jones Algorithm
%To detect Face
FDetect = vision.CascadeObjectDetector;
%Read the input images
path='jaffe';
fileinfo = dir(fullfile(path,'*.jpg'));
filesnumber=size(fileinfo);
for i = 1 : filesnumber(1,1)
images{i} = imread(fullfile(path,fileinfo(i).name));
    disp(['Loading image No :   ' num2str(i) ]);
end;
%% Extract hog feature
for i = 1 : filesnumber(1,1)
hog{i} = extractHOGFeatures(images{i},'CellSize',[16 16]);
    disp(['Extract hog :   ' num2str(i) ]);
end;
for i = 1 : filesnumber(1,1)
    hogfeature(i,:)=hog{i};
    disp(['to matrix :   ' num2str(i) ]);
end;
%% Lasso Regularization Algorithm 
% Labeling for lasso
label(1:31,1)=1;
label(31:61,1)=2;
label(62:90,1)=3;
label(91:122,1)=4;
label(123:152,1)=5;
label(153:182,1)=6;
label(183:212,1)=7;
% Construct the lasso fit by using 5-fold cross-validation
% Set of coefficients B that models label as a function of hogfeature
% By default lasso will create 100 different models. Each model was estimated
% using a slightly larger lambda. All of the model coefficients are stored in array
% B. The rest of the information about the model is stored in a structure named Stats.
[B Stats] = lasso(hogfeature,label, 'CV', 5);
disp(B(:,1:5))
disp(Stats)
% lassoPlot generates a plot that displays the relationship between lambda and the 
% cross validated mean square error (MSE) of the resulting model. Each of the 
% red dots show the MSE for the resulting model. The vertical line segments 
% stretching out from each dot are error bars for each estimate.
lassoPlot(B, Stats, 'PlotType', 'CV')
ds.Lasso = B(:,Stats.IndexMinMSE);
disp(ds)
sizemfcc=size(hogfeature);
temp=1;       
for i=1:sizemfcc(1,2)
if ds.Lasso(i)~=0
lasso(:,temp)=hogfeature(:,i);
temp=temp+1;
end;
end;
% Labeling feature extracted matrix for classification
sizefinal=size(lasso);
sizefinal=sizefinal(1,2);
lasso(1:31,sizefinal+1)=1;
lasso(31:61,sizefinal+1)=2;
lasso(62:90,sizefinal+1)=3;
lasso(91:122,sizefinal+1)=4;
lasso(123:152,sizefinal+1)=5;
lasso(153:182,sizefinal+1)=6;
lasso(183:212,sizefinal+1)=7;
