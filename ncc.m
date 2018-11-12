P = [1 3; 7 1]; 
T = [0 0 1 3; 0 0 7 1; 0 0 0 0]; 

[hP,wP,dP] = size(P); 
[h,w,d] = size(T);

t_avg = mean(T(:)); 

n=hP*wP;

for i = 1:(h-hP+1)
    for j = 1:(w-wP+1) 
        
        F = T(i:i+hP-1, j:j+wP-1) 
        f_avg = mean(F(:)); 
        
        D = double(((F - f_avg).*(P - t_avg))/(std2(F)*std2(P)+0.000001));
        C(i,j) = (1/n) * sum(D(:),1)
    end
end