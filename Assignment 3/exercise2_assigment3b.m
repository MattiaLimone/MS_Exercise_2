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
l=1;
for j = 1 : 2 : n-1
    K = ( sqrt(H(:,:,j)) - sqrt(H(:,:,j+1)) ).^2 ;
    M(l) = sqrt((1/2) * sum(K(:),1));
    l=l+1;
end
th = max(M(:)) / 4;
bin = M > th;

sumaSmene = sum(bin(:),1);
f = min(5, sumaSmene-1);

figure;
subplot(1,f,1);
imshow(video(:,:,:,1));
k=2; l=0;
for i = 2 : size(M,2);
    if bin(i) > 0 && k < f+1
       subplot(1,f,k);
       imshow(video(:,:,:,i*2));
       k=k+1;
    end
end


