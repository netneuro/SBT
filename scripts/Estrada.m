function [k] = Estrada(net)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[n m] = size(net);
for i=1:n
    for j=1:n
     if i ==j
         net(i,j) = 0;
     end
    end
end

A = net; 
D = abs (A);

e_A = expm(A);
e_D = expm(D);

tr_expA = trace (e_A);
tr_expD = trace (e_D);

k = tr_expA / tr_expD;


end

