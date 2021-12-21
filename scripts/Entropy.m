function [outputArg1,outputArg2] = Entropy(P)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

P = cell2mat(P);

g_a = 3; g_d = 3; g_f = 3; g_g = 3; g_h = 3; g_i = 3; 
g_b = 1; g_c = 1; g_j = 1; g_e = 6;

G = [g_a, g_b, g_c, g_d, g_e, g_f, g_g, g_h, g_i, g_j];

K = 1.38064852e-23;
S = 0;

for i = 1:10
    
   S = S + (P(1,i)* (exp(P(1,i)) - exp(G(1,i))));
    
end

S = -K * S  

end

