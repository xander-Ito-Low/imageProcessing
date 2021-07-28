
function filtered = extended_convolution(image,kernel)

%finding sizes of the rows and columns for the padded img
h = round(size(kernel,1)/2);
w = round(size(kernel,2)/2);
unalteredrows = size(image,1);
unalteredcols = size(image,2);

image = padThis(image,kernel);

Imgrows = size(image,1);
Imgcols = size(image,2);

filtered = zeros(unalteredrows,unalteredcols);


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
        filtered(i-h+1,j-w+1) = sum;
    end
end
end
