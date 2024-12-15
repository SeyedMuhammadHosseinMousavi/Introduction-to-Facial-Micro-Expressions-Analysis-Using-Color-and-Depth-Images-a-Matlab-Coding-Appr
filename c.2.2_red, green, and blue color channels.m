% Extract the individual red, green, and blue color channels.
clc;    % Clearing the Command Window
clear;  % Clearing the Workspace
RGB=imread('Exp_Sur_Color.jpg'); % Reading color image
Depth= imread('Exp_Sur_Depth.png'); % Reading depth image
colorredChannel = RGB(:, :, 1); % Separating red channel out of color data
colorgreenChannel = RGB(:, :, 2); % Separating green channel out of color data
colorblueChannel = RGB(:, :, 3); % Separating blue channel out of color data
figure('Name','Color and Depth','units','normalized','outerposition',[0 0 1 1]) % Full screen plot
% Subplot helps to have multiple outputs at the same time
subplot(2,3,1)
subimage(RGB);title('RGB') % Plotting color image
subplot(2,3,2)
subimage(colorredChannel);title('Red') % Plotting color image red channel
subplot(2,3,3)
subimage(colorgreenChannel);title('Green') % Plotting color image green channel
subplot(2,3,4)
subimage(colorblueChannel);title('Blue') % Plotting color image blue channel
subplot(2,3,5)
subimage(Depth);title('Depth') % Plotting depth image
