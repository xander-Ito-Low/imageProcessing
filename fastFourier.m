image = im2double(imread('cameraman.tif'));
kernel = ones(5) / 25;
filtered = fast(image, kernel); 
%I rotate my matrix therefore to get SSD of 0 use 'conv'
reference = imfilter(image, kernel, 'replicate','conv'); 
difference = 0.5 + 10 * (filtered - reference); 
ssd = sum((filtered(:) - reference(:)) .^ 2);
subplot(131); imshow(filtered); title('Fast fourier with a kernel 5x5');
subplot(132); imshow(reference); title('Reference result');
subplot(133); imshow(difference); title(sprintf('Difference (SSD=%.1f)',ssd));

 
 start = tic();
 extended_convolution(image,kernel);
 t = toc(start);
 X = ['A kernel of size ',num2str(5),' took ',num2str(t),' seconds with extended convolution'];
 disp(X);
 
 
 start = tic();
 fast(image,kernel);
 t = toc(start);
 X = ['A kernel of size ',num2str(5),' took ',num2str(t),' seconds with fast fourier transform'];
 disp(X);
 
 
 kernel = ones(7) / 49;
 start = tic();
 extended_convolution(image,kernel);
 t= toc(start);
 X = ['A kernel of size ',num2str(7),' took ',num2str(t),' seconds with extended convolution'];
 disp(X);
 
 start = tic();
 fast(image,kernel);
 t = toc(start);
 X = ['A kernel of size ',num2str(7),' took ',num2str(t),' seconds with fast fourier transform'];
 disp(X);
  
kernel = ones(25) /625;
 start = tic();
 extended_convolution(image,kernel);
 t = toc(start);
 X = ['A kernel of size ',num2str(25),' took ',num2str(t),' seconds with extended convolution'];
 disp(X);
 
 start = tic();
 fast(image,kernel);
 t = toc(start);
 X = ['A kernel of size ',num2str(25),' took ',num2str(t),' seconds with fast fourier transform'];
 disp(X);
 
function filtered = fast(matrix,kernel)

kernelRows = size(kernel,1);
kernelCols = size(kernel,2);

padrows = (kernelRows-1)/2;
padcolumns = (kernelCols-1)/2;
originalSize = size(matrix,1);

matrix = padThis(matrix,kernel);

rowSize = size(matrix,1);

padTop = floor((rowSize-kernelRows)/2);
padBottom = ceil((rowSize-kernelRows)/2);
padLeft = floor((rowSize-kernelCols)/2);
padRight = ceil((rowSize-kernelCols)/2);

kernel = padarray(kernel,[padTop,padLeft],0,'pre');
kernel = padarray(kernel,[padBottom,padRight],0,'post');

filteredPad = fftshift(ifft2(fft2(matrix) .* fft2(kernel)));
filtered = zeros(originalSize);

for i = padrows:size(matrix)-padrows-1
    for j = padcolumns:size(matrix,1)-padcolumns-1
        filtered(i-padrows+1,j-padcolumns+1)=filteredPad(i,j);
    end
end

end