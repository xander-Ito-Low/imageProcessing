
function paddedRes = padThis(image,kernel)
Kernelrows = size(kernel,1);
Kernelcols = size(kernel,2);
padrows = (Kernelrows-1)/2;
padcolumns = (Kernelcols-1)/2;

paddedRes = padarray(image,[padrows,padcolumns],'replicate','both');
end
