clear all;
close all;

source = im2double(imread('mona.jpg'));
target = zeros(size(source));

T = [1 0 -size(source, 2) / 2; 0 1 -size(source, 1) / 2; 0 0 1];
t = pi / 4;
R = [cos(t) -sin(t) 0; sin(t) cos(t) 0; 0 0 1];
S = [4 0 0; 0 4 0; 0 0 1];
M = inv(T) * R * S * T;

interpolate(source,target,M);

function interpolate(source,target,M)
% The forward mapping loop: iterate over every source pixel.
for y = 1:size(target, 1)
    for x = 1:size(target, 2)

        % Transform source pixel location (round to pixel grid).
        p = [x; y; 1];
        q = inv(M) * p;
        u = (q(1) / q(3));
        v = (q(2) / q(3));
     
        % Check if target pixel falls inside the image domain.
        if (u > 1 && v > 1 && u < size(source, 2) && v < size(source, 1))
            % Sample the target pixel colour from the inverse transformation of the source px.
            alpha = u-floor(u);
            beta = v-floor(v);
            f1 = source(floor(v),floor(u),:);
            f2 = source(floor(v),ceil(u),:);
            f3 = source(ceil(v),floor(u),:);
            f4 = source(ceil(v),ceil(u),:);
            
            f12 = ((1-alpha)*f1)+(alpha*f2);
            f34 = ((1-alpha)*f3)+(alpha*f4);
            
            f1234 = ((1-beta)*f12)+(beta*f34);
   
            target(y,x, :) = f1234;
        end
    end
end
imshow([source target]);
end
