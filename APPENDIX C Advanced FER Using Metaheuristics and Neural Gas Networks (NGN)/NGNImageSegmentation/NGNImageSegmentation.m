%% Neural Gas Network (NGN) Image Segmentation and Quantization
% Developed by : Seyed Muhammad Hossein Mousavi - June 2023
% Related Paper:
% @article{mousavi2023neural,
%   title={Neural Gas Network Image Features and Segmentation for Brain Tumor Detection Using Magnetic Resonance Imaging Data},
%   author={Mousavi, S},
%   journal={arXiv preprint arXiv:2301.12176},
%   year={2023}
% }
%----------------------------------------------------------------------
clc;
clear;
close all;

%% Load Image
Org=imread('tst5.jpg');
X = rgb2gray(Org);
X=double(X);
img=X;
X=X(:)';

%% Neural Gas Network (NGN) Parameters

ParVal.N = 8; % Number of Segments
ParVal.MaxIt = 100; % Number of runs

ParVal.tmax = 100000;

ParVal.epsilon_initial = 0.3;
ParVal.epsilon_final = 0.02;
ParVal.lambda_initial = 2;
ParVal.lambda_final = 0.1;
ParVal.T_initial = 5;
ParVal.T_final = 10;

%% Training Neural Gas Network
NGNnetwok = GasNN(X, ParVal);

%% Vector to image and plot
Weight=sum(round(rescale(NGNnetwok.w,1,ParVal.N)));
Weight=round(rescale(Weight,1,ParVal.N));
indexed=reshape(Weight(1,:),size(img));
segmented = label2rgb(indexed); 
% Plot Res
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,3,1)
imshow(Org,[]); title('Original');
ax = gca; 
ax.FontSize = 14; 
subplot(1,3,2)
imshow(segmented);
title(['Segmented in [' num2str(ParVal.N) '] Segments']);
ax = gca; 
ax.FontSize = 14; 
subplot(1,3,3)
imshow(indexed,[]);
title(['Quantized in [' num2str(ParVal.N) '] Thresholds']);
ax = gca; 
ax.FontSize = 14; 


