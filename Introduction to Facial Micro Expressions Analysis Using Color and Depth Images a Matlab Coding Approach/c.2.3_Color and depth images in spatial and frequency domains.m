clc;    % Clearing the Command Window
clear;  % Clearing the Workspace
RGB=imread('Exp_Sur_Color.jpg'); % Reading color image
RGB=rgb2gray(RGB); % Converting color image to gray 
Depth= imread('Exp_Sur_Depth.png'); % Reading depth image
FreqColor=fft2(RGB); % Two-dimensional Fourier transform of matrix
FreqDepth=fft2(Depth); % Two-dimensional Fourier transform of matrix
subplot(2,2,1)
imshow(log(1+abs(FreqColor)),[]); % Color image in frequency domain
title('Color in frequency domain');
subplot(2,2,2)
imshow(log(1+abs(FreqDepth)),[]); % Depth image in frequency domain
title('Depth in frequency domain');
subplot(2,2,3)
imshow(RGB); % Color image in spatial domain
title('Color in spatial domain');
subplot(2,2,4)
imshow(Depth); % Depth image in spatial domain
title('Depth in spatial domain');