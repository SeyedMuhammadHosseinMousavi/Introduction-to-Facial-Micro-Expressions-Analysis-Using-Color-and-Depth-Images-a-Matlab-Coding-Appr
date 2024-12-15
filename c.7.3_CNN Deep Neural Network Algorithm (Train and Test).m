% CNN Classification
clear;
% Load the deep sample data as an image datastore. imageDatastore automatically
% labels the images based on folder names and stores the data as an ImageDatastore object.
%  The class labels are sourced from the subfolder names.
deepDatasetPath = fullfile('Deep');
imds = imageDatastore(deepDatasetPath, ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
% Divide the data into training and validation data sets, so that each category in 
% the training set contains 40 images, and the validation set contains the remaining
% images from each label. splitEachLabel splits the datastore digitData into two new datastores,
% trainDigitData and valDigitData.
numTrainFiles = 40;
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');
% Define the convolutional neural network architecture.
layers = [
% Image Input Layer An imageInputLayer is where you specify the image size,
% which, in this case, is 200-by-128-by-1. These numbers correspond to the height,
% width, and the channel size. The digit data consists of grayscale images, so 
% the channel size (color channel) is 1. For a color image, the channel size is 3
    imageInputLayer([200 128 1])
% Convolutional Layer In the convolutional layer, the first argument is filterSize, 
% which is the height and width of the filters the training function uses while 
% scanning along the images. In this example, the number 3 indicates that the filter
% size is 3-by-3. You can specify different sizes for the height and width of the 
% filter. The second argument is the number of filters, numFilters, which is the 
% number of neurons that connect to the same region of the input. This parameter 
% determines the number of feature maps. Use the 'Padding' name-value pair to add 
% padding to the input feature map. For a convolutional layer with a default stride 
% of 1, 'same' padding ensures that the spatial output size is the same as the input size.
    convolution2dLayer(3,8,'Padding','same')
% Batch Normalization Layer Batch normalization layers normalize the activations 
% and gradients propagating through a network, making network training an easier
% optimization problem. Use batch normalization layers between convolutional layers
% and nonlinearities, such as ReLU layers, to speed up network training and reduce
% the sensitivity to network initialization.
    batchNormalizationLayer
% ReLU Layer The batch normalization layer is followed by a nonlinear activation 
% function. The most common activation function is the rectified linear unit (ReLU).
    reluLayer
% Max Pooling Layer Convolutional layers (with activation functions) are sometimes 
% followed by a down-sampling operation that reduces the spatial size of the feature
% map and removes redundant spatial information. Down-sampling makes it possible to
% increase the number of filters in deeper convolutional layers without increasing 
% the required amount of computation per layer. One way of down-sampling is using a
% max pooling, which you create using maxPooling2dLayer. The max pooling layer 
% returns the maximum values of rectangular regions of inputs, specified by the
% first argument, poolSize. In this example, the size of the rectangular region is [2,2].
    maxPooling2dLayer(2,'Stride',2)
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2)
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
% Fully Connected Layer The convolutional and down-sampling layers are followed by 
% one or more fully connected layers. As its name suggests, a fully connected layer
% is a layer in which the neurons connect to all the neurons in the preceding layer.
% This layer combines all the features learned by the previous layers across the
% image to identify the larger patterns. The last fully connected layer combines 
% the features to classify the images. Therefore, the OutputSize parameter in the 
% last fully connected layer is equal to the number of classes in the target data.
% In this example, the output size is 5, corresponding to the 5 classes.
    fullyConnectedLayer(5)
% Softmax Layer The softmax activation function normalizes the output of the fully
% connected layer. The output of the softmax layer consists of positive numbers that
% sum to one, which can then be used as classification probabilities by the
% classification layer.
    softmaxLayer
% Classification Layer The final layer is the classification layer. This layer uses
% the probabilities returned by the softmax activation function for each input to
% assign the input to one of the mutually exclusive classes and compute the loss. 
    classificationLayer];
% After defining the network structure, specify the training options. Train the 
% network using stochastic gradient descent with momentum (SGDM) with an initial 
% learning rate of 0.01. Set the maximum number of epochs to 25. An epoch is a full
% training cycle on the entire training data set. Monitor the network accuracy 
% during training by specifying validation data and validation frequency. Shuffle 
% the data every epoch. The software trains the network on the training data and
% calculates the accuracy on the validation data at regular intervals during
% training. The validation data is not used to update the network weights. Turn on
% the training progress plot, and turn off the command window output.
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',25, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress');
% Train the network using the architecture defined by layers, the training data, 
% and the training options.The training progress plot shows the mini-batch loss and 
% accuracy and the validation loss and accuracy. 
net = trainNetwork(imdsTrain,layers,options);
% Predict the labels of the validation data using the trained network, and 
% calculate the final validation accuracy. Accuracy is the fraction of labels
% that the network predicts correctly.
YPred = classify(net,imdsValidation);
YValidation = imdsValidation.Labels;
accuracy = sum(YPred == YValidation)/numel(YValidation)

