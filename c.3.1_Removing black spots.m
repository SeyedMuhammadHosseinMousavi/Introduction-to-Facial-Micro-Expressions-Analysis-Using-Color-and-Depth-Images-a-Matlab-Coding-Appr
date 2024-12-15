clc;    % Clearing the Command Window
clear;  % Clearing the Workspace
Depth= imread('Dpre.png'); % Reading depth image
DepthTemp=Depth; % Making a clone from Depth image
[d1,d2] = size(DepthTemp); % Extracting numbers of rows and columns of the image
for i=1:d1 % Loop for row navigation
    for j=1:d2 % Loop for column navigation
    if DepthTemp(i,j)<30 % Conditional statment for black spots threshold
        DepthTemp(i,j)=70; % Replacing value for black spots
    else
        DepthTemp(i,j)=DepthTemp(i,j); % Do not effect any change
    end
    end
end
subplot(1,2,1)
imshow(Depth);title('Original');
subplot(1,2,2);
imshow(DepthTemp);title('Modified');