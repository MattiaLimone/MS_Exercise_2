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
[h,w,d,n]=size(video);

G = fspecial('gaussian', 10, 10);
figure(1);
for i=1:5
    
    I_1 = rgb2hsv(video(:,:,:,i));
    I_2 = rgb2hsv(video(:,:,:,i+1));
    
    s=imfilter(abs(I_1(:,:,1) - I_2(:,:,1)), G);
    subplot(1,5,i);imagesc(s);
    
end