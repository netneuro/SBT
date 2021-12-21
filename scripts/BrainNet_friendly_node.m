
n = 2511;
xyz = nodes_b_control_ses2;


for i=1:n
    label(i,1) = '-';
end

xyz = num2str(xyz);
together = strcat(xyz, label);

for i=1:n
    together(i, end-2:end-1)= char(' ');
end

nodes_b_control_ses2_str = together;

dlmwrite('d_nodes_control_ses2.node',nodes_b_control_ses2_str,'delimiter','');
