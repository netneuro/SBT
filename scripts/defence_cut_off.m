function [] = defence_cut_off(triad_energy, threshold, mod, group)

% triad_energy is a 3D matrix of triads' energies
% mod = 1 for T_1, and 0 for T_0

% load('/Volumes/ZAHRA5TB/ongoing_projects/defence/results/mat_files/brainnet_inputs.mat')
[roi, ~, ~] = size(triad_energy);
keep_energy = zeros(roi, roi, roi);
keep = zeros(roi, roi);

for i = 1:roi - 2
    for j = i + 1:roi -1
        for k = j + 1:roi
            switch mod
                case 0
                    if triad_energy(i, j, k) >= threshold
                        keep_energy(i, j, k) = triad_energy(i, j, k);
                        keep(i, j) = 1;
                        keep(i, k) = 1;
                        keep(j, k) = 1;
                    end
                case 1
                    if triad_energy(i, j, k) <= threshold
                        keep_energy(i, j, k) = abs(triad_energy(i, j, k));
                        keep(i, j) = 1;
                        keep(i, k) = 1;
                        keep(j, k) = 1;                  
                    end    
            end 
        end
    end
end

keep = keep + keep';

G = graph(keep, 'upper');
keep_degree = degree(G);

% b) color of each node:
color = zeros(roi, 1);

for i = 1:roi - 2
    for j = i + 1:roi -1
        for k = j + 1:roi
            if keep_energy(i, j, k) ~= 0
                color(i, 1) = color(i, 1) + keep_energy(i, j, k);
                color(j, 1) = color(j, 1) + keep_energy(i, j, k);
                color(k, 1) = color(k, 1) + keep_energy(i, j, k);       
            end
            
        end
    end
end

% normalize the color
for i = 1:roi
    if keep_degree(i, 1) ~= 0
        color(i,1) = color(i, 1) / (keep_degree(i,1) - 1);
    end
end
min(color)
max(color)

% create the .node format
load ('Schaefer400_xyz.mat');
load ('Schaefer400_label.mat');
load ('Schaefer400_label_numbers.mat');

xyzColor = [Schaefer400_xyz color];
xyzColorSize = [xyzColor keep_degree];
    
xyzColorSize = num2str(xyzColorSize);
% label = char(Schaefer400_label);
% for i= 1:400
% label(i,1) = convertCharsToStrings(numbers_as_label(i, :));
% end

nodes = strcat(strcat(xyzColorSize, "            "),label);
nodes = char(nodes);

output = strcat('T', num2str(mod), '_', num2str(threshold), '_', group, '_numbers_as_label.node');
dlmwrite(output, nodes, 'delimiter','');

end

