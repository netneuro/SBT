%29 Mehr 98

adj_b_cutoff_autism_z_ses1 = zeros(116,116);

for i=1:116
    for j=1:116
        for k=1:116
            
            if u_cutoff_b_autism_ses1(i,j,k) ~= 0
                
                adj_b_cutoff_autism_z_ses1(i,j) = z_autism_ses1 (i,j);
                adj_b_cutoff_autism_z_ses1(i,k) = z_autism_ses1 (i,k);
                adj_b_cutoff_autism_z_ses1(j,k) = z_autism_ses1 (j,k);
                
            end
            
        end
    end
end

dlmwrite('edges_b_cutoff0.00006_autism_ses1.edge',adj_b_cutoff_autism_z_ses1,'delimiter','\t','precision',15);

