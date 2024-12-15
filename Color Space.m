
clear;

RGB=imread('1.2.jpg');
YIQ = rgb2ntsc(RGB);
YCBCR = rgb2ycbcr(RGB);


% subplot(2,3,1)
% subimage(YIQ(:,:,1));title('Y - Luma');
% subplot(2,3,2)
% subimage(YIQ(:,:,2));title('I - In-phase');
% subplot(2,3,3)
% subimage(YIQ(:,:,3));title('Q - Quadrature');
% subplot(2,3,4)
% subimage(YCBCR(:,:,1));title('Y - Luma');
% subplot(2,3,5)
% subimage(YCBCR(:,:,2));title('Y - Chrominance Blue');
% subplot(2,3,6)
% subimage(YCBCR(:,:,3));title('Y - Chrominance Red');

montage({YIQ(:,:,1), YIQ(:,:,2),YIQ(:,:,3)},'Size', [3 1])
figure;
montage({YCBCR(:,:,1),YCBCR(:,:,2),YCBCR(:,:,3)},'Size', [3 1])
