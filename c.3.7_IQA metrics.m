clc;    % Clearing the Command Window
clear;  % Clearing the Workspace
Depth= imread('Exp_Nut_Depth.png'); % Reading depth image
Depth = imresize(Depth, [256 256]); % Resizing depth image to 256*256 dimensions
noisy = imnoise(Depth,'gaussian', 0.02); % Adding gaussian noise
%%Full refrence
% Peak Signal to Noise Ratio (PSNR) 
[peaksnr, snr] = psnr(noisy, Depth);
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);
% Mean Square Error (MSE) 
mse = immse(noisy, Depth);
fprintf('\n The mean-squared error is %0.4f\n', mse);
% Structural similarity (SSIM) index
[ssimval,ssimmap] = ssim(noisy, Depth);
fprintf('\n The SSIM error is %0.4f\n', ssimval);
%% No refrence
% Blind/Referenceless Image Spatial Quality Evaluator (BRISQUE)
brisqueI = brisque(Depth);
fprintf('BRISQUE score for original image is %0.4f.\n',brisqueI)
brisqueInoise = brisque(noisy);
fprintf('BRISQUE score for noisy image is %0.4f.\n',brisqueInoise)
% Naturalness Image Quality Evaluator (NIQE)
niqeI = niqe(Depth);
fprintf('NIQE score for original image is %0.4f.\n',niqeI)
niqeInoise = niqe(noisy);
fprintf('NIQE score for noisy image is %0.4f.\n',niqeInoise)
% Perception based Image Quality Evaluator (PIQE)
piqeI = piqe(Depth);
fprintf('PIQE score for original image is %0.4f.\n',piqeI)
piqeInoise = piqe(noisy);
fprintf('PIQE score for noisy image is %0.4f.\n',piqeInoise)
