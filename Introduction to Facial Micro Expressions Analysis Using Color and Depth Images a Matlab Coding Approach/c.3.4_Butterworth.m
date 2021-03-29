ima = imread('KDEF_Sad.jpg');
ima = rgb2gray(ima);
% Low pass
filtered_image = butterworthbpf(ima,2,10,2);
title ('Frequency domain low-pass');
figure;
% High pass
filtered_image = butterworthbpf(ima,3,300,5);
title ('Frequency domain low-pass');
