clc;    % Clearing the Command Window
clear;  % Clearing the Workspace
RGB=imread('Cpre.jpg'); % Reading color image
RGB=rgb2gray(RGB); % Converting color image to gray 
Depth= imread('Dpre.png'); % Reading depth image
RGB = imresize(RGB, [128 128]); % Resizing color image to 128*128 dimensions
Depth = imresize(Depth, [128 128]); % Resizing depth image to 128*128 dimensions
Cbw=im2bw(RGB); % Black and white version of color image
Dbw=im2bw(Depth); % Black and white version of depth image
Cadj=imadjust(RGB); % Contrast adjustment of color image
Dadj=imadjust(Depth); % Contrast adjustment of depth image
Chist = histeq(RGB); % Histogram equalization of color image
Dhist = histeq(Depth); % Histogram equalization of depth image
Cmed = medfilt2(RGB,[2 2]); % Median filter for color image
Dmed = medfilt2(Depth,[2 2]); % Median filter for depth image
Csha = imsharpen(RGB,'Radius',5,'Amount',0.9); % Sharpening the edges of color image
Dsha = imsharpen(Depth,'Radius',5,'Amount',0.9); % Sharpening the edges of depth image
subplot(2,3,1);subimage(RGB);title('Original-Gray');
subplot(2,3,2);subimage(Cbw);title('BW');
subplot(2,3,3);subimage(Cadj);title('Contrast Adjusted');
subplot(2,3,4);subimage(Chist);title('Histogram Equalization');
subplot(2,3,5);subimage(Cmed);title('Median Filter');
subplot(2,3,6);subimage(Csha);title('Sharpening');
figure; % New figure for depth data
subplot(2,3,1);subimage(Depth);title('Original-Gray');
subplot(2,3,2);subimage(Dbw);title('BW');
subplot(2,3,3);subimage(Dadj);title('Contrast Adjusted');
subplot(2,3,4);subimage(Dhist);title('Histogram Equalization');
subplot(2,3,5);subimage(Dmed);title('Median Filter');
subplot(2,3,6);subimage(Dsha);title('Sharpening');
