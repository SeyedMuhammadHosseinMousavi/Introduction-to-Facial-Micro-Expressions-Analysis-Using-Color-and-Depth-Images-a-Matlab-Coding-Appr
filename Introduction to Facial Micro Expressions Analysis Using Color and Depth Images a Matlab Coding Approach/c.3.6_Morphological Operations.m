clc;    % Clearing the Command Window
clear;  % Clearing the Workspace
RGB=imread('Exp_Nut_Color.jpg'); % Reading color image
RGB=imadjust(rgb2gray(RGB)); % Converting color image to gray 
Depth= imread('Exp_Nut_Depth.png'); % Reading depth image
RGB = imresize(RGB, [256 256]); % Resizing color image to 256*256 dimensions
Depth = imresize(Depth, [256 256]); % Resizing depth image to 256*256 dimensions
se1 = strel('disk',10);% Morphological structuring element
se2 = strel('disk',100);% Morphological structuring element
se = strel('disk',3);% Morphological structuring element
dilated = imdilate(RGB,se);ddilated = imdilate(Depth,se); % Dilate operator
eroded = imerode(RGB,se);deroded = imerode(Depth,se); % Erode operator
fill = imfill(RGB);dfill = imfill(Depth); % Fill holes
closing = imclose(RGB,se);dclosing = imclose(Depth,se); % Closing operator
opening = imopen(RGB,se);dopening = imopen(Depth,se); % Opening operator
tophat = imtophat(RGB,se1);dtophat = imtophat(Depth,se2); % Top-hat filtering
bothat = imbothat(RGB,se1);dbothat = imbothat(Depth,se2); % Bottom-hat filtering
subplot(2,4,1);subimage(RGB);title('Original Color');
subplot(2,4,2);subimage(dilated);title('Dilation');
subplot(2,4,3);subimage(eroded);title('Erosion');
subplot(2,4,4);subimage(fill);title('Filling');
subplot(2,4,5);subimage(closing);title('Closing');
subplot(2,4,6);subimage(opening);title('Opening');
subplot(2,4,7);subimage(tophat);title('Top hat');
subplot(2,4,8);subimage(bothat);title('Bottom hat');
figure; % Depth image plots
subplot(2,4,1);subimage(Depth);title('Original Depth');
subplot(2,4,2);subimage(ddilated);title('Dilation');
subplot(2,4,3);subimage(deroded);title('Erosion');
subplot(2,4,4);subimage(dfill);title('Filling');
subplot(2,4,5);subimage(dclosing);title('Closing');
subplot(2,4,6);subimage(dopening);title('Opening');
subplot(2,4,7);subimage(dtophat);title('Top hat');
subplot(2,4,8);subimage(dbothat);title('Bottom hat');



