clear all;
close all;


source = im2double(imread('window.jpg'));
target = zeros(size(source));

ks = [-0.27194 0.11517 -0.029859];
K = [474.53 0 405.96;
    0 474.53 217.81;
    0 0 1];
undistort(source,target,K,ks);


function undistort(source,target,K,ks)
% The forward mapping loop: iterate over every source pixel.
for v = 1:size(target, 1)
    for u = 1:size(target, 2)

        % Transform source pixel location (round to pixel grid).
        x = (u-K(1,3))/K(1,1);
        y = (v-K(2,3))/K(2,2);
        r = sqrt(power(x,2)+power(y,2));
        xprime = x*(1+ks(1,1)*power(r,2)+ks(1,2)*power(r,4)+ks(1,3)*power(r,6));
        yprime = y*(1+ks(1,1)*power(r,2)+ks(1,2)*power(r,4)+ks(1,3)*power(r,6));
        uprime = xprime*K(1,1) + K(1,3);
        vprime = yprime*K(2,2) + K(2,3);
        
       % Check if target pixel falls inside the image domain.
        if (uprime > 1 && vprime > 1 && uprime <= size(source, 2)-1 && vprime <= size(source, 1)-1)
            % Sample the target pixel colour from the inverse transformation of the source px.
            alpha = uprime-floor(uprime);
            beta = vprime-floor(vprime);
            f1 = source(floor(vprime),floor(uprime),:);
            f2 = source(floor(vprime),ceil(uprime),:);
            f3 = source(ceil(vprime),floor(uprime),:);
            f4 = source(ceil(vprime),ceil(uprime),:);
            
            f12 = ((1-alpha)*f1)+(alpha*f2);
            f34 = ((1-alpha)*f3)+(alpha*f4);
            
            f1234 = ((1-beta)*f12)+(beta*f34);
   
          target(v,u, :) = f1234;
        end
    end
end
imshow([source target]);
end