clc;    % Clearing the Command Window
clear;  % Clearing the Workspace
cat= imread ('cat.jpg');    %Reading Input Image
imshow(cat);    % Showing the Image
title('The Cat')   % Plot Title
xlabel('X Axis')    % X Axis Title
ylabel('Y Axis')    % Y Axis Title
figure; % Creating Another Plot Windows
subimage (cat); % Showing Image with Dimensions
