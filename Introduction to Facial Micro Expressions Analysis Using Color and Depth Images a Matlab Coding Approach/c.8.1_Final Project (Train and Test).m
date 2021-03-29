
clc;
clear;
%% Reading and Face Detection
FDetect = vision.CascadeObjectDetector('FrontalFaceCART','MergeThreshold',16');
%Read the input images
path='IKFDB ClassLearner';
fileinfo = dir(fullfile(path,'*.jpg'));
filesnumber=size(fileinfo);
for i = 1 : filesnumber(1,1)
images{i} = imread(fullfile(path,fileinfo(i).name));
    disp(['Loading image No :   ' num2str(i) ]);
end;
% Returns Bounding Box values based on number of objects
for i = 1 : filesnumber(1,1)
BB{i}=step(FDetect,(imread(fullfile(path,fileinfo(i).name)))); 
    disp(['BB :   ' num2str(i) ]);
end;
% Find number of empty BB and index of them
c=0;
for  i = 1 : filesnumber(1,1)
   if  isempty(BB{i})
        c=c+1;
        indexempty(c)=i;
   end;
end;
% Replace the empty cells with bounding box
for  i = 1 : c
BB{indexempty(i)}=[40 60 180 180];
end;
% Removing other founded faces and keep just frist face or box
for  i = 1 : filesnumber(1,1)
    BB{i}=BB{i}(1,:);
end;
% Croping the Bounding box(face)
for i = 1 : filesnumber(1,1)
croped{i}=imcrop(images{i},BB{i}); 
    disp(['Croped :   ' num2str(i) ]);
end;
%% Color to Gray Conversion
for i = 1 : filesnumber(1,1)
gray{i}=rgb2gray(croped{i}); 
    disp(['To Gray :   ' num2str(i) ]);
end;
%% Resize Images
for i = 1 : filesnumber(1,1)
resized{i}=imresize(gray{i}, [256 256]); 
    disp(['Image Resized :   ' num2str(i) ]);
end;
%% Contrast Adjustment
for i = 1 : filesnumber(1,1)
adjusted{i}=imadjust(resized{i}); 
    disp(['Image Adjust :   ' num2str(i) ]);
end;
%% Sharp Polished Edge Detection
for i = 1 : filesnumber(1,1)
[edge{i},polished{i}]=sharppolished(adjusted{i});
    disp(['Sharp Polished Edge Detection and Pre-Processing :   ' num2str(i)]);
end;
%% Extract LBP Features (just color)
for i = 1 : filesnumber(1,1)
    % The less cell size the more accuracy 
lbp{i} = extractLBPFeatures(polished{i},'CellSize',[32 32]);
    disp(['Extract LBP :   ' num2str(i) ]);
end;
for i = 1 : filesnumber(1,1)
    lbpfeature(i,:)=lbp{i};
    disp(['LBP To Matrix :   ' num2str(i) ]);
end;
    disp(['Working On Lasso For LBP (Please Wait) ...']);
lbpmain=lbpfeature;
% Labeling for lasso
clear lasso;clear B;clear Stats;clear ds;
label(1:160,1)=1;
label(161:320,1)=2;label(321:480,1)=3;label(481:640,1)=4;
label(641:800,1)=5;label(801:960,1)=6;label(961:1120,1)=7;
% clear lasso;
[B Stats] = lasso(lbpfeature,label, 'CV', 5);
disp(B(:,1:5))
disp(Stats)
%
lassoPlot(B, Stats, 'PlotType', 'CV')
ds.Lasso = B(:,Stats.IndexMinMSE);
disp(ds)
sizemfcc=size(lbpfeature);
temp=1;       
for i=1:sizemfcc(1,2)
if ds.Lasso(i)~=0
lasso(:,temp)=lbpfeature(:,i);
temp=temp+1;end;end;lbpfeature=lasso;
%% Extract HOG Features (just color)
for i = 1 : filesnumber(1,1)
    % The less cell size the more accuracy 
hog{i} = extractHOGFeatures(adjusted{i},'CellSize',[16 16]);
    disp(['Extract HOG :   ' num2str(i) ]);
end;
for i = 1 : filesnumber(1,1)
    hogfeature(i,:)=hog{i};
    disp(['HOG To Matrix :   ' num2str(i) ]);
end;
    disp(['Working On Lasso For HOG (Please Wait) ...']);
hogmain=hogfeature;
% Labeling for lasso
clear lasso;clear B;clear Stats;clear ds;
label(1:160,1)=1;
label(161:320,1)=2;label(321:480,1)=3;label(481:640,1)=4;
label(641:800,1)=5;label(801:960,1)=6;label(961:1120,1)=7;
% clear lasso;
[B Stats] = lasso(hogfeature,label, 'CV', 5);
disp(B(:,1:5))
disp(Stats)
%
lassoPlot(B, Stats, 'PlotType', 'CV')
ds.Lasso = B(:,Stats.IndexMinMSE);
disp(ds)
sizemfcc=size(hogfeature);
temp=1;       
for i=1:sizemfcc(1,2)
if ds.Lasso(i)~=0
lasso(:,temp)=hogfeature(:,i);
temp=temp+1;end;end;hogfeature=lasso;
%% Extract SURF Features (just color)
imset = imageSet('IKFDB SURF','recursive'); 
% Create a bag-of-features from the image database
bag = bagOfFeatures(imset,'VocabularySize',200,'PointSelection','Detector');
% Encode the images as new features
surf = encode(bag,imset);
%% Extract LPQ Features (just depth)
% Read the input images
path='IKFDB ClassLearner';fileinfo = dir(fullfile(path,'*.png'));
filesnumber=size(fileinfo);
for i = 1 : filesnumber(1,1)
images{i} = imread(fullfile(path,fileinfo(i).name));
    disp(['Loading image No :   ' num2str(i) ]);end;
% Contrast 
for i = 1 : filesnumber(1,1)
adjusted2{i}=imadjust(images{i}); disp(['Contrast Adjust :   ' num2str(i) ]);end;
% Resize 
for i = 1 : filesnumber(1,1)
resized2{i}=imresize(adjusted2{i}, [256 256]); disp(['Image Resized :   ' num2str(i) ]);end;
% LPQ
winsize=39;
for i = 1 : filesnumber(1,1)
tmp{i}=lpq(resized2{i},winsize);disp(['Extract LPQ :   ' num2str(i) ]);end;
for i = 1 : filesnumber(1,1)lpq(i,:)=tmp{i};end;
    
%% Extract Gabor Features (just depth)
for i = 1 : filesnumber(1,1)
gaborArray = gaborFilterBank(3,8,29,29);  % Generates the Gabor filter bank
featureVector{i} = gaborFeatures(resized2{i},gaborArray,16,16); 
disp(['Extracting Gabor Vector :   ' num2str(i) ]);
end;
for i = 1 : filesnumber(1,1)
    Gaborvector(i,:)=featureVector{i};
    disp(['To Matrix :   ' num2str(i) ]);end;
    disp(['Working On Lasso For Gabor (Please Wait) ...']);
%
clear lasso;clear B;clear Stats;clear ds;
[B Stats] = lasso(Gaborvector,label, 'CV', 5);
disp(B(:,1:5))
disp(Stats)
%
lassoPlot(B, Stats, 'PlotType', 'CV')
ds.Lasso = B(:,Stats.IndexMinMSE);
disp(ds)
sizemfcc=size(Gaborvector);temp=1;       
%
for i=1:sizemfcc(1,2)
if ds.Lasso(i)~=0
lasso(:,temp)=Gaborvector(:,i);temp=temp+1;end;end;
%
Gabor=lasso;
%% Labeling for Classification
clear test;
% Combining Feature Matrixes
test=[lbpfeature hogfeature surf lpq Gabor];
% Labels
sizefinal=size(test);
sizefinal=sizefinal(1,2);
test(1:160,sizefinal+1)=1;
test(161:320,sizefinal+1)=2;
test(321:480,sizefinal+1)=3;
test(481:640,sizefinal+1)=4;
test(641:800,sizefinal+1)=5;
test(801:960,sizefinal+1)=6;
test(961:1120,sizefinal+1)=7;
% Reading ready to classify feature matrix
clear ikfdb;clear lbl;clear sizeikfdb;
ikfdb=load('matlab.mat');
ikfdb=ikfdb.test;
classificationLearner

%% Shallow Neural Network 
% clear;
netdata=load('matlab.mat');
netdata=netdata.test;
% Labeling For Classification
network=netdata(:,1:end-1);
netlbl=netdata(:,end);
sizenet=size(network);
sizenet=sizenet(1,1);
for i=1 : sizenet
            if netlbl(i) == 1
               netlbl2(i,1)=1;
               netlbl2(i,2)=1; 
        elseif netlbl(i) == 3
               netlbl2(i,3)=1;
        elseif netlbl(i) == 4
               netlbl2(i,4)=1; 
        elseif netlbl(i) == 5
               netlbl2(i,5)=1; 
        elseif netlbl(i) == 6
               netlbl2(i,6)=1; 
        elseif netlbl(i) == 7
               netlbl2(i,7)=1; 
        end
end
% Changing data shape from rows to columns
network=network'; 
% Changing data shape from rows to columns
netlbl2=netlbl2'; 
% Defining input and target variables
inputs = network;
targets = netlbl2;
% Create a Pattern Recognition Network
hiddenLayerSize = 100;
net = patternnet(hiddenLayerSize);
% Set up Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
% Train the Network
% Polak-Ribiére Conjugate Gradient
net = feedforwardnet(20, 'traincgp');
%
[net,tr] = train(net,inputs,targets);
% Test the Network
outputs = net(inputs);
%
errors = gsubtract(targets,outputs);
%
performance = perform(net,targets,outputs)
% Polak-Ribiére Conjugate Gradient
figure, plottrainstate(tr)
% Plot Confusion Matrixes
figure, plotconfusion(targets,outputs);
title('Polak-Ribiére Conjugate Gradient');

%% CNN Deep Neural Network Algorithm (Train and Test)
%  clear;
% Load the deep sample data as an image datastore. 
deepDatasetPath = fullfile('Chap8deep');
imds = imageDatastore(deepDatasetPath, ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
% Divide the data into training and validation data sets
numTrainFiles = 400;
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');
% Define the convolutional neural network architecture.
layers = [
% Image Input Layer An imageInputLayer 
    imageInputLayer([128 128 1])
% Convolutional Layer 
convolution2dLayer(3,8,'Padding','same')
% Batch Normalization 
    batchNormalizationLayer
% ReLU Layer The batch
    reluLayer
% Max Pooling Layer  
    maxPooling2dLayer(3,'Stride',3)
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(3,'Stride',3)
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
% Fully Connected Layer  
    fullyConnectedLayer(7)
% Softmax Layer 
    softmaxLayer
% Classification Layer The final layer 
    classificationLayer];
% Specify the training options
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',30, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',15, ...
    'Verbose',false, ...
    'Plots','training-progress');
% Train the network 
net = trainNetwork(imdsTrain,layers,options);
% Predict the labels 
YPred = classify(net,imdsValidation);
YValidation = imdsValidation.Labels;
accuracy = sum(YPred == YValidation)/numel(YValidation)




