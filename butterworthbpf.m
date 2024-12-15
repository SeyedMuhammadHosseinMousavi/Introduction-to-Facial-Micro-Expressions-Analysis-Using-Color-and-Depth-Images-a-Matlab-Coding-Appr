function filtered_image = butterworthbpf(I,d0,d1,n)
% Butterworth Bandpass Filter
%   I = The input grey scale image
%   d0 = Lower cut off frequency
%   d1 = Higher cut off frequency
%   n = order of the filter
% The function makes use of the simple principle that a bandpass filter
% can be obtained by multiplying a lowpass filter with a high pass filter
% where the lowpass filter has a higher cut off frequency than the high pass filter.
f = double(I);
[nx ny] = size(f);
f = uint8(f);
fftI = fft2(f,2*nx-1,2*ny-1);
fftI = fftshift(fftI);
 
subplot(1,4,1)
imshow(f,[]);
title('Original Image')
subplot(1,4,2)
imshow(log(1+abs(fftI)),[]); 
title('Image in Fourier Domain')
% Initialize filter.
filter1 = ones(2*nx-1,2*ny-1);
filter2 = ones(2*nx-1,2*ny-1);
filter3 = ones(2*nx-1,2*ny-1);
 
for i = 1:2*nx-1
    for j =1:2*ny-1
        dist = ((i-(nx+1))^2 + (j-(ny+1))^2)^.5;
        % Create Butterworth filter.
        filter1(i,j)= 1/(1 + (dist/d1)^(2*n));
        filter2(i,j) = 1/(1 + (dist/d0)^(2*n));
        filter3(i,j)= 1.0 - filter2(i,j);
        filter3(i,j) = filter1(i,j).*filter3(i,j);
    end
end
% Update image with passed frequencies.
filtered_image = fftI + filter3.*fftI;
 
subplot(1,4,3)
imshow(log(1+abs(filter3)),[]); 
title('Filter Image')
filtered_image = ifftshift(filtered_image);
filtered_image = ifft2(filtered_image,2*nx-1,2*ny-1);
filtered_image = real(filtered_image(1:nx,1:ny));
filtered_image = uint8(filtered_image);
 
subplot(1,4,4)
imshow(filtered_image,[])
title('Filtered Image')

