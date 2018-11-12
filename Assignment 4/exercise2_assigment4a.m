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

video = read_video('sintel');
[h, w, d, n] = size(video);

HG = zeros(8, 3, n);
for i = 1 : n
    I = rgb2hsv(video(:,:,:,i));
    [H, ~] = imhist(I(:,:,1),8);
    [S, ~] = imhist(I(:,:,2),8);
    [V, ~] = imhist(I(:,:,3),8);
    HG(:, :, i) = cat(2, H, S, V);
end

M = zeros(n,n);
for i = 1 : n-1
    for j = i+1 : n
        K = ( sqrt(HG(:,:,i)) - sqrt(HG(:,:,j)) ).^2 ;
        M(i,j) = sqrt((1/2) * sum(K(:),1));
        M(j,i) = M(i,j);
    end
end

imagesc(uint8(M));
colormap jet;