
image = im2double(imread('cameraman.tif'));
kernel = ones(5) / 25;
filtered = basic_convolution(image, kernel); 
subplot(1,3,1); 
imshow(image); 
title('Input image'); 
subplot(1,3,2); 
imshow(filtered); 
title('Filtered image');
kernel = [-1 0 1];
filtered2 = basic_convolution(image, kernel);
subplot(1,3,3); 
imshow(filtered2); 
title('Filtered image with -1 0 1'); 




function result = basic_convolution(image,kernel)

%finding sizes of the rows and columns for the padded img

%I rotate my kernel by 180 degrees so dimensions dont change hence I just
%measure rows and columns as they are
h = round(size(kernel,1)/2);
w = round(size(kernel,2)/2);
unalteredrows = size(image,1);
unalteredcols = size(image,2);

Imgrows = size(image,1);
Imgcols = size(image,2);

result = zeros(unalteredrows,unalteredcols);


%rotate the kernal by 180 degrees
rotateKernel = rot90(kernel,2);

for i = h:Imgrows-h+1
    for j = w:Imgcols-w+1
        sum = 0;
        for k = 1:size(rotateKernel,1)
            for l = 1:size(rotateKernel,2)
                sum = sum + (rotateKernel(k,l)*image(i-h+k,j-w+l)); 
      
            end
        end
        result(i-h+1,j-w+1) = sum;
    end
end
end
