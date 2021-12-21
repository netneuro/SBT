
n_autism = 23;
n_control = 15;
p_triads_autism_base = cell(1,n_autism);
p_triads_control_base = cell(1,n_control);

for i=1:n_autism
    p_triads_autism_base{1,i} = probability_of_triads(net_autism_base{1,i});
    
end

for i=1:n_control
    p_triads_control_base{1,i} = probability_of_triads(net_control_base{1,i});
    
end