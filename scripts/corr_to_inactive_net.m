function [net] = corr_to_inactive_net(corr)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[net_size m] = size(corr);
net = zeros (net_size, net_size);

temp_corr = corr;

%assign inative links
for i=1:net_size
    for j=1:net_size
       if (0<corr(i,j) && corr(i,j)<0.05) || (-0.05<corr(i,j) && corr(i,j)<0) 
           temp_corr(i,j) = 0;
       end
    end
end
             
for i=1:net_size
    for j=1:net_size
        
        if temp_corr(i,j)> 0 
            net(i,j) = 1;
        elseif temp_corr(i,j)< 0 
            net(i,j) = -1;
        else
            net(i,j) = temp_corr(i,j);

        end

     end
end


save('inactiveNet.mat' , 'net');

end

