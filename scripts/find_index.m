function [index] = find_index(u, condition)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

x_axes = (-2:0.01:2);
y_axes = flip(x_axes);

if condition == 1
    % x axes or the first triad
    for i=1:400
       if u >= x_axes(1,i) && u < x_axes(1,i+1)
            index = i;
           break
       end
    end
elseif condition == 2
    % y axes or the second triad

    for i=1:400
       if u < y_axes(1,i) && u >= y_axes(1,i+1)
            index = i;
           break
       end
    end
end
        

end

