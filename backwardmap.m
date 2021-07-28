clear all;
close all;
source = im2double(imread('mona.jpg'));
subplot(1,3,1);
imshow(source);
title("Source");

target = zeros(size(source));
T = [1 0 -size(source, 2) / 2; 0 1 -size(source, 1) / 2; 0 0 1];
t = pi / 4;
R = [cos(t) -sin(t) 0; sin(t) cos(t) 0; 0 0 1];
S = [4 0 0; 0 4 0; 0 0 1];
M = inv(T) * R * S * T;
target = backwarp(source,target,M);
subplot(1,3,2);
imshow(target); 
title("Transformation 1");
target = zeros(size(source));

t2 = pi/2;
R2 = [cos(t) -sin(t) 0; sin(t) cos(t) 0; 0 0 1];
S2 = [0.5 0 0; 0 0.5 0; 0 0 1];
%rotate by 90 degrees anti-clockwise then scale by a factor of 0.5.
M2 = S2 * R2;
target = backwarp(source,target,M2);
subplot(1,3,3);
imshow(target);
title("Transformation 2");

function target = backwarp(source,target,M)
% The forward mapping loop: iterate over every source pixel.
for y = 1:size(target, 1)
    for x = 1:size(target, 2)

        % Transform source pixel location (round to pixel grid).
        p = [x; y; 1];
        q = inv(M) * p;
        u = round(q(1) / q(3));
        v = round(q(2) / q(3));

        % Check if target pixel falls inside the image domain.
        if (u > 0 && v > 0 && u <= size(source, 2) && v <= size(source, 1))
            % Sample the target pixel colour from the inverse transformation of the source px.
            target(y,x, :) = source(v,u, :);
        end

    end
end
end
