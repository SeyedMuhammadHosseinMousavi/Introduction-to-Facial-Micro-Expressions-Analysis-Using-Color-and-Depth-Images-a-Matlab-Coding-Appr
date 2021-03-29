%% Spatial low and high passes
clc;    % Clearing the Command Window
clear;  % Clearing the Workspace
RGB=imread('KDEF_Sad.jpg'); % Reading color image
MRGB=rgb2gray(RGB); % Converting color image to gray 
MRGB=imadjust(MRGB); %Contrast adjustment
highpass = imsharpen(MRGB,'Radius',2,'Amount',1);% Sharpening image 
weinlow = wiener2(MRGB,[5 5]);% Remove Noise By Adaptive Filtering
% Filter the image with a Gaussian filter with standard deviation of 2.
gaulow = imgaussfilt(MRGB,2);% 2-D Gaussian filtering of images
%Calculate Gradient Magnitude and Gradient Direction
[Gmag, Gdir] = imgradient(gaulow,'prewitt');
std = stdfilt(MRGB); % Local standard deviation of image
subplot(2,4,1);subimage(RGB);title('Original');
subplot(2,4,2);subimage(MRGB);title('Gray-Adjusted');
subplot(2,4,3);subimage(highpass);title('Sharpened');
subplot(2,4,4);subimage(weinlow);title('Adaptive Filtering');
subplot(2,4,5);subimage(gaulow);title('Gaussian filtering');
subplot(2,4,6);imshow(Gmag,[]);title('Gradient Magnitude');
subplot(2,4,7);imshow(Gdir,[]);title('Gradient Direction');
subplot(2,4,8);imshow(std,[]);title('Local standard deviation');