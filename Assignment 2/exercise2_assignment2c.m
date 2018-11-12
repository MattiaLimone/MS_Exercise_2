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

I = video(:,:,:,1);
figure;
imshow(I);
[startX, startY] = ginput(1);

startX = floor(startX);
startY = floor(startY);

[trackX, trackY] = track_point(video, startX, startY, 12, 20);

frame = uint8(zeros(100, 100, 3, n));

%v = VideoWriter('bigbuck-cropped.avi');
for i = 1 : n
    
    x1 = max(1, trackX(i) - 50);
    y1 = max(1, trackY(i) - 50);
    x2 = min(w, trackX(i) + 49);
    y2 = min(h, trackY(i) + 49);
    
    figure(2);
    F = video(y1 : y2, x1 : x2, :, i);
    
    x1_f = max(1, 50 - abs(trackX(i) - x1) + 1);
    x2_f = min(100, 51 + abs(x2 - trackX(i)));
    y1_f = max(1, 50 - abs(trackY(i) - y1) + 1);
    y2_f = min(100, 51 + abs(y2 - trackY(i)));
 
    frame(y1_f : y2_f, x1_f : x2_f  , :, i) = F;
    imshow(frame(:,:,:,i));
    %writeVideo(v,frame(:,:,:,i));
end


