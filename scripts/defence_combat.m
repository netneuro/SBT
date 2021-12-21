function [FC_harmonized, sig_differ_percentage_before, sig_differ_percentage_after] = defence_combat(FC_unharmonized, batch, mod)

% ComBat harmonization to correct the site effect in functional connectivities, from Meichen Yu (2018): https://github.com/Jfortin1/ComBatHarmonization

% batch: site codes with element (i,1) be the site number for the ith subject
% mod: aims to preserve the original biological variations within data while harmonizing the effect of site.
% each coloumn in mod corresponds to one biological variation. Here, first and second columns are age and group (0 for ASD, 1 for CON).

disp(['Harmonizing the functional connectivities is started...' newline]);

[~, subject_count] = size(FC_unharmonized);
[~, roi] = size(FC_unharmonized{1,1});
tril_count = ((roi * roi) - roi) / 2; % number of elements in the lower triangle of each correlation matrix

% for each subject reformat its functional connectivity matrix into a single column vector with only its lower triangle elements 
dat = zeros(tril_count, subject_count);

for i = 1:subject_count
    A = FC_unharmonized{1,i};
    m = tril(true(size(A)), -1);
    v = A(m);
    dat(:,i) = v;
end

% run comBat: combat is a function in comBat Harmonization package from: https://github.com/Jfortin1/ComBatHarmonization
dat_harmonized = combat(dat, batch, mod, 1);

% what percent of the functional connectivities are significantly different across different sites, before and after the harmonization?
% compare using the kruskal wallis test

p = zeros(tril_count, 1); 
p_harmonized = zeros(tril_count, 1); 

h = cell(tril_count, 1); 
h_harmonized = cell(tril_count, 1); 

for i = 1:tril_count
    [p(i,1), h{i,1}] = kruskalwallis(dat(i,:), batch, 'off');
    [p_harmonized(i,1), h_harmonized{i,1}] = kruskalwallis(dat_harmonized(i,:), batch, 'off');
end

p_FDR = mafdr(p);
p_FDR_harmonized = mafdr(p_harmonized);

% compute functional connectivity percentage with p_fdr < 0.05 (before and after harmonization)
 
sig_differ_count_before = 0; 
sig_differ_count_after = 0;

for i = 1:tril_count
    if p_FDR(i,1) < 0.05
        sig_differ_count_before = sig_differ_count_before + 1;
    end
    if p_FDR_harmonized(i,1) < 0.05
        sig_differ_count_after = sig_differ_count_after + 1;
    end    
end

sig_differ_percentage_before = (sig_differ_count_before / tril_count);
sig_differ_percentage_after = (sig_differ_count_after / tril_count);

% reformat the harmonized data from a single column vector to a 2D correlation matrix for each subject

FC_harmonized = cell(1, subject_count);
for i = 1:subject_count
    a = tril(ones(roi), -1);
    a(a > 0) = dat_harmonized(:,i);
    a = tril(a) + tril(a, -1)';
    FC_harmonized{1,i} = a;  
end

disp(['Harmonizing the functional connectivities is done! :)' newline]);

end

