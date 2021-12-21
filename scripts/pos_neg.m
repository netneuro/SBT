function [pos, neg, zeros, flag] = pos_neg(FC)

[roi, ~] = size(FC);
total_links = ((roi * roi) - roi) / 2;
neg = 0;
pos = 0;
zeros = 0;

for i = 1:roi-1
    for j = i+1:roi        
        if FC(i, j) < 0, neg = neg + 1; elseif FC(i, j) > 0, pos = pos + 1; elseif FC(i, j) == 0, zeros = zeros + 1; end
    end
end

estimated_links = zeros + pos + neg;

if total_links == estimated_links, flag = 1; else, flag = 0; end
if ~flag, error('Error in counting links :( Please check the pos_neg function.'); end

end