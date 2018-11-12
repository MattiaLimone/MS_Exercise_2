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
[h,w,d,frames]=size(video);

for i=1:frames
    if i ~= frames
        I_1 = rgb2hsv(video(:,:,:,i));
        I_2 = rgb2hsv(video(:,:,:,i+1));
        video1(:,:,:,i)=(abs(I_1(:,:,1) - I_2(:,:,1)));

    elseif i == frames
        I_1 = rgb2hsv(video(:,:,:,i));
        I_2 = rgb2hsv(video(:,:,:,1));
        video1(:,:,:,i)=(abs(I_1(:,:,1) - I_2(:,:,1))); 
    else
        %Do nothing
    end
end

subplot(1,5,1);imagesc(video1(:,:,:,10));title('FRAME #10')
subplot(1,5,2);imagesc(video1(:,:,:,113));title('FRAME #113')
subplot(1,5,3);imagesc(video1(:,:,:,216));title('FRAME #216')
subplot(1,5,4);imagesc(video1(:,:,:,319));title('FRAME #319')
subplot(1,5,5);imagesc(video1(:,:,:,422));title('FRAME #422')