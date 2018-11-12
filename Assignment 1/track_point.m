function [trackX, trackY] = track_point(frames, startX, startY, patchSize, searchSize)

[height, width, ~, n] = size(frames);
image = rgb2gray(frames(:, :, :, 1)); % convert image to grayscale
x1 = max(1, startX - patchSize / 2);
y1 = max(1, startY - patchSize / 2);
x2 = min(width, startX + patchSize / 2 - 1);
y2 = min(height, startY + patchSize / 2 - 1);
patch = image(y1:y2, x1:x2); % cut the reference patch (template) from the first frame
% initialize the output
trackX = zeros(1, n);
trackY = zeros(1, n);
trackX(1) = startX;
trackY(1) = startY;

for i = 2:n
% TODO: cut a region of seachSize times searchSize with the center in the point's previous position (i-1).

x1 = max(1, trackX(i-1) - searchSize / 2);
y1 = max(1, trackY(i-1) - searchSize / 2);
x2 = min(width, trackX(i-1) + searchSize / 2 - 1);
y2 = min(height, trackY(i-1) + searchSize / 2 - 1);

% TODO: convert the region to grayscale
region = ones(searchSize, searchSize);
%region = region - 2;
region(1 : y2 - y1 + 1, 1 : x2 - x1 + 1) = rgb2gray(frames(y1:y2, x1:x2, :,i));

% TODO: compare the region to template using normxcorr2
c = normxcorr2(patch,region);

% TODO: select best match (maximum) and determine its position
[hC, wC] = find( c == max(c(:)) );
 hC = hC(1);
 wC = wC(1);
if hC < patchSize 
    hR = max(0, hC - patchSize/2 + 1);
elseif hC > searchSize 
    hR = min(searchSize - 1, hC - patchSize/2 + 1);
else
    hR = hC - patchSize / 2 + 1;

end

if wC < patchSize 
    wR = max(0, wC - patchSize/2 + 1);
elseif wC > searchSize
    wR = min(searchSize - 1, wC - patchSize/2 + 1);
else
    wR = wC - patchSize/2  + 1;

end

if wR < 0
    trackX(i) = max(1, x1 + floor(wR)); 
else
    trackX(i) = min(width, x1 + floor(wR)); 
end

if hR < 0
    trackY(i) = max(1, y1 + floor(hR));
else
    trackY(i) = min(height, y1 + floor(hR));
end
end
end
