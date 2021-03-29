clc;    % Clearing the Command Window
clear;  % Clearing the Workspace
RGB=imread('Exp_Nut_Color.jpg'); % Reading color image
RGB=imadjust(rgb2gray(RGB)); % Converting color image to gray 
Depth= imread('Exp_Nut_Depth.png'); % Reading depth image
RGB = imresize(RGB, [256 256]); % Resizing color image to 256*256 dimensions
Depth = imresize(Depth, [256 256]); % Resizing depth image to 256*256 dimensions
Sob = edge(RGB,'Sobel');SobD = edge(Depth,'Sobel');
Pre = edge(RGB,'Prewitt');PreD = edge(Depth,'Prewitt');
Rob = edge(RGB,'Roberts');RobD = edge(Depth,'Roberts');
Log = edge(RGB,'log');LogD = edge(Depth,'log');
Zer = edge(RGB,'zerocross');ZerD = edge(Depth,'zerocross');
Can = edge(RGB,'Canny');CanD = edge(Depth,'Canny');
App = edge(RGB,'approxcanny');AppD = edge(Depth,'approxcanny');
subplot(2,4,1);subimage(RGB);title('Original Color');
subplot(2,4,2);subimage(Sob);title('Sobel');
subplot(2,4,3);subimage(Pre);title('Prewitt');
subplot(2,4,4);subimage(Rob);title('Roberts');
subplot(2,4,5);subimage(Log);title('log');
subplot(2,4,6);subimage(Zer);title('zerocross');
subplot(2,4,7);subimage(Can);title('Canny');
subplot(2,4,8);subimage(App);title('approxcanny');
figure;
subplot(2,4,1);subimage(Depth);title('Original Depth');
subplot(2,4,2);subimage(SobD);title('Sobel');
subplot(2,4,3);subimage(PreD);title('Prewitt');
subplot(2,4,4);subimage(RobD);title('Roberts');
subplot(2,4,5);subimage(LogD);title('log');
subplot(2,4,6);subimage(ZerD);title('zerocross');
subplot(2,4,7);subimage(CanD);title('Canny');
subplot(2,4,8);subimage(AppD);title('approxcanny');