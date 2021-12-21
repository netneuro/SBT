
% final cut-off for (---) interactions with interval [0.00006, max u]

u_cutoff_b_autism_ses2 = zeros(116, 116, 116);

for i=1:116
    for j=1:116
        for k=1:116
            if u_b_autism_ses2(i,j,k)>0.00006

            u_cutoff_b_autism_ses2(i,j,k) = u_b_autism_ses2(i,j,k);
            end
        end
    end
end

u_cutoff_b_autism_ses2_number = nonzeros(reshape(u_cutoff_b_autism_ses2, [1,116*116*116]));
