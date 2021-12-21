function [x,y,index] = pair_map_rect(i, j, k, z,x,y, index,u)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%1
if u(i,j,k) ~= 0 && u(i,j,z) ~= 0  
    x(1, index) = u(i,j,k);
    y(1, index) = u(i,j,z);
    index = index + 1;
end

%2
if u(i,j,k) ~= 0 && u(i,k,z) ~= 0
    x(1, index) = u(i,j,k);
    y(1, index) = u(i,k,z);
    index = index + 1;
end

%3
if u(i,j,z) ~= 0 && u(i,k,z) ~= 0
    x(1, index) = u(i,j,z);
    y(1, index) = u(i,k,z);
    index = index + 1;
end

%4
if u(i,j,k) ~= 0 && u(j,k,z) ~= 0
    x(1, index) = u(i,j,k);
    y(1, index) = u(j,k,z);
    index = index + 1;
end

%5
if u(i,k,z) ~= 0 && u(j,k,z) ~= 0
    x(1, index) = u(i,k,z);
    y(1, index) = u(j,k,z);
    index = index + 1;
end

%6
if u(i,j,z) ~= 0 && u(j,k,z) ~= 0
    x(1, index) = u(i,j,z);
    y(1, index) = u(j,k,z);
    index = index + 1;    
end

end

