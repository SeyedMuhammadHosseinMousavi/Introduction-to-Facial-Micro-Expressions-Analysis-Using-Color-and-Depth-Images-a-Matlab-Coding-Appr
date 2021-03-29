% PCA feature selection
clear;
feature = load('hogfeature.mat');
hogfeature=feature.hogfeature;
[coeff,score,latent] = pca(hogfeature)
classificationLearner
