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
[height,width,ch,frames] = size(video);
for i = 1:frames
    if i ~= frames
        imshowpair(video(:,:,:,i),video(:,:,:,i+1),'diff');
    elseif i == frames
        imshowpair(video(:,:,:,i),video(:,:,:,i+1),'diff');
    else
        %Do nothing
    end
end