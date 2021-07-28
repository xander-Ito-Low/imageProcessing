function result = convolve(Image,kernel)

%rotate the kernal by 180 degrees (flip vertical and flip horizontal)
rotatedKernel = rot90(kernel,2);

%get the size of the kernel in their respecive dimensions:
kernelHeight = size(rotatedKernel,1);
kernelWidth = size (rotatedKernel,2);

%get half the size of the kernel
h = round (kernelHeight/2);
w = round (kernelWidth/2);

%get the original rows and columns before padding takes place
origRows = size(Image,1);
origCols = size (Image,2);

%pad the image with the utility fuction padding:
paddedImage = padding(Image,kernel);

rows = size(paddedImage,1);
cols = size(paddedImage,2);

%colour bands
bands = size(paddedImage,3);

%The image we want to obtain at the end with colour bands
result = zeros(origRows,origCols,bands);

%main convolution loop 
for i = 1:bands
    for j = h: rows-h+1
        for k = w:cols-w+1
            sum = 0;
            for l = 1: kernelHeight
                for m = 1: kernelWidth
                    sum = sum + rotateKernel(l,m)*image(i-h+l,j-w+m);
                end;
            end;
            result(j-h+1,k-w+1,i) = sum;
        end;
    end;
end;



