function [z,p_unc, p_FDR] = extract_z(ROI, atlas_size)
% 22 Dey 98
% input: the ROI file from: results/second level/ 
% ROI fields: h-> the average of z values over subjects | p -> one_sided p
% value | two_sided p val = 2 * min( one_sided p val, 1-one_sided p val) | 


z = zeros (atlas_size, atlas_size);
p_unc = zeros (atlas_size, atlas_size);

for i=1:atlas_size
    for j=1:atlas_size
        p_unc(i,j) = min(ROI(i).p(1,j) , 1- ROI(i).p(1,j));
    end
end

%two_sided p Val
p_unc = p_unc * 2;

%Analysis level FDR correction:
p_FDR = reshape(conn_fdr(p_unc(:)),size(p_unc));

%Seed level fDR correction:
% for i=1: atlas_size
%     p_FDR(i,:) = conn_fdr(p_unc(i,:));
% end

for i = 1:atlas_size
    for j=1:atlas_size
        
        if p_FDR(i,j) < 0.05
           z (i,j) = ROI(i).h (1,j);
        end
    end
end


