% Author: Mattia Limone
% Change the current folder to m file one
if(~isdeployed)
	cd(fileparts(which(mfilename)));
end
clc;	% Clear command window.
clear;	% Delete all variables.
close all;	% Close all figure windows except those created by imtool.
imtool close all;	% Close all figure windows created by imtool.
workspace;	% Make sure the workspace panel is showing.

video = read_video('bigbuck');
[h, w, d, n]=size(video);

H = zeros(8, 3, n);
for i = 1 : n
    [Rcounts, Rlb] = imhist(video(:,:,1,i),8);
    [Gcounts, Glb] = imhist(video(:,:,2,i),8);
    [Bcounts, Blb] = imhist(video(:,:,3,i),8);
    H(:, :, i) = cat(2,Rcounts, Gcounts, Bcounts);
end

for j = 1 : 2 : n-1
    K = ( sqrt(H(:,:,j)) - sqrt(H(:,:,j+1)) ).^2 
    M(j) = sqrt((1/2) * sum(K(:),1));
end
figure;
plot(M);