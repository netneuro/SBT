function [] = defence_subnetwork()
% create the .node format
load ('Schaefer400_xyz.mat');
load ('Schaefer400_label.mat');
load ('Schaefer400_label_numbers.mat');

size = ones(400, 1);
color = [ones(24, 1); 2*ones(35, 1); 3*ones(26, 1); 4*ones(23, 1); zeros(12, 1); 5*ones(28, 1); 6*ones(46, 1); zeros(6, 1);...
    ones(23, 1); 2*ones(35, 1); 3*ones(26, 1); 4*ones(28, 1); zeros(12, 1); 5*ones(33, 1); 6*ones(33, 1); zeros(10, 1)];

xyzColor = [Schaefer400_xyz color];
xyzColorSize = [xyzColor size];
xyzColorSize = num2str(xyzColorSize);

nodes = strcat(strcat(xyzColorSize, "            "),label);
nodes = char(nodes);

output = strcat('subnetworks.node');
dlmwrite(output, nodes, 'delimiter','');
end

