image = im2double(imread('cameraman.tif'));
kernel = ones(5) / 25;
filtered = extended_convolution(image, kernel); 
%I rotate my matrix therefore to get SSD of 0 use 'conv'
reference = imfilter(image, kernel, 'replicate','conv'); 
difference = 0.5 + 10 * (filtered - reference); 
ssd = sum((filtered(:) - reference(:)) .^ 2);
subplot(2,3,1); imshow(filtered); title('Extended convolution');
subplot(2,3,2); imshow(reference); title('Reference result');
subplot(2,3,3); imshow(difference); title(sprintf('Difference (SSD=%.1f)',ssd));
% kernel = [-1 0 1];
% filtered2 = extended_convolution(image, kernel); 
% reference = imfilter(image, kernel, 'replicate','conv'); 
% difference = 0.5 + 10 * (filtered2 - reference); 
% ssd = sum((filtered2(:) - reference(:)) .^ 2);
% subplot(2,3,4); imshow(filtered2); title('Extended convolution with -1 0 1');
% subplot(2,3,5); imshow(reference); title('Reference result');
% subplot(2,3,6); imshow(difference); title(sprintf('Difference (SSD=%.1f)',ssd));



