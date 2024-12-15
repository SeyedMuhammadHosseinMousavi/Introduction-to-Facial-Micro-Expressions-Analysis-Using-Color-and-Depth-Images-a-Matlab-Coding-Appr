clc;    % Clearing the Command Window
clear;  % Clearing the Workspace
Depth= imread('Exp_Hap_Depth.png'); % Reading depth image
Gau = imnoise(Depth,'gaussian'); % Adding gaussian noise
SP = imnoise(Depth,'salt & pepper', 0.1); % Adding impulse noise
Poi = imnoise(Depth,'poisson'); % Adding Poisson noise
Spe = imnoise(Depth,'speckle'); % Adding speckle noise
SPmed = imadjust(medfilt2(SP,[3 3])); % Contrast adjustment for impulse polluted image
subplot(2,3,1);imshow(Depth); title ('Original');
subplot(2,3,2);imshow(Gau); title ('Gaussian noise');
subplot(2,3,3);imshow(SP); title ('Salt & pepper noise');
subplot(2,3,4);imshow(Poi); title ('Poisson noise');
subplot(2,3,5);imshow(Spe); title ('Speckle noise');
subplot(2,3,6);imshow(SPmed); title ('Removing S&P noise');
figure;
subplot(2,3,1);imhist(Depth); title ('Original');
subplot(2,3,2);imhist(Gau); title ('Gaussian noise');
subplot(2,3,3);imhist(SP,256); title ('Salt & pepper noise');
subplot(2,3,4);imhist(Poi); title ('Poisson noise');
subplot(2,3,5);imhist(Spe); title ('Speckle noise');
subplot(2,3,6);imhist(SPmed,256); title ('Removing S&P noise');
