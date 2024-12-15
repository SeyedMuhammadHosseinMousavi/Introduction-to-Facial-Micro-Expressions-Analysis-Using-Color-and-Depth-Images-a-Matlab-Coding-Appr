clear;
% Load image data
imset = imageSet('VAP/depth','recursive'); 
% Extracting SURF features
% Create a bag-of-features from the image database
bag = bagOfFeatures(imset,'VocabularySize',200,...
    'PointSelection','Detector');
% Encode the images as new features
SURF = encode(bag,imset);


