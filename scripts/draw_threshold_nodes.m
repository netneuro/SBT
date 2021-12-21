
%color

color_autism_ses1 = zeros(116,1);

for i=1:116
    for j=1:116
        for k=1:116
            if u_cutoff_b_autism_ses1 (i,j,k) ~=0
                color_autism_ses1(i,1) = color_autism_ses1(i,1) +u_cutoff_b_autism_ses1 (i,j,k);
                color_autism_ses1(j,1) = color_autism_ses1(j,1) +u_cutoff_b_autism_ses1 (i,j,k);
                color_autism_ses1(k,1) = color_autism_ses1(k,1) +u_cutoff_b_autism_ses1 (i,j,k);       
            end
            
        end
    end
end

% color_autism = round(color_autism *10000);

%size
xyz_color = [AAL116_xyz color_autism_ses1];
    
xyz_color_size = [xyz_color degree_autism_ses1];
xyz_color_size = num2str(xyz_color_size);
label = char(AAL116_label);
b_threshold_autism_ses1 = strcat(strcat(xyz_color_size, "            "),label);
b_threshold_autism_ses1 = char(b_threshold_autism_ses1);

dlmwrite('b_cutoff_sizeAndColor_autism_ses1.node',b_threshold_autism_ses1,'delimiter','');

