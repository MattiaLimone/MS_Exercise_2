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

h2 = floor((h-5)/2);
w2 = floor(w/2);
video2 = zeros(h2, w2, 3, 120);
for i = 1 : 120
    video2(:, :, :, i) = imresize(video(1:130,:,:,i), 0.5);
    video(1:h2, 1:w2, :, i) = uint8(video2(:,:,:,i));
    imshow(uint8(video(:, :, :, i)));
end