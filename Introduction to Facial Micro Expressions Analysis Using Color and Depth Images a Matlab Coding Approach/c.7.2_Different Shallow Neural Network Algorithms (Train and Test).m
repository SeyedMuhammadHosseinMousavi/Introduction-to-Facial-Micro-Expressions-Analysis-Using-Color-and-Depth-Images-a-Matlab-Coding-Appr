clear;
% Inputs
lpqdata=load('lpqdata.mat');
lpqdata=lpqdata.lpqdata;
lpqdata=lpqdata'; % changing data shape from rows to columns
% Labels (targets)
lpqlbl2=load('lpqlbl2.mat');
lpqlbl2=lpqlbl2.lpqlbl2;
lpqlbl2=lpqlbl2'; % changing data shape from rows to columns
% Defining input and target variables
inputs = lpqdata;
targets = lpqlbl2;
% Create a Pattern Recognition Network
hiddenLayerSize = 14;
net1 = patternnet(hiddenLayerSize);
net2 = patternnet(hiddenLayerSize);
net3 = patternnet(hiddenLayerSize);
net4 = patternnet(hiddenLayerSize);
net5 = patternnet(hiddenLayerSize);
% Set up Division of Data for Training, Validation, Testing
net1.divideParam.trainRatio = 70/100;
net1.divideParam.valRatio = 15/100;
net1.divideParam.testRatio = 15/100;
net2.divideParam.trainRatio = 70/100;
net2.divideParam.valRatio = 15/100;
net2.divideParam.testRatio = 15/100;
net3.divideParam.trainRatio = 70/100;
net3.divideParam.valRatio = 15/100;
net3.divideParam.testRatio = 15/100;
net4.divideParam.trainRatio = 70/100;
net4.divideParam.valRatio = 15/100;
net4.divideParam.testRatio = 15/100;
net5.divideParam.trainRatio = 70/100;
net5.divideParam.valRatio = 15/100;
net5.divideParam.testRatio = 15/100;
%% Train the Network
% Levenberg-Marquardt
net1 = feedforwardnet(11, 'trainlm');
% One Step Secant
net2 = feedforwardnet(10, 'trainoss');
% Gradient Descent
net3 = feedforwardnet(11, 'traingd');
% Scaled Conjugate Gradient
net4 = feedforwardnet(12, 'trainscg');
% Resilient Backpropagation
net5 = feedforwardnet(19, 'trainrp');
%
[net1,tr1] = train(net1,inputs,targets);
[net2,tr2] = train(net2,inputs,targets);
[net3,tr3] = train(net3,inputs,targets);
[net4,tr4] = train(net4,inputs,targets);
[net5,tr5] = train(net5,inputs,targets);
% Test the Network
outputs1 = net1(inputs);
outputs2 = net2(inputs);
outputs3 = net3(inputs);
outputs4 = net4(inputs);
outputs5 = net5(inputs);
errors1 = gsubtract(targets,outputs1);
errors2 = gsubtract(targets,outputs2);
errors3 = gsubtract(targets,outputs3);
errors4 = gsubtract(targets,outputs4);
errors5 = gsubtract(targets,outputs5);
performance1 = perform(net1,targets,outputs1)
performance2 = perform(net2,targets,outputs2)
performance3 = perform(net3,targets,outputs3)
performance4 = perform(net4,targets,outputs4)
performance5 = perform(net5,targets,outputs5)
% View the Network
view(net1)
view(net2)
view(net3)
view(net4)
view(net5)
% Plot Training States
%Levenberg-Marquardt
figure, plottrainstate(tr1)
% One Step Secant
figure, plottrainstate(tr2)
% Gradient Descent
figure, plottrainstate(tr3)
% Scaled Conjugate Gradient
figure, plottrainstate(tr4)
% Resilient Backpropagation
figure, plottrainstate(tr5)
%% Plot Confusion Matrixes
figure, plotconfusion(targets,outputs1); title('Levenberg-Marquardt');
figure, plotconfusion(targets,outputs2);title('One Step Secant');
figure, plotconfusion(targets,outputs3);title('Gradient Descent');
figure, plotconfusion(targets,outputs4);title('Scaled Conjugate Gradient');
figure, plotconfusion(targets,outputs5);title('Resilient Backpropagation');
% figure, plotperform(tr1)
% figure, ploterrhist(errors1)