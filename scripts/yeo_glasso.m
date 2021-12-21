
% 20 Dey

%% normalize the timeseries
% n = 343;
% for i=1:n
%     
%     if i<10
%         name = strcat('00', num2str(i));
%     elseif i<100
%         name = strcat('0', num2str(i));
%     else
%         name = num2str(i);
%     end
%       
%     ts = strcat('dmnA_ts_', name,'.mat');
%     if isfile (ts)
%         load(ts);
%         for j=1:24
%             mean_ts(1,j) = mean(ts_dmnA(:,j));
%             var_ts(1,j) = var(ts_dmnA(:,j));
%             for k=1:numel(ts_dmnA(:,j))
%                 ts_dmnA_norm(k,j) = (ts_dmnA(k,j) - mean_ts(1,j)) / var_ts(1,j);
%             end
%             
%         end        
%         output_name = strcat('dmnA_ts_normalized_',name); 
%         save(output_name, 'ts_dmnA_norm');
%         
%     end
% 
% end


%%
% 1) save inverse covariance and sparse(threshold) covariance using glasso
% n = 343;
% for i=1:n
%     
%     if i<10
%         name = strcat('00', num2str(i));
%     elseif i<100
%         name = strcat('0', num2str(i));
%     else
%         name = num2str(i);
%     end
%       
%     ts = strcat('cov_dmnA_', name,'.mat');
%     if isfile (ts)
%         
%         load(ts);
%         
%         [theta w] = glasso(covar,0.1);
%         
%         theta_threshold = theta; 
%         
%         for j=1:24
%             for k=1:24
%                 if theta(j,k) > -0.00000002 && theta(j,k) < 0.00000002
%                     theta_threshold(j,k)=0;
%                 end
%             end
%         end
%         
%         dir_inverseCov = '/Users/zahra/Documents/SBU/Thesis/Experiments/Cross study/divide in two New/Schaefer/Yeo networks/dis_con_14_18/1. visual centeral/4. inverseCov/';     
%         dir_sparseCov = '/Users/zahra/Documents/SBU/Thesis/Experiments/Cross study/divide in two New/Schaefer/Yeo networks/dis_con_14_18/1. visual centeral/5. sparseCov/';     
% 
%         output_name_inverseCov = strcat(dir_inverseCov, 'inverseCov_dmnA_',name);
%         save(output_name_inverseCov, 'theta');
%         
%         output_name_sparseCov = strcat(dir_sparseCov, 'sparseCov_dmnA_',name);
%         save(output_name_sparseCov, 'theta_threshold');
% 
%     end
%     clear all
% end

%%
% 2) if inverse cov(i,j)=0 -> corrCoef(i,j)=0 and z(i,j) = 0
% go to folder: inverse sparse covriance, where both inverse sparse covariance and z
% matrices are available

% n = 343;
% for i=1:n
%     name_1_cov = 'SparseCov_dmnA_';
%     name_1_z = 'z_dmnA_';
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
%     name_cov = strcat(name_1_cov, name_2, name_3);
%     name_z = strcat(name_1_z, name_2, name_3);
%     if isfile (name_cov) 
%         load(name_cov);
%         load(name_z);
% 
%         for j=1:24
%             for k=1:24
%                if theta_threshold(j,k)== 0
%                    Z(j,k)=0;
%                end
% 
%             end
%         end
%         
%         sparseZ = Z;
%         
%         dir = '/Users/zahra/Documents/SBU/Thesis/Experiments/Cross study/divide in two New/Schaefer/Yeo networks/dis_con_14_18/1. visual centeral/6. sparseFisherZ/';    
%         output_name = strcat(dir, 'sparseZ_',name_2);
%         save(output_name, 'sparseZ');
%     end
% end

%% 
% 3) Create a single cell for each group
% dir: sparseZ

% n = 343;
% for i=1:n
%     name_1 = 'z_visCent_';
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
%         z{1,i} = Z; 
%     end
% end
% 
% z= z(~cellfun('isempty',z));
%%
% masked the corr coef matrices
% n = 343;
% for i=1:n
%     name_1 = 'corrcoef_';
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
%         for j=1:400
%             for k=1:400
%                 if z_ensamble_con_9_13(j,k) == 0
%                     FC(j,k) = 0;
%                 end
%             end
%         end
%         dir = '/Volumes/ZAHRA5TB/scientificReport/Schaefer/corrCoef/mask for each group/con_9_13/';    
%         output_name = strcat(dir, 'maskedCorr_',name_2);
%         save(output_name, 'FC');
%     end
% end

%%
% t test on each link
% for each run change: number of ROIs, number of subjects

for i=1:24
    for j=1:24
        for sub = 1:25
            temp(1,sub) = z{1,sub}(i,j);
            z_mean_unc(i,j) = mean(temp);
        end
        [h,p,ci,stats] = ttest(temp);
        p_unc(i,j) = p;
    end
end
p_unc(isnan(p_unc))=0;

%Analysis level FDR correction:
p_FDR = reshape(conn_fdr(p_unc(:)),size(p_unc));

for i=1:24
    for j=1:24
        if p_FDR(i,j)<0.05
            z_ensamble(i,j) = z_mean_unc(i,j);
        end
    end
end

%%
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
%         
%         load(name);
%         [u_a,u_b,u_c,u_d] = energy_of_triads_weighted(FC);
%         
%         u_a_con_9_13{1,i} = nonzeros(reshape(u_a, [1,400*400*400]));
%         u_b_con_9_13{1,i} = nonzeros(reshape(u_b, [1,400*400*400]));        
%         u_c_con_9_13{1,i} = nonzeros(reshape(u_c, [1,400*400*400]));
%         u_d_con_9_13{1,i} = nonzeros(reshape(u_d, [1,400*400*400]));
%         
%     end
% end
% 
% u_a_con_9_13 = u_a_con_9_13(~cellfun('isempty',u_a_con_9_13));
% u_b_con_9_13 = u_b_con_9_13(~cellfun('isempty',u_b_con_9_13));
% u_c_con_9_13 = u_c_con_9_13(~cellfun('isempty',u_c_con_9_13));
% u_d_con_9_13 = u_d_con_9_13(~cellfun('isempty',u_d_con_9_13));
% 
% 
% for i=1:56
% u_a_con_9_13_num (1,i) = numel(u_a_con_9_13{1,i});
% u_b_con_9_13_num (1,i) = numel(u_b_con_9_13{1,i});
% u_c_con_9_13_num (1,i) = numel(u_c_con_9_13{1,i});
% u_d_con_9_13_num (1,i) = numel(u_d_con_9_13{1,i});
% end
% 
% 
% mean_a_con_9_13 = mean(u_a_con_9_13_num);
% mean_b_con_9_13 = mean(u_b_con_9_13_num);
% mean_c_con_9_13 = mean(u_c_con_9_13_num);
% mean_d_con_9_13 = mean(u_d_con_9_13_num);
% 
% var_a_con_9_13 = var(u_a_con_9_13_num);
% var_b_con_9_13 = var(u_b_con_9_13_num);
% var_c_con_9_13 = var(u_c_con_9_13_num);
% var_d_con_9_13 = var(u_d_con_9_13_num);
% 
% std_a_con_9_13 = std(u_a_con_9_13_num);
% std_b_con_9_13 = std(u_b_con_9_13_num);
% std_c_con_9_13 = std(u_c_con_9_13_num);
% std_d_con_9_13 = std(u_d_con_9_13_num);
