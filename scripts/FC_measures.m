% functional connectivity measures
% 20 Dey

% %%calculate links

n = 80;
for i=1:n
    
%     if i<10
%         name = strcat('00', num2str(i));
%     elseif i<100
%         name = strcat('0', num2str(i));
%     else
%         name = num2str(i);
%     end

        name = num2str(i, '%03i');
%     ts = strcat('ts_dmnA_child_', name,'.mat');
%     if isfile (ts)
%         
%         load(ts);
        t = ts_adult{1,i};
        FC = corrcoef(t);
%         covar = cov(ts_dmnC);
%         Z = atanh(FC);
%         for j=1:34
%             for k=1:34
%                 if j==k
%                     Z(j,k)=0;
%                 end
%             end
%         end
        corr_adult{1,i} = FC;
%         z_dmnA_child{1,i} = Z;
%         dir_corr = '/Users/zahra/Documents/Energy lags/denoised_data/corr/adol/';
%         dir_z = '/Users/zahra/Documents/Energy lags/denoised_data/z/adol/';
% %         dir_covar = '/Volumes/ADATA HD830/SBU/Thesis/Experiments/Cross study/divide in two New/Schaefer/Yeo networks/rep_con_14_18/12 control B/1. cov/';
%        
%         output_name_FC = strcat(dir_corr, 'corr_adol_',name);
%         save(output_name_FC, 'FC');
%         
% %         output_name_covar = strcat(dir_covar, 'cov_dmnC_',name);
% %         save(output_name_covar, 'covar');       
%                 
%         output_name_Z = strcat(dir_z, 'z_adol_',name);
%         save(output_name_Z, 'Z');
% %     end
%     clear all
end

%% calculate energy

% n = 343;
% for i=1:n
%     name_1 = 'maskedCorr_';
%     
%     if i<10
%         temp = {'00', num2str(i)};
%         name_2 = strcat(temp{1,1},temp{1,2});
%     elseif i<100
%         temp = {'0', num2str(i)};
%         name_2 = strcat(temp{1,1},temp{1,2});
%     else
%         name_2 = num2str(i);
%     end
%     name_3 = '.mat';
%     
%     name = strcat(name_1, name_2, name_3);
%     if isfile (name)
%         load(name);
%         u_r_groupMasked_con_13_18(1,i) = U(FC);
%     end
% end
% 
% u_r_groupMasked_con_13_18 = nonzeros(u_r_groupMasked_con_13_18);

%%
% 

% [p_6_9_dis,h_6_9_dis] = ranksum(u_dmnC_asd_9_13_dis,u_dmnC_asd_13_18_dis);
% [p_10_13_dis,h_10_13_dis] = ranksum(u_dmnC_asd_10_13_dis,u_dmnC_con_10_13_dis);
% [p_14_18_dis,h_14_18_dis] = ranksum(u_dmnC_asd_13_18_dis,u_dmnC_con_14_18_dis);
% % 
% [p_6_9_rep,h_6_9_rep] = ranksum(u_dmnC_asd_9_13_rep,u_dmnC_asd_13_18_rep);
% [p_10_13_rep,h_10_13_rep] = ranksum(u_dmnC_asd_10_13_rep,u_dmnC_con_10_13_rep);
% [p_14_18_rep,h_14_18_rep] = ranksum(u_dmnC_asd_13_18_rep,u_dmnC_con_14_18_rep);