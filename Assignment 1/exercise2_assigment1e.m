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
[h, w, d, n]=size(video);

I = video(:,:,:,1);
figure;
imshow(I);
[startX, startY] = ginput(1);

startX = floor(startX);
startY = floor(startY);

[trackX, trackY] = track_point(video, startX, startY, 10, 20);

stb_vid = zeros(h, w, d, n);

X_data = trackX(1) - trackX;
Y_data = trackY(1) - trackY;


for i = 1 : n
    stb_vid(:,:,:,i) = imtranslate(I, [X_data(i), Y_data(i)]);
    if X_data(i) < 0
        stb_vid(:, w + X_data(i) + 1 : w, :, i) = NaN;
    elseif X_data(i) > 0
        stb_vid(:, 1 : X_data(i), :, i) = NaN;
    end
    
    if Y_data(i) < 0 
        stb_vid(h + Y_data(i) + 1 : h, :, :, i) = NaN;
    elseif Y_data(i) > 0
        stb_vid(1 : Y_data(i), :, :, i) = NaN;
    end
    
end
avg_stb_vid = zeros(h,w,d);
avg_stb_vid = nanmean(stb_vid, 4);

for i = 1 : n
    if X_data(i) < 0
        stb_vid(:, w + X_data(i) + 1 : w, :, i) = avg_stb_vid(:, w + X_data(i) + 1 : w, :);
    elseif X_data(i) > 0
        stb_vid(:, 1 : X_data(i), :, i) = avg_stb_vid(:, 1 : X_data(i), :);
    end
    
    if Y_data(i) < 0 
        stb_vid(h + Y_data(i) + 1 : h, :, :, i) = avg_stb_vid(h + Y_data(i) + 1 : h, :, :);
    elseif Y_data(i) > 0
        stb_vid(1 : Y_data(i), :, :, i) = avg_stb_vid(1 : Y_data(i), :, :);
    end
    
end
figure(2);
video_stb = uint8(stb_vid);
implay(video_stb);
