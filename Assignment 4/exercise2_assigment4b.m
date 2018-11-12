S = -1 * M;
p = mean(S(:),1);
[idx,netsim,dpsim,expref] = apcluster(S, p/137);

 figure;
 m = unique(idx);
 n = min(9, numel(unique(idx)));

 for i = 1 : n;
     if (idx(i) - i) == 0
       subplot(3, 3, n);
       imshow(video(:,:,:,m(n))); 
     end
 end
   

