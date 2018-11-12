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


video = read_video('shaky');
I=video(:,:,:,1);

imshow(I);

[startX, startY]= ginput(1);

startX = floor(startX);
startY =floor(startY);

[w, h] = track_point(video, startX, startY, 10, 20);
hold on;
plot(startX, startY, '.', 'MarkerFaceColor', 'r');
for i = 1 : numel(w)
    plot(w(i), h(i), '.', 'MarkerFaceColor', 'r');
end


