function [altered_data, control_data] = seperate_data(data, altered_count, control_count)

total = altered_count + control_count;
altered_data = data(:,1:altered_count);
control_data = data(:,altered_count+1:total);

end

