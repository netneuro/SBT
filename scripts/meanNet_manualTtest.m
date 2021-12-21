%24 Dey

%Create one cell for all individuals
% n = 343;
% for i=1:n
%     if i<10
%         name = strcat('00', num2str(i));
%     elseif i<100
%         name = strcat('0', num2str(i));
%     else
%         name = num2str(i);
%     end
%     ts = strcat('corrcoef_', name,'.mat');
%     if isfile (ts)
%         load(ts);
%         index(1,i) = i;
%         r_individuals_con_14_18_dis{1,i} = FC;
%     end
% end
% r_individuals_con_14_18_dis = r_individuals_con_14_18_dis(~cellfun('isempty',r_individuals_con_14_18_dis));

% t test on each link
% for each run change: number of ROIs, number of subjects

for i=1:116
    for j=1:116
        for sub = 1:53
            temp(1,sub) = Z_individuals_asd_14_18_dis{1,sub}(i,j);
            z_mean_unc(i,j) = mean(temp);
        end
        [h,p,ci,stats] = ttest(temp);
        p_unc(i,j) = p;
    end
end
p_unc(isnan(p_unc))=0;

%Analysis level FDR correction:
p_FDR = reshape(conn_fdr(p_unc(:)),size(p_unc));

for i=1:116
    for j=1:116
        if p_FDR(i,j)<0.05
            z_ensamble_asd_14_18_rep(i,j) = z_mean_unc(i,j);
        end
    end
end