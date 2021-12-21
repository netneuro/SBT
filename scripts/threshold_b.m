%29 Mehr 98

selected_u_b_control_ses2 = zeros(116,116,116);

for i=1:116
    for j=1:116
        for k=1:116
            
            if u_b_control_ses2(i,j,k) >= 0.0002 && u_b_control_ses2(i,j,k) < 0.004
                selected_u_b_control_ses2(i,j,k) = u_b_control_ses2(i,j,k);
            end
            
            
        end
    end
end

t = reshape(selected_u_b_control_ses2, [1,116*116*116]);
t_control_ses2 = nonzeros(t);