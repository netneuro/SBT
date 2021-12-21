function [sim_k] = n_shuffle(corr, n)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

K = zeros(1,n);
for i=1:n
    net = corr_to_inactive_net(corr);
    shuffled_net = shuffle (net);
    K(1,i) = Estrada(shuffled_net);
end

sim_k = mean (K);

end