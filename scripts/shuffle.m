function [shuffled_net] = shuffle(net)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% (116*116-116)/2 = 6670
t = 1;
temp = zeros(1,6670);
for i=1:115
    for j=i+1:116   
        temp (1,t) = net(i,j);
        t = t+1;
    end
end


[a b] = size(temp);
if b == 6670
    idx = randperm(6670);
    shuffled_diag = temp(idx);
end

shuffled_top = zeros(116,116);
t=1;
for i=1:115
    for j=i+1:116   
        shuffled_top(i,j) = shuffled_diag(1,t);
        t = t+1;
    end
end

shuffled_net = shuffled_top'+shuffled_top;

end

