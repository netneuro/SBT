function [index] = find_index(p)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
min = -1;
max = +1;

[m n]=size (p);
index = ones(1,n);

for i=1:n
    
    while min+0.01 <= max

        if (min<p(1,i)) && (p(1,i)<min+0.01)
            index(1,i) = i;
            break
        else
            index(1,i) = index(1,i)+ 1;
            min = min +0.01;
        end


    end

end

end

