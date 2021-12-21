% 1 Aban 98

% pick the selected triads within the cut off

clear all
load('u_b.mat');

first_cutOff_u_b_autism_ses2 = zeros(400,400,400);

for i=1:116
    for j=1:116
        for k=1:116
            if u_b_autism_ses2(i,j,k) < 0.02
%             if u_b_autism_ses2(i,j,k) >= 0.0002 && u_b_autism_ses2(i,j,k) < 0.0006
%             if u_b_autism_ses2(i,j,k) >= 0.0002 && u_b_autism_ses2(i,j,k) < 0.0004
%             if u_b_autism_ses2(i,j,k) >= 0.0004 && u_b_autism_ses2(i,j,k) < 0.00092
%             if u_b_autism_ses2(i,j,k) >= 0.0006 && u_b_autism_ses2(i,j,k) < 0.00092
%             if u_b_autism_ses2(i,j,k) >= 0.00092
                first_cutOff_u_b_autism_ses2(i,j,k) = u_b_autism_ses2(i,j,k);
            end
           
        end
    end
end

t_autism_ses2 = reshape(first_cutOff_u_b_autism_ses2, [1,116*116*116]);
t_autism_ses2 = nonzeros(t_autism_ses2);


% create the .edge file

load ('corr_mean.mat');
first_cutOff_edges_b_autism_ses2 = zeros(116,116);

for i=1:116
    for j=1:116
        for k=1:116
            
            if first_cutOff_u_b_autism_ses2(i,j,k) ~= 0
                
                first_cutOff_edges_b_autism_ses2(i,j) = corr_autism_ses2 (i,j);
                first_cutOff_edges_b_autism_ses2(i,k) = corr_autism_ses2 (i,k);
                first_cutOff_edges_b_autism_ses2(j,k) = corr_autism_ses2 (j,k);
                
            end
            
        end
    end
end

% a)size of each node

G = graph(first_cutOff_edges_b_autism_ses2, 'upper');
degree_autism_ses2 = degree(G);

% b) color of each node:
color_autism_ses2 = zeros(116,1);

for i=1:116
    for j=1:116
        for k=1:116
            if first_cutOff_u_b_autism_ses2 (i,j,k) ~=0
                color_autism_ses2(i,1) = color_autism_ses2(i,1) +first_cutOff_u_b_autism_ses2 (i,j,k);
                color_autism_ses2(j,1) = color_autism_ses2(j,1) +first_cutOff_u_b_autism_ses2 (i,j,k);
                color_autism_ses2(k,1) = color_autism_ses2(k,1) +first_cutOff_u_b_autism_ses2 (i,j,k);       
            end
            
        end
    end
end
% normalize the color
for i=1:116
    if degree_autism_ses2 (i,1) ~= 0
        color_autism_ses2(i,1) = color_autism_ses2(i,1) / (degree_autism_ses2(i,1) - 1);
    end
end

% create the .node format

load ('AAL116_xyz.mat');
load ('AAL116_label.mat');
xyzColor = [AAL116_xyz color_autism_ses2];
xyzColorSize = [xyzColor degree_autism_ses2];
    
xyzColorSize = num2str(xyzColorSize);
label = char(AAL116_label);
b_threshold_autism_ses2 = strcat(strcat(xyzColorSize, "            "),label);
b_threshold_autism_ses2 = char(b_threshold_autism_ses2);

dlmwrite('first_cutOff_nodes_b_autism_ses2.node',b_threshold_autism_ses2,'delimiter','');


