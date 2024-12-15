clear;
% Reading ready to classify feature matrix
kdeflbp=load('kdef lbp.mat');
kdeflbp=kdeflbp.lasso;
% Reading trained model
trainedModel=load('trainedModel.mat');
trainedModel=trainedModel.trainedModel; 
% Cross varidation (train: 70%, test: 30%)
% Data shuffles each time. So, the result is slightly different with any run
cv = cvpartition(size(kdeflbp,1),'HoldOut',0.3);
idx = cv.test;
% Separate to training and test data
dataTrain = kdeflbp(~idx,:);
dataTest  = kdeflbp(idx,:);
% Separating data from label in test data (removing label column)
tstdat=dataTest (:,1:end-1);
% Labels for calculating error
tstlbl=dataTest(:,end);
% Determining new test data classes
tstres = trainedModel.predictFcn(tstdat)
% Calculating final test error
err=[tstlbl tstres];
serr=size(err); serr=serr(1,1);
count=0;
for i=1 : serr
        if err(i,1) ~= err(i,2)
            count=count+1;
        end
end
Finalerr=100-((count*100)/serr)
disp(['Data shuffles each time. So, the result is slightly different with any run']);
disp(['The Test Accuracy is :   ' num2str(Finalerr) '%']);
% Converting classes names from number to real facial expressions for
% confusion matrix
for i=1 : serr
        if err(i,1) == 1
            lbl{i}='Joy';
        elseif err(i,1) == 2
               lbl{i}='Surprise'; 
        elseif err(i,1) == 3
               lbl{i}='Anger'; 
        elseif err(i,1) == 4
               lbl{i}='Disgust'; 
        end
end
for i=1 : serr
        if err(i,2) == 1
            lbl2{i}='Joy';
        elseif err(i,2) == 2
               lbl2{i}='Surprise'; 
        elseif err(i,2) == 3
               lbl2{i}='Anger'; 
        elseif err(i,2) == 4
               lbl2{i}='Disgust'; 
        end
end
% Plotting Confusion matrix
cm = confusionchart(lbl,lbl2,'RowSummary','row-normalized','ColumnSummary','column-normalized');
%Loss function (train and test)
model=trainedModel.ClassificationSVM;
Losstrain = loss(model,dataTrain(:,1:138),dataTrain(:,139))
Losstest = loss(model,dataTest(:,1:138),dataTest(:,139))
