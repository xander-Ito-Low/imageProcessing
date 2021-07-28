

image = im2double(imread('cameraman.tif'));


%transformation kernels
horizontal = [
     1     2     1
     0     0     0
    -1    -2    -1
    ];

vertical =[
     1   0    -1
     2    0   -2
     1    0   -1
    ];

diagonal =[
     2     1     0
     1     0    -1
     0    -1    -2
];

sharpie = [
   0 -1 0
   -1 5 -1
   0 -1 0
];


subplot(3,3,1); 
imshow(image); 
title('Input image'); 

filtered = extended_convolution(image,horizontal);
subplot(3,3,2); imshow(filtered); 
title('x-gradient');

filtered2 = extended_convolution(image,vertical);
subplot(3,3,3); imshow(filtered2); 
title('y-gradient');

filtered3 = extended_convolution(image,diagonal);
subplot(3,3,4); imshow(filtered3);
title('Diagonal gradient');

sharpening = extended_convolution(image,sharpie);
subplot(3,3,5); imshow(sharpening);
title('sharpened img');

gkernel = findGaus(5,1);
filtered5 = extended_convolution(image,gkernel);
subplot(3,3,6); imshow(filtered5);
title('gausean filtered img');


  function gausean = findGaus(size,sigma)
         gausean = zeros(size);
  
     for i = 1:size
         for j = 1:size
          constantval = 1/(2*pi*sigma^2);
          x = i-round(size/2);
          y = j-round(size/2);
          exponentval = exp(-((x^2+y^2)/(2*sigma^2)));
          gausean(i,j) = constantval*exponentval;
         end
     end
     normalizeval = sum(gausean(:));
     gausean = 1/normalizeval*gausean;
 end


%end of kernels






