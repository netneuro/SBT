function [net] = corr_to_net(corr)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[net_size m] = size(corr);
net = zeros (net_size, net_size);

for i=1:net_size
    for j=1:net_size
        
        if corr(i,j)> 0 
            net(i,j) = 1;
        elseif corr(i,j)< 0 
            net(i,j) = -1;
        else
            net(i,j) = corr(i,j);

        end

     end
end


end

