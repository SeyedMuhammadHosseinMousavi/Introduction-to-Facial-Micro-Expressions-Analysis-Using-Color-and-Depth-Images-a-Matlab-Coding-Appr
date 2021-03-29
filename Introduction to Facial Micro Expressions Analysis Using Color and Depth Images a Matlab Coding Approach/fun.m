function [pic,pica]=fun(pic) % Function "fun" with one input and two outputs
pic=rgb2gray(pic); % Gray image
pics = imsharpen(pic,'Radius',5,'Amount',0.5); % Sharpened image
picw = medfilt2(pics,[5 5]); % Median filter
pica = imadjust(picw); % Contrast adjusted
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,4,1),imshow(pic);title('Original');
subplot(1,4,2),imshow(pics);title('Sharped');
subplot(1,4,3),imshow(picw);title('Median Filtered');
subplot(1,4,4),imshow(pica);title('Contrast Adjusted');
end
