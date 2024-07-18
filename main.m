%% 1. Create a single z cell for each group's z values

% clear all
% n = 171;
% for i=1:n
%     name_1 = 'corr_adol_';
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
%         corr_adol{1,i} = FC; 
%     end
% end
% 
% corr_adol = corr_adol(~cellfun('isempty',corr_adol));
% save('corr_adol.mat', 'corr_adol');

%% 2. t test on each link of z matrix in all subjects of each group
% clear all
% n_subjects = 73; n_nodes = 25;
% dir = '/Users/zahra/Documents/buffer/asd_9_13/6. dorsal attention B/1. corrCoef/';  
% 
% load ('z.mat');
% for i=1:400
%     for j=1:400
%         for sub =44:101
%             temp(1,sub) = z_harmonized_child{1,sub}(i,j);
%         end
% %         z_mean_unc(i,j) = mean(temp);
%         [h,p,ci,stats] = ttest(temp);
%         p_unc(i,j) = p;
%     end
% end
% p_unc(isnan(p_unc))=0;
% 
% %Analysis level FDR correction:
% p_FDR = reshape(mafdr(p_unc(:)), size(p_unc));
% 
% m = zeros(400,400);
% for i=1:400
%     for j=1:400
%         if (p_FDR(i,j)~= 0) && (p_FDR (i,j) <0.05)
%             m(i,j) = 1;
%         end
%     end
% end
% for i=44:101
%     corr_harmonized_threshold{1,i} = corr_matrices_harmonized_child{1,i}.* m;
% end
% 
% corr_harmonized_threshold = corr_harmonized_threshold(~cellfun('isempty',corr_harmonized_threshold));

% output_name = strcat(dir, 'z_mask');
% save(output_name, 'z_mask');

%% 3. masked the corr coef matrices with z_mask of each group

% clear all
% n = 343;
% load('z_mask.mat');
% 
% n_nodes = 32;
% dir = '/Volumes/ZAHRA5TB/scientificReport/Schaefer/Yeo networks/asd_9_13/15. DMN B/3. sigCorr/'; 
% 
% for i=1:n
%     name_1 = 'corrcoef_dmnA_';
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
%         for j=1:n_nodes
%             for k=1:n_nodes
%                 if z_mask(j,k) == 0
%                     FC(j,k) = 0;
%                 end
%             end
%         end
%            
%         output_name = strcat(dir, 'maskedCorr_',name_2);
%         save(output_name, 'FC');
%     end
% end

%% 4. calculate enery of triads for single level networks, number of each triad 
% n = 343;
% num_subjects = 58;
% num_ROI = 32;
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
% for i=1:43
%     
%         FC = corr_harmonized_threshold_adol_con{1,i};
%         [u_a,u_b,u_c,u_d] = energy_of_triads_weighted(FC);
%         
%         u_a_adol_con{1,i} = nonzeros(reshape(u_a, [1,num_ROI*num_ROI*num_ROI]));
%         if isempty(u_a_adol_con{1,i})
%             u_a_adol_con{1,i} = NaN;
%         end
%         
%         u_b_adol_con{1,i} = nonzeros(reshape(u_b, [1,num_ROI*num_ROI*num_ROI]));  
%         if isempty(u_b_adol_con{1,i})
%             u_b_adol_con{1,i} = NaN;
%         end
%         
%         u_c_adol_con{1,i} = nonzeros(reshape(u_c, [1,num_ROI*num_ROI*num_ROI]));
%         if isempty(u_c_adol_con{1,i})
%             u_c_adol_con{1,i} = NaN;
%         end
%         
%         u_d_adol_con{1,i} = nonzeros(reshape(u_d, [1,num_ROI*num_ROI*num_ROI]));
%         if isempty(u_d_adol_con{1,i})
%             u_d_adol_con{1,i} = NaN;
%         end        
% end
% 
% u_a_adol_con = u_a_adol_con(~cellfun('isempty',u_a_adol_con));
% for i=1:43
%     if isnan(u_a_adol_con{1,i})
%         u_a_adol_con{1,i} =0;
%     end
% end
% 
% u_b_adol_con = u_b_adol_con(~cellfun('isempty',u_b_adol_con));
% for i=1:43
%     if isnan(u_b_adol_con{1,i})
%         u_b_adol_con{1,i} =0;
%     end
% end
% 
% u_c_adol_con = u_c_adol_con(~cellfun('isempty',u_c_adol_con));
% for i=1:43
%     if isnan(u_c_adol_con{1,i})
%         u_c_adol_con{1,i} =0;
%     end
% end
% 
% u_d_adol_con = u_d_adol_con(~cellfun('isempty',u_d_adol_con));
% for i=1:43
%     if isnan(u_d_adol_con{1,i})
%         u_d_adol_con{1,i} =0;
%     end
% end
% 
% a_adol_con = cell2mat(u_a_adol_con');
% b_adol_con = cell2mat(u_b_adol_con');
% c_adol_con = cell2mat(u_c_adol_con');
% d_adol_con = cell2mat(u_d_adol_con');
% % 
% for i=1:97
%     
% num_a_adol_con (1,i) = numel(u_a_adol_con{1,i});
% num_b_adol_con (1,i) = numel(u_b_adol_con{1,i});
% num_c_adol_con (1,i) = numel(u_c_adol_con{1,i});
% num_d_adol_con (1,i) = numel(u_d_adol_con{1,i});

% if u_a_adol_con {1,i} == 0
%     num_a_adol_con (1,i) = 0;
% else
%     num_a_adol_con (1,i) = numel(u_a_adol_con{1,i});
% end


% if u_d_asd_9_13 {1,i} == 0
%     num_d_asd_9_13 (1,i) = 0;
% else
%     num_d_asd_9_13 (1,i) = numel(u_d_asd_9_13{1,i});
% end

% end
% num_a_adol_con = num_a_adol_con';
% num_b_adol_con = num_b_adol_con';
% num_c_adol_con = num_c_adol_con';
% num_d_adol_con = num_d_adol_con';

% % 
% dmnB_a = [num_a_asd_9_13'; num_a_asd_9_13'; num_a_asd_9_13'; num_a_asd_9_13'; num_a_asd_9_13'; num_a_asd_9_13'];
% dmnB_b = [num_b_asd_9_13'; num_b_asd_9_13'; num_b_asd_9_13'; num_b_asd_9_13'; num_b_asd_9_13'; num_b_asd_9_13'];
% dmnB_c = [num_c_asd_9_13'; num_c_asd_9_13'; num_c_asd_9_13'; num_c_asd_9_13'; num_c_asd_9_13'; num_c_asd_9_13'];
% dmnB_d = [num_d_asd_9_13'; num_d_asd_9_13'; num_d_asd_9_13'; num_d_asd_9_13'; num_d_asd_9_13'; num_d_asd_9_13'];
% 
% xlswrite('dmnB_a.csv',dmnB_a);
% xlswrite('dmnB_b.csv',dmnB_b);
% xlswrite('dmnB_c.csv',dmnB_c);
% xlswrite('dmnB_d.csv',dmnB_d);
% 
% mean_a_asd_9_13 = mean(num_a_asd_9_13);
% mean_b_asd_9_13 = mean(num_b_asd_9_13);
% mean_c_asd_9_13 = mean(num_c_asd_9_13);
% mean_d_asd_9_13 = mean(num_d_asd_9_13);
% 
% var_a_asd_9_13 = var(num_a_asd_9_13);
% var_b_asd_9_13 = var(num_b_asd_9_13);
% var_c_asd_9_13 = var(num_c_asd_9_13);
% var_d_asd_9_13 = var(num_d_asd_9_13);
% 
% std_a_asd_9_13 = std(num_a_asd_9_13);
% std_b_asd_9_13 = std(num_b_asd_9_13);
% std_c_asd_9_13 = std(num_c_asd_9_13);
% std_d_asd_9_13 = std(num_d_asd_9_13);

%% 5. bar plots: number of each triads (mean,std)

% a = [mean_a_asd_9_13 mean_a_asd_9_13; mean_a_asd_9_13 mean_a_asd_9_13; mean_a_asd_9_13 mean_a_asd_9_13];
% err_a = [std_a_asd_9_13 std_a_asd_9_13; std_a_asd_9_13 std_a_asd_9_13; std_a_asd_9_13 std_a_asd_9_13];
% figure
% h_a = barwitherr(err_a, a);
% 
% 
% b = [mean_b_asd_9_13 mean_b_asd_9_13; mean_b_asd_9_13 mean_b_asd_9_13; mean_b_asd_9_13 mean_b_asd_9_13];
% err_b = [std_b_asd_9_13 std_b_asd_9_13; std_b_asd_9_13 std_b_asd_9_13; std_b_asd_9_13 std_b_asd_9_13];
% figure
% h_b = barwitherr(err_b, b);
% 
% c = [mean_c_asd_9_13 mean_c_asd_9_13; mean_c_asd_9_13 mean_c_asd_9_13; mean_c_asd_9_13 mean_c_asd_9_13];
% err_c = [std_c_asd_9_13 std_c_asd_9_13; std_c_asd_9_13 std_c_asd_9_13; std_c_asd_9_13 std_c_asd_9_13];
% figure
% h_c = barwitherr(err_c, c);
% 
% d = [mean_d_asd_9_13 mean_d_asd_9_13; mean_d_asd_9_13 mean_d_asd_9_13; mean_d_asd_9_13 mean_d_asd_9_13];
% err_d = [std_d_asd_9_13 std_d_asd_9_13; std_d_asd_9_13 std_d_asd_9_13; std_d_asd_9_13 std_d_asd_9_13];
% h_d = barwitherr(err_d, d);

% [p_a_13_18,h_a_13_18] = ranksum(u_a_asd_9_13_num,u_a_asd_9_13_num);
% [p_b_13_18,h_b_13_18] = ranksum(u_b_asd_9_13_num,u_b_asd_9_13_num);
% [p_c_13_18,h_c_13_18] = ranksum(u_c_asd_9_13_num,u_c_asd_9_13_num);
% [p_d_13_18,h_d_13_18] = ranksum(u_d_asd_9_13_num,u_d_asd_9_13_num);
% 
% [p_a_13_18,h_a_13_18] = ranksum(u_a_asd_9_13_num,u_a_asd_9_13_num);
% [p_b_13_18,h_b_13_18] = ranksum(u_b_asd_9_13_num,u_b_asd_9_13_num);
% [p_c_13_18,h_c_13_18] = ranksum(u_c_asd_9_13_num,u_c_asd_9_13_num);
% [p_d_13_18,h_d_13_18] = ranksum(u_d_asd_9_13_num,u_d_asd_9_13_num);
% 
% [p_a_13_18,h_a_13_18] = ranksum(u_a_asd_9_13_num,u_a_asd_9_13_num);
% [p_b_13_18,h_b_13_18] = ranksum(u_b_asd_9_13_num,u_b_asd_9_13_num);
% [p_c_13_18,h_c_13_18] = ranksum(u_c_asd_9_13_num,u_c_asd_9_13_num);
% [p_d_13_18,h_d_13_18] = ranksum(u_d_asd_9_13_num,u_d_asd_9_13_num);

% asd = [mean_a_asd_9_13 mean_a_asd_9_13 mean_a_asd_9_13; mean_b_asd_9_13 mean_b_asd_9_13 mean_b_asd_9_13; mean_c_asd_9_13 mean_c_asd_9_13 mean_c_asd_9_13; mean_d_asd_9_13 mean_d_asd_9_13 mean_d_asd_9_13];
% err_asd = [std_a_asd_9_13 std_a_asd_9_13 std_a_asd_9_13; std_b_asd_9_13 std_b_asd_9_13 std_b_asd_9_13; std_c_asd_9_13 std_c_asd_9_13 std_c_asd_9_13; std_d_asd_9_13 std_d_asd_9_13 std_d_asd_9_13];
% h_asd = barwitherr(err_asd,asd);
% 
% figure
% asd = [mean_a_asd_9_13 mean_a_asd_9_13 mean_a_asd_9_13; mean_b_asd_9_13 mean_b_asd_9_13 mean_b_asd_9_13; mean_c_asd_9_13 mean_c_asd_9_13 mean_c_asd_9_13; mean_d_asd_9_13 mean_d_asd_9_13 mean_d_asd_9_13];
% err_asd = [std_a_asd_9_13 std_a_asd_9_13 std_a_asd_9_13; std_b_asd_9_13 std_b_asd_9_13 std_b_asd_9_13; std_c_asd_9_13 std_c_asd_9_13 std_c_asd_9_13; std_d_asd_9_13 std_d_asd_9_13 std_d_asd_9_13];
% h_asd = barwitherr(err_asd,asd);

% [p_a_1_asd, h_a_1_asd] = ranksum(u_a_asd_9_13_num,  u_a_asd_9_13_num);
% [p_a_2_asd, h_a_2_asd] = ranksum(u_a_asd_9_13_num, u_a_asd_9_13_num);
% [p_a_3_asd, h_a_3_asd] = ranksum(u_a_asd_9_13_num,  u_a_asd_9_13_num);
% 
% [p_b_1_asd, h_b_1_asd] = ranksum(u_b_asd_9_13_num,  u_b_asd_9_13_num);
% [p_b_2_asd, h_b_2_asd] = ranksum(u_b_asd_9_13_num, u_b_asd_9_13_num);
% [p_b_3_asd, h_b_3_asd] = ranksum(u_b_asd_9_13_num,  u_b_asd_9_13_num);
% 
% 
% [p_c_1_asd, h_c_1_asd] = ranksum(u_c_asd_9_13_num,  u_c_asd_9_13_num);
% [p_c_2_asd, h_c_2_asd] = ranksum(u_c_asd_9_13_num, u_c_asd_9_13_num);
% [p_c_3_asd, h_c_3_asd] = ranksum(u_c_asd_9_13_num,  u_c_asd_9_13_num);
% 
% 
% [p_d_1_asd, h_d_1_asd] = ranksum(u_d_asd_9_13_num,  u_d_asd_9_13_num);
% [p_d_2_asd, h_d_2_asd] = ranksum(u_d_asd_9_13_num, u_d_asd_9_13_num);
% [p_d_3_asd, h_d_3_asd] = ranksum(u_d_asd_9_13_num,  u_d_asd_9_13_num);
% 
% 
% 
% [p_a_1_asd, h_a_1_asd] = ranksum(u_a_asd_9_13_num,  u_a_asd_9_13_num);
% [p_a_2_asd, h_a_2_asd] = ranksum(u_a_asd_9_13_num, u_a_asd_9_13_num);
% [p_a_3_asd, h_a_3_asd] = ranksum(u_a_asd_9_13_num,  u_a_asd_9_13_num);
% 
% [p_b_1_asd, h_b_1_asd] = ranksum(u_b_asd_9_13_num,  u_b_asd_9_13_num);
% [p_b_2_asd, h_b_2_asd] = ranksum(u_b_asd_9_13_num, u_b_asd_9_13_num);
% [p_b_3_asd, h_b_3_asd] = ranksum(u_b_asd_9_13_num,  u_b_asd_9_13_num);
% 
% 
% [p_c_1_asd, h_c_1_asd] = ranksum(u_c_asd_9_13_num,  u_c_asd_9_13_num);
% [p_c_2_asd, h_c_2_asd] = ranksum(u_c_asd_9_13_num, u_c_asd_9_13_num);
% [p_c_3_asd, h_c_3_asd] = ranksum(u_c_asd_9_13_num,  u_c_asd_9_13_num);
% 
% [p_d_1_asd, h_d_1_asd] = ranksum(u_d_asd_9_13_num,  u_d_asd_9_13_num);
% [p_d_2_asd, h_d_2_asd] = ranksum(u_d_asd_9_13_num, u_d_asd_9_13_num);
% [p_d_3_asd, h_d_3_asd] = ranksum(u_d_asd_9_13_num,  u_d_asd_9_13_num);

%% 6. Plot enrgy of each triads (change the code for 9-13 and 13-18 ages as well)
% 
% [u_a_asd_9_13, u_b_asd_9_13,u_c_asd_9_13,u_d_asd_9_13]= energy_of_triads_weighted(groupLevelNet);
% u_a_asd_9_13 = nonzeros(reshape(u_a_asd_9_13, [1,400*400*400]));
% u_b_asd_9_13 = nonzeros(reshape(u_b_asd_9_13, [1,400*400*400]));
% u_c_asd_9_13 = nonzeros(reshape(u_c_asd_9_13, [1,400*400*400]));
% u_d_asd_9_13 = nonzeros(reshape(u_d_asd_9_13, [1,400*400*400]));

% [u_a_asd_9_13, u_b_asd_9_13,u_c_asd_9_13,u_d_asd_9_13]= energy_of_triads_weighted(groupLevelNet);
% u_a_asd_9_13 = nonzeros(reshape(u_a_asd_9_13, [1,400*400*400]));
% u_b_asd_9_13 = nonzeros(reshape(u_b_asd_9_13, [1,400*400*400]));
% u_c_asd_9_13 = nonzeros(reshape(u_c_asd_9_13, [1,400*400*400]));
% u_d_asd_9_13 = nonzeros(reshape(u_d_asd_9_13, [1,400*400*400]));
% 
% figure
% h_a_con_9_13 = histogram(a_con_9_13, 400);
% s_a_con_9_13 = scatter (h_a_con_9_13.BinEdges(1:400), h_a_con_9_13.Values,'b');
% hold on
% h_a_asd_9_13 = histogram(a_asd_9_13, 400);
% s_a_asd_9_13 = scatter (h_a_asd_9_13.BinEdges(1:400), h_a_asd_9_13.Values,'r');
% 
% figure
% h_b_asd_9_13 = histogram(b_asd_9_13, 400);
% s_b_asd_9_13 = scatter (h_b_asd_9_13.BinEdges(1:400), h_b_asd_9_13.Values,'r');
% hold on
% h_b_con_9_13 = histogram(b_con_9_13, 400);
% s_b_con_9_13 = scatter (h_b_con_9_13.BinEdges(1:400), h_b_con_9_13.Values,'b');
% 
% figure
% h_c_asd_9_13 = histogram(c_asd_9_13, 400);
% s_c_asd_9_13 = scatter (h_c_asd_9_13.BinEdges(1:400), h_c_asd_9_13.Values,'r');
% hold on
% h_c_con_9_13 = histogram(c_con_9_13, 400);
% s_c_con_9_13 = scatter (h_c_con_9_13.BinEdges(1:400), h_c_con_9_13.Values,'b');
% 
% figure
% h_d_asd_9_13 = histogram(d_asd_9_13, 400);
% s_d_asd_9_13 = scatter (h_d_asd_9_13.BinEdges(1:400), h_d_asd_9_13.Values,'r');
% hold on
% h_d_con_9_13 = histogram(d_con_9_13, 400);
% s_d_con_9_13 = scatter (h_d_con_9_13.BinEdges(1:400), h_d_con_9_13.Values,'b');

%% 7. Energy of sub networks
% clear all
% n = 343;
% for i=1:n
%     name_1 = 'maskedCorrBinary_';
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
%         u_binary_dmnA_asd_9_13(1,i) = U(FC_binary);
%     end
% end
% 
% u_binary_dmnA_asd_9_13 = nonzeros(u_binary_dmnA_asd_9_13);
% save('/Volumes/ZAHRA5TB/scientificReport/Schaefer/Yeo networks/energy_BinaryMaskedCorr_individuals/u_binary_dmnA_asd_9_13.mat','u_binary_dmnA_asd_9_13');

%% %% 8. Energy of whole-brain network
% clear all
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
%         u_asd_9_13(1,i) = U(FC);
%     end
% end
% 
% u_asd_9_13 = nonzeros(u_asd_9_13);
% 
% save('/Users/zahra/Documents/scientificReport/Data/Schaefer/whole-barin network/energy/u_asd_9_13.mat','u_asd_9_13');

%% 9. PLOT ENERGY DISTRIBUTION OF triads
% 
% load('u_triads_maskedCorr_individuals_asd_9_13.mat');
% load('u_triads_maskedCorr_individuals_asd_9_13.mat');
% 
% num_subjects_asd = 18;
% num_subjects_asd = 20;
% 
% for i=1:num_subjects_asd
%     u_a_asd_9_13{1,i}=u_a_asd_9_13{1,i}';
%     u_b_asd_9_13{1,i}=u_b_asd_9_13{1,i}';
%     u_c_asd_9_13{1,i}=u_c_asd_9_13{1,i}';
%     u_d_asd_9_13{1,i}=u_d_asd_9_13{1,i}';
% end
% for i=1:num_subjects_asd
%     u_a_asd_9_13{1,i}=u_a_asd_9_13{1,i}';
%     u_b_asd_9_13{1,i}=u_b_asd_9_13{1,i}';
%     u_c_asd_9_13{1,i}=u_c_asd_9_13{1,i}';
%     u_d_asd_9_13{1,i}=u_d_asd_9_13{1,i}';
% end
% 
% u_a_asd_9_13 = [u_a_asd_9_13{:}]; u_a_asd_9_13 = [u_a_asd_9_13{:}];
% u_b_asd_9_13 = [u_b_asd_9_13{:}]; u_b_asd_9_13 = [u_b_asd_9_13{:}];
% u_c_asd_9_13 = [u_c_asd_9_13{:}]; u_c_asd_9_13 = [u_c_asd_9_13{:}];
% u_d_asd_9_13 = [u_d_asd_9_13{:}]; u_d_asd_9_13 = [u_d_asd_9_13{:}];
% 

% 
% figure
% h_a_asd_13_18 = histogram(a_asd_13_18, 400);
% s_a_asd_13_18 = scatter (h_a_asd_13_18.BinEdges(1:400), h_a_asd_13_18.Values,'b');
% hold on
% h_a_asd_13_18 = histogram(a_asd_13_18, 400);
% s_a_asd_13_18 = scatter (h_a_asd_13_18.BinEdges(1:400), h_a_asd_13_18.Values,'r');
% title('A 13-18');
% 
% figure
% h_b_asd_13_18 = histogram(b_asd_13_18, 400);
% s_b_asd_13_18 = scatter (h_b_asd_13_18.BinEdges(1:400), h_b_asd_13_18.Values,'b');
% hold on
% h_b_asd_13_18 = histogram(b_asd_13_18, 400);
% s_b_asd_13_18 = scatter (h_b_asd_13_18.BinEdges(1:400), h_b_asd_13_18.Values,'r');
% title('B 13-18');
% 
% figure
% h_c_asd_13_18 = histogram(c_asd_13_18, 400);
% s_c_asd_13_18 = scatter (h_c_asd_13_18.BinEdges(1:400), h_c_asd_13_18.Values,'b');
% hold on
% h_c_asd_13_18 = histogram(c_asd_13_18, 400);
% s_c_asd_13_18 = scatter (h_c_asd_13_18.BinEdges(1:400), h_c_asd_13_18.Values,'r');
% title('C 13-18');
% 
% figure
% h_d_asd_13_18 = histogram(d_asd_13_18, 400);
% s_d_asd_13_18 = scatter (h_d_asd_13_18.BinEdges(1:400), h_d_asd_13_18.Values,'b');
% hold on
% h_d_asd_13_18 = histogram(d_asd_13_18, 400);
% s_d_asd_13_18 = scatter (h_d_asd_13_18.BinEdges(1:400), h_d_asd_13_18.Values,'r');
% title('D 13-18');

 %% Plot triads energy distribution with with big marker
% figure
% h_a_asd_9_13 = histogram(a_asd_9_13, 400);
% s_a_asd_9_13 = scatter (h_a_asd_9_13.BinEdges(1:400), h_a_asd_9_13.Values,'b','s',...
%     'MarkerEdgeColor',[18/255 54/255 36/255],'MarkerFaceColor',[0 1 0],'LineWidth', 1);
% s_a_asd_9_13.SizeData = 150;
% hold on
% h_a_con_9_13 = histogram(a_con_9_13, 400);
% s_a_con_9_13 = scatter (h_a_con_9_13.BinEdges(1:400), h_a_con_9_13.Values,'r','^',...
%     'MarkerEdgeColor',[126/255 47/255 142/255],'MarkerFaceColor',[1 0 1],'LineWidth', 1);
% s_a_con_9_13.SizeData = 150;
% %set(gca,'xscale','log');
% %set(gca,'yscale','log');
% % set(gca, 'FontSize', 20)
% alpha(0.4);

%% Average of corrs using t test (t statistic as the value)
% n = 343;
% for i=1:n
%     name_1 = 'z_';
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
%         z_asd_9_13{1,i} = Z;
%     end
% end
% z_asd_9_13 = z_asd_9_13(~cellfun('isempty',z_asd_9_13));
% 
% num_ROI = 400;
% num_subjects = 20;
% 
% for i=1:num_ROI
%     for j=1:num_ROI
%         for sub = 1:num_subjects
%             buffer(1,sub) = z_asd_9_13{1,sub}(i,j);
%             
%         end
%         [h,p,ci,stats] = ttest(buffer);
%         p_unc(i,j) = p;
%         tstat(i,j)=stats.tstat;
%     end
% end
% p_unc(isnan(p_unc))=0;
% tstat(isnan(tstat))=0;
% 
% %Analysis level FDR correction:
% p_FDR = reshape(asdn_fdr(p_unc(:)),size(p_unc));
% 
% for i=1:num_ROI
%     for j=1:num_ROI
%         if p_FDR(i,j)<0.05
%             t_ensamble_asd_9_13(i,j) = tstat(i,j);
%         end
%     end
% end

%% KL divergence

% [u_a_asd_9_13, u_b_asd_9_13, u_c_asd_9_13, u_d_asd_9_13] = energy_of_triads_weighted(ensamble_mean_asd_9_13);
% u_a_asd_9_13 = nonzeros(reshape(u_a_asd_9_13, [1,400*400*400]));
% u_b_asd_9_13 = nonzeros(reshape(u_b_asd_9_13, [1,400*400*400]));        
% u_c_asd_9_13 = nonzeros(reshape(u_c_asd_9_13, [1,400*400*400]));        
% u_d_asd_9_13 = nonzeros(reshape(u_d_asd_9_13, [1,400*400*400]));
% 
% [u_a_asd_9_13, u_b_asd_9_13, u_c_asd_9_13, u_d_asd_9_13] = energy_of_triads_weighted(ensamble_mean_asd_9_13);
% u_a_asd_9_13 = nonzeros(reshape(u_a_asd_9_13, [1,400*400*400]));
% u_b_asd_9_13 = nonzeros(reshape(u_b_asd_9_13, [1,400*400*400]));        
% u_c_asd_9_13 = nonzeros(reshape(u_c_asd_9_13, [1,400*400*400]));        
% u_d_asd_9_13 = nonzeros(reshape(u_d_asd_9_13, [1,400*400*400]));
% 
% A
% figure;
% h_d_adol_con = histogram(d_adol_con);
% hold on
% h_d_adol_con = histogram(d_adol_con, h_d_adol_con.NumBins);
% 
% 
% dist_d_adol_con = h_d_adol_con.Values / sum(h_d_adol_con.Values);
% dist_d_adol_con = h_d_adol_con.Values / sum(h_d_adol_con.Values);
% 
% 
% for i=1:h_d_adol_con.NumBins
%     if dist_d_adol_con(1,i) == 0
%         dist_d_adol_con(1,i) = 1e-10;
%     end
%     if dist_d_adol_con(1,i) == 0
%         dist_d_adol_con(1,i) = 1e-10;
%     end
% end
% 
% d_d_adol_con = 0;
% d_d_adol_con = 0;
% 
% for i=1:h_d_adol_con.NumBins
%     d_d_adol_con = d_d_adol_con+ (dist_d_adol_con(1,i) * (log(dist_d_adol_con(1,i) / dist_d_adol_con(1,i))));
%     d_d_adol_con = d_d_adol_con+ (dist_d_adol_con(1,i) * (log(dist_d_adol_con(1,i) / dist_d_adol_con(1,i))));
% end
% J_distance_d_child = d_d_adol_con + d_d_adol_con;
% 
% 
% % B
% figure
% h_b_asd_9_13 = histogram(b_asd_9_13);
% hold on
% h_b_asd_9_13 = histogram(b_asd_9_13, h_b_asd_9_13.NumBins);
% 
% dist_b_asd_9_13 = h_b_asd_9_13.Values / sum(h_b_asd_9_13.Values);
% dist_b_asd_9_13 = h_b_asd_9_13.Values / sum(h_b_asd_9_13.Values);
% 
% for i=1:h_b_asd_9_13.NumBins
%     if dist_b_asd_9_13(1,i) == 0
%         dist_b_asd_9_13(1,i) = 1e-10;
%     end
%     if dist_b_asd_9_13(1,i) == 0
%         dist_b_asd_9_13(1,i) = 1e-10;
%     end
% end
% 
% d_b_13_18_1 = 0;
% d_b_13_18_2 = 0;
% for i=1:h_b_asd_9_13.NumBins
%     d_b_13_18_1 = d_b_13_18_1+ (dist_b_asd_9_13(1,i) * log(dist_b_asd_9_13(1,i) / dist_b_asd_9_13(1,i)));
%     d_b_13_18_2 = d_b_13_18_2+ (dist_b_asd_9_13(1,i) * log(dist_b_asd_9_13(1,i) / dist_b_asd_9_13(1,i)));
% end
% J_distance_b_13_18 = d_b_13_18_1 + d_b_13_18_2;
% 
% % C
% figure
% h_c_asd_9_13 = histogram(c_asd_9_13);
% hold on
% h_c_asd_9_13 = histogram(c_asd_9_13, h_c_asd_9_13.NumBins);
% 
% dist_c_asd_9_13 = h_c_asd_9_13.Values / sum(h_c_asd_9_13.Values);
% dist_c_asd_9_13 = h_c_asd_9_13.Values / sum(h_c_asd_9_13.Values);
% 
% for i=1:h_c_asd_9_13.NumBins
%     if dist_c_asd_9_13(1,i) == 0
%         dist_c_asd_9_13(1,i) = 1e-10;
%     end
%     if dist_c_asd_9_13(1,i) == 0
%         dist_c_asd_9_13(1,i) = 1e-10;
%     end
% end
% 
% d_c_13_18_1 = 0;
% d_c_13_18_2 = 0;
% for i=1:h_c_asd_9_13.NumBins
%     d_c_13_18_1 = d_c_13_18_1+ (dist_c_asd_9_13(1,i) * log(dist_c_asd_9_13(1,i) / dist_c_asd_9_13(1,i)));
%     d_c_13_18_2 = d_c_13_18_2+ (dist_c_asd_9_13(1,i) * log(dist_c_asd_9_13(1,i) / dist_c_asd_9_13(1,i)));
% end
% 
% J_distance_c_13_18 = d_c_13_18_1 + d_c_13_18_2;
% 
% % D
% figure
% h_d_asd_9_13 = histogram(d_asd_9_13);
% hold on
% h_d_asd_9_13 = histogram(d_asd_9_13, h_d_asd_9_13.NumBins);
% 
% dist_d_asd_9_13 = h_d_asd_9_13.Values / sum(h_d_asd_9_13.Values);
% dist_d_asd_9_13 = h_d_asd_9_13.Values / sum(h_d_asd_9_13.Values);
% 
% for i=1:h_d_asd_9_13.NumBins
%     if dist_d_asd_9_13(1,i) == 0
%         dist_d_asd_9_13(1,i) = 1e-10;
%     end
%     if dist_d_asd_9_13(1,i) == 0
%         dist_d_asd_9_13(1,i) = 1e-10;
%     end
% end
% 
% d_d_13_18_1 = 0;
% d_d_13_18_2 = 0;
% for i=1:h_d_asd_9_13.NumBins
%     d_d_13_18_1 = d_d_13_18_1+ (dist_d_asd_9_13(1,i) * log(dist_d_asd_9_13(1,i) / dist_d_asd_9_13(1,i)));
%     d_d_13_18_2 = d_d_13_18_2+ (dist_d_asd_9_13(1,i) * log(dist_d_asd_9_13(1,i) / dist_d_asd_9_13(1,i)));
% end
% 
% J_distance_d_13_18 = d_d_13_18_1 + d_d_13_18_2;

%% Sparsity percentage

% clear all
% total_links = ((400*400)-400) / 2;
% 
% load('ensamble_tstat_asd_9_13.mat'); load('ensamble_tstat_asd_9_13.mat');
% load('ensamble_tstat_asd_9_13.mat'); load('ensamble_tstat_asd_9_13.mat');
% load('ensamble_tstat_asd_9_13.mat'); load('ensamble_tstat_asd_9_13.mat');
% 
% [pos_asd_9_13, neg_asd_9_13, zeros_asd_9_13,flag_asd_9_13]= pos_neg(t_ensamble_asd_9_13,400);
% [pos_asd_9_13, neg_asd_9_13, zeros_asd_9_13,flag_asd_9_13]= pos_neg(t_ensamble_asd_9_13,400);
% [pos_asd_9_13, neg_asd_9_13, zeros_asd_9_13,flag_asd_9_13]= pos_neg(t_ensamble_asd_9_13,400);
% 
% [pos_asd_9_13, neg_asd_9_13, zeros_asd_9_13,flag_asd_9_13]= pos_neg(t_ensamble_asd_9_13,400);
% [pos_asd_9_13, neg_asd_9_13, zeros_asd_9_13,flag_asd_9_13]= pos_neg(t_ensamble_asd_9_13,400);
% [pos_asd_9_13, neg_asd_9_13, zeros_asd_9_13,flag_asd_9_13]= pos_neg(t_ensamble_asd_9_13,400);
% 
% sparsity_asd_9_13 = (pos_asd_9_13 + neg_asd_9_13)/total_links;
% sparsity_asd_9_13 = (pos_asd_9_13 + neg_asd_9_13)/total_links;
% sparsity_asd_9_13 = (pos_asd_9_13 + neg_asd_9_13)/total_links;
% 
% sparsity_asd_9_13 = (pos_asd_9_13 + neg_asd_9_13)/total_links;
% sparsity_asd_9_13 = (pos_asd_9_13 + neg_asd_9_13)/total_links;
% sparsity_asd_9_13 = (pos_asd_9_13 + neg_asd_9_13)/total_links;

%% pos neg links for individuals
% n = 343;
% for i=1:n
%   
%     name = strcat('maskedCorr_', num2str('%03i', i), '.mat');
%     if isfile (name)
%         load(name);
%         [pos_asd_9_13(1,i), neg_asd_9_13(1,i), zeros_asd_9_13(1,i), flag_asd_9_13(1,i)]=pos_neg(FC,400);
%     end
%     
% end
% pos_asd_9_13 = nonzeros(pos_asd_9_13); neg_asd_9_13=nonzeros(neg_asd_9_13); 
% zeros_asd_9_13=nonzeros(zeros_asd_9_13); flag_asd_9_13=nonzeros(flag_asd_9_13);

%% binary networks
% clear all
% n = 343;
% dir = '/Volumes/ZAHRA5TB/scientificReport/Schaefer/Yeo networks/asd_9_13/14. DMN A/3. sigCorr/';
% ROI_num = 34;
% 
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
%         for j=1:ROI_num
%             for k=1:ROI_num
%                 if FC(j,k)>0
%                     FC_binary(j,k) = 1;
%                 elseif FC(j,k)<0
%                     FC_binary(j,k) = -1;
%                 elseif FC(j,k) == 0
%                     FC_binary(j,k) = 0;
%                 end
%             end
%         end
%         
%         output_name = strcat(dir, 'maskedCorrBinary_',name_2);
%         save(output_name, 'FC_binary');
%     end
% end
% 
%% Simple averaging on masked corrs as group-level networks
% clear all
% n_subjects =20; 
% roi_num = 400;
% groupLevelNet = zeros(roi_num, roi_num);
% 
% for i=1:343
%     name_1 = 'maskedCorr_';
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
%         for j=1:roi_num
%             for k=1:roi_num
%                 groupLevelNet(j,k) = groupLevelNet(j,k) + FC(j,k);
%             end
%         end
%     end
% end
% 
% groupLevelNet = groupLevelNet / n_subjects;
% 
%% cut off Nodes
% n_subjects = 20; 
% roi_num = 400;
% label = Schaefer400_labelNum;
% 
% for i=1:343
%     name_1 = 'maskedCorr_';
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
%         
%         [u,u_d,u,u_d] = energy_of_triads_weighted(FC);
%         
%         cutOff_3d_u_d = zeros(400,400,400);
%         cutOff_adjMatrix_u_d = zeros(400,400);
% 
%         for j=1:400
%             for k=1:400
%                 for l=1:400
%                     if u_d(j,k,l) <= -0.32
% %                     if u_b(i,j,k) >= 0.0001 && u_b(i,j,k) < 0.01
%         %             if u_b_asd_9_13(i,j,k) >= 0.0002 && u_b_asd_9_13(i,j,k) < 0.0004
%         %             if u_b_asd_9_13(i,j,k) >= 0.0004 && u_b_asd_9_13(i,j,k) < 0.00092
%         %             if u_b_asd_9_13(i,j,k) >= 0.0006 && u_b_asd_9_13(i,j,k) < 0.00092
%         %             if u_b_asd_9_13(i,j,k) >= 0.00092
%                        cutOff_3d_u_d(j,k,l) = u_d(j,k,l);
%                        
%                        if cutOff_3d_u_d(j,k,l) ~= 0
%                         cutOff_adjMatrix_u_d(j,k) = FC (j,k);
%                         cutOff_adjMatrix_u_d(j,l) = FC (j,l);
%                         cutOff_adjMatrix_u_d(k,l) = FC (k,l);
%                        end
%                        
%                     end
% 
%                 end
%             end
%         end
%         
%         % a)size of each node
%         G = graph(cutOff_adjMatrix_u_d, 'upper');
%         deg{1,i} = degree(G);
% 
%         % b) color of each node:
%         color{1,i} = zeros(400,1);
% 
%         for j=1:400
%             for k=1:400
%                 for l=1:400
%                     if cutOff_3d_u_d (j,k,l) ~=0
%                         color{1,i}(j,1) = color{1,i}(j,1) +cutOff_3d_u_d(j,k,l);
%                         color{1,i}(k,1) = color{1,i}(k,1) +cutOff_3d_u_d(j,k,l);
%                         color{1,i}(l,1) = color{1,i}(l,1) +cutOff_3d_u_d(j,k,l);       
%                     end
% 
%                 end
%             end
%         end
%         
%         % normalize the color
%         for j=1:400
%             if deg{1,i}(j,1) ~= 0
%                 color{1,i}(j,1) = color{1,i}(j,1) / (deg{1,i}(j,1) - 1);
%             end
%         end
%   
%     end
%     
% end
% 
% color= color(~cellfun('isempty',color));
% deg= deg(~cellfun('isempty',deg));
% color = cell2mat(color);
% deg = cell2mat(deg);
% 
% for i=1:n_subjects
%     color (i,1) = sum(color(i,:));
%     deg (i,1) = sum(deg(i,:));
% end
% 
% for i=1:400
%     color_asd_9_13(i,1) = sum(color(i,:));
%     degree_asd_9_13(i,1) = sum(deg(i,:));
%     
% end
% % create the .node format
% 
% color_asd_9_13 = -1 * color_asd_9_13; % For D triads so that color map work on the positive values from small (blue) to big (purple)
% xyzColor = [Schaefer400_xyz color_asd_9_13];
% xyzColorSize = [xyzColor degree_asd_9_13];
% 
% xyzColorSize = num2str(xyzColorSize);
% b_threshold_asd_9_13 = strcat(strcat(xyzColorSize, "            "),label);
% b_threshold_asd_9_13 = char(b_threshold_asd_9_13);
% dlmwrite('cutOff_asd_9_13_d_u.node',b_threshold_asd_9_13,'delimiter','');

%% Cut offs Edges
% n_subjects = 20; 
% roi_num = 400;
% % label = Schaefer400_labelNum;
% 
% for i=1:343
%     name_1 = 'maskedCorr_';
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
%      
%         [u,u,u,u_d] = energy_of_triads_weighted(FC);
%         
%         cutOff_3d_u_d = zeros(400,400,400);
%         cutOff_adjMatrix_u_d{1,i} = zeros(400,400);
% 
%         for j=1:400
%             for k=1:400
%                 for l=1:400
%                     if u_d(j,k,l) <= -0.32
% %                     if u_b(i,j,k) >= 0.0001 && u_b(i,j,k) < 0.01
%         %             if u_b_asd_9_13(i,j,k) >= 0.0002 && u_b_asd_9_13(i,j,k) < 0.0004
%         %             if u_b_asd_9_13(i,j,k) >= 0.0004 && u_b_asd_9_13(i,j,k) < 0.00092
%         %             if u_b_asd_9_13(i,j,k) >= 0.0006 && u_b_asd_9_13(i,j,k) < 0.00092
%         %             if u_b_asd_9_13(i,j,k) >= 0.00092
%                        cutOff_3d_u_d(j,k,l) = u_d(j,k,l);
%                        
%                        if cutOff_3d_u_d(j,k,l) ~= 0
%                         cutOff_adjMatrix_u_d{1,i}(j,k) = FC (j,k);
%                         cutOff_adjMatrix_u_d{1,i}(j,l) = FC (j,l);
%                         cutOff_adjMatrix_u_d{1,i}(k,l) = FC (k,l);
%                        end
%                        
%                     end
% 
%                 end
%             end
%         end
%     end
% end
% cutOff_adjMatrix_u_d= cutOff_adjMatrix_u_d(~cellfun('isempty',cutOff_adjMatrix_u_d));
% 
% %sum over all adj
% cutOff_adjMatrix_u_d_average = zeros(400,400);
% 
% for i=1:roi_num
%     for j=1:roi_num
%         for k=1:n_subjects    
%             cutOff_adjMatrix_u_d_average(i,j) = cutOff_adjMatrix_u_d_average(i,j) + cutOff_adjMatrix_u_d{1,k}(i,j);
%         end
%     end
% end
% dlmwrite('cutOff_asd_9_13_d<-0.32.edge',cutOff_adjMatrix_u_d_average,'delimiter','   ');

%% save to txt
% clear all
% for i=1:97
%     name_1 = 'corr_sal_cont_adol_con_';
%     name_2 = num2str(i, '%03i');
% %     if i<10
% %         temp = {'00', num2str(i)};
% %         name_2 = strcat(temp{1,1},temp{1,2});
% %     elseif i<100
% %         temp = {'0', num2str(i)};
% %         name_2 = strcat(temp{1,1},temp{1,2});
% %     else
% %         name_2 = num2str(i);
% %     end
%     name_3 = '.mat';
%     txt = '.txt';
%     dir = '/Users/zahra/Documents/Energy lags/denoised_data/corr_threshold_ttest/subnetworks/txt/salcont/adol_con/';
%     name_in = strcat(name_1, name_2, name_3);
%     name_out = strcat(dir, name_1, name_2, txt);
%     
% %     if isfile (name_in)
% %         load(name_in);
%     FC = sal_cont_adol_con{1,i};
%     save(name_out, 'FC', '-ascii');
%     
% %     end
% end

%% ComBat Harmonization
% 
% %set the input
% dat_adult = zeros(79800, 101);
% 
% for i=1:101
% 
%     A = corr_adult{1,i};
%     m = tril(true(size(A)), -1);
%     v = A(m);
%     dat_adult(:,i) = v;
%         
% end

% remove repetitions
% repet= zeros(79800,1);
% for i = 1:79800
%     index = 1;
%     a = dat(i,1);
%     for j=2:258
%         
%         if dat(i,j) == a
%             index = index + 1;
%         end
% 
%     end
%     if index == 258
%         repet(i,1) = i;
%     end
% end
% 
% repet = nonzeros(repet);
% 
% j=1;
% for i=1:79800
%     if ~(any(repet(:) == i))
%         dat_revised(j,:) = dat(i,:);
%         j = j+1;
%     end
% end

% % run comBat
% dat = dat_adult;
% batch = site_adult;
% mod = mod_adult;
% dat_harmonized = combat(dat, batch, mod, 1);
% 
% % recreate table 2 from yu 2018.
% % what percent of FCs are significantly different across sites.
% % we do it first on original FCs / then on harmonized FCs. then we computer
% % percentages of p value above 0.05
% 

% p = zeros(79800, 1); 
% p_harmonized = zeros(79800, 1); 
% h = cell(79800, 1); 
% h_harmonized = cell(79800, 1); 
% 
% for i=1:79800
%     [p(i,1), h{i,1}] = kruskalwallis(dat_adult(i,:),site_adult, 'off');
%     [p_harmonized(i,1), h_harmonized{i,1}] = kruskalwallis(dat_harmonized_adult(i,:),site_adult, 'off');
% end
% 
% p_FDR = mafdr(p);
% p_FDR_harmonized = mafdr(p_harmonized);
% 
% % compute FC percentage with p_fdr < 0.05 (before and after harmonization)
% % 
% n_sig_differ = 0; 
% n_sig_differ_harmonized = 0;
% 
% for i=1:79800
%     if p_FDR(i,1) < 0.05
%         n_sig_differ = n_sig_differ + 1;
%     end
%     if p_FDR_harmonized(i,1) < 0.05
%         n_sig_differ_harmonized = n_sig_differ_harmonized + 1;
%     end    
% end
% 
% percent_sig_differ = (n_sig_differ / 79800);
% percent_sig_differ_harmonized = (n_sig_differ_harmonized / 79800);
% 
% % % return back from harmonized vector to corr matrix
% % 
% corr_harmonized_adult = cell(1,80);
% for i=1:80
%     a = tril(ones(400), -1);
%     a(a > 0) = dat_harmonized_adult(:,i);
%     a = tril(a) + tril(a, -1)';
%     corr_harmonized_adult{1,i} = a;  
% end

%% YEO subnetworks directly from corr_harmonized_threshold

% for i=1:58
%     
%     FC = corr_harmonized_threshold_adol_con{1,i};
%     
%     FC_salA_adol_con{1,i} = [FC(86:100, 86:100) , FC(86:100,285:303); FC(285:303, 86:100),FC(285:303, 285:303)];
%     FC_salB_adol_con{1,i} = [FC(101:108, 101:108) , FC(101:108, 304:312); FC(304:312, 101:108), FC(304:312, 304:312)];
%     
%     FC_contA_adol_con{1,i} = [FC(121:133, 121:133) , FC(121:133, 325:335); FC(325:335, 121:133), FC(325:335, 325:335)];
%     FC_contB_adol_con{1,i} = [FC(134:143, 134:143) , FC(134:143, 336:350); FC(336:350, 134:143), FC(336:350, 336:350)];
%     FC_contC_adol_con{1,i} = [FC(144:148, 144:148) , FC(144:148, 351:357); FC(351:357, 144:148), FC(351:357, 351:357)];
%    
%     FC_dmnA_adol_con{1,i} = [FC(149:166, 149:166) , FC(149:166, 358:373); FC(358:373, 149:166), FC(358:373, 358:373)];
%     FC_dmnB_adol_con{1,i} = [FC(167:187, 167:187) , FC(167:187, 374:384); FC(374:384, 167:187), FC(374:384, 374:384)];
%     FC_dmnC_adol_con{1,i} = [FC(188:194, 188:194) , FC(188:194, 385:390); FC(385:390, 188:194), FC(385:390, 385:390)];
%     
% end  

% all A, B, C subnetworks in one subnetwork

% for i=1:58
%     
%     FC = corr_harmonized_threshold_adol_con{1,i};
%     
%     FC_sal_adol_con{1,i} = [FC(86:108, 86:108) , FC(86:108,285:312); FC(285:312, 86:108),FC(285:312, 285:312)];
%     
%     FC_cont_adol_con{1,i} = [FC(121:148, 121:148) , FC(121:148, 325:357); FC(325:357, 121:148), FC(325:357, 325:357)];
%    
%     FC_dmn_adol_con{1,i} = [FC(149:194, 149:194) , FC(149:194, 358:390); FC(358:390, 149:194), FC(358:390, 358:390)];
%     
% end 

% % sal dmn network
% for i=1:97
%     
%     FC = corr_harmonized_threshold_adol_con{1,i};
%     
%     sal_dmn_adol_con{1,i} =[...
%     FC(86:108,  86:108), FC(86:108, 149:194),  FC(86:108, 285:312),  FC(86:108, 358:390);...
%     FC(149:194, 86:108), FC(149:194, 149:194), FC(149:194, 285:312), FC(149:194, 358:390);...
%     FC(285:312, 86:108), FC(285:312, 149:194), FC(285:312, 285:312), FC(285:312, 358:390);...
%     FC(358:390, 86:108), FC(358:390, 149:194), FC(358:390, 285:312), FC(358:390, 358:390)];
% 
% end

% % sal cont network
% for i=1:97
%     
%     FC = corr_harmonized_threshold_adol_con{1,i};
%     
%     sal_cont_adol_con{1,i} =[...
%     FC(86:108,  86:108), FC(86:108, 121:148),  FC(86:108, 285:312),  FC(86:108, 325:357);...
%     FC(121:148, 86:108), FC(121:148, 121:148), FC(121:148, 285:312), FC(121:148, 325:357);...
%     FC(285:312, 86:108), FC(285:312, 121:148), FC(285:312, 285:312), FC(285:312, 325:357);...
%     FC(325:357, 86:108), FC(325:357, 121:148), FC(325:357, 285:312), FC(325:357, 325:357)];
% 
% end

% cont and dmn network
% for i=1:97
%     
%     FC = corr_harmonized_threshold_adol_con{1,i};
%    
%     cont_dmn_adol_con{1,i} =[...
%     FC(121:194, 121:194), FC(121:194, 325:390);...
%     FC(325:390, 121:194), FC(325:390, 325:390)];
% 
% end

% dmns sals and conts all in one network, hat is, triple model of autism
% for i=1:97
%     
%     FC = corr_harmonized_threshold_adol_con{1,i};
%     
%     triple_net_adol_con{1,i} =[...
%     FC(86:108,  86:108), FC(86:108, 121:194),  FC(86:108, 285:312),  FC(86:108, 325:390);...
%     FC(121:194, 86:108), FC(121:194, 121:194), FC(121:194, 285:312), FC(121:194, 325:390);...
%     FC(285:312, 86:108), FC(285:312, 121:194), FC(285:312, 285:312), FC(285:312, 325:390);...
%     FC(325:390, 86:108), FC(325:390, 121:194), FC(325:390, 285:312), FC(325:390, 325:390)];
% 
% end

%% calculate subnetworks energies

% for i=1:58
%     u_contA_adol_con(i,1) = U(FC_contA_adol_con{1,i});
%     u_contB_adol_con(i,1) = U(FC_contB_adol_con{1,i});
%     u_contC_adol_con(i,1) = U(FC_contC_adol_con{1,i});
%     u_salA_adol_con(i,1) = U(FC_salA_adol_con{1,i});
%     u_salB_adol_con(i,1) = U(FC_salB_adol_con{1,i});
%     u_dmnA_adol_con(i,1) = U(FC_dmnA_adol_con{1,i});
%     u_dmnB_adol_con(i,1) = U(FC_dmnB_adol_con{1,i});
%     u_dmnC_adol_con(i,1) = U(FC_dmnC_adol_con{1,i});
% end

%% box plots
% u_normal_adol_con = u_normal_adol_con';
% u_normal_adol_con = u_normal_adol_con';
% u_normal_adol_con = u_normal_adol_con';
% u_normal_adol_con = u_normal_adol_con';
% figure
% group = [ones(size(u_normal_adol_con)); 2*ones(size(u_normal_adol_con)); 3*ones(size(u_normal_adol_con)); 4*ones(size(u_normal_adol_con))];
% boxplot([u_normal_adol_con; u_normal_adol_con ; u_normal_adol_con ; u_normal_adol_con], group)
% set(gca, 'XTickLabel', {'childhood con','adolescence con', 'childhood asd','adolescence asd'}) 
% 
% colorful boxs
% figure
% boxplot([energy_thresh_child(1,1:43); energy_thresh_child(2,1:43); energy_thresh_child(3,1:43); energy_thresh_child(4,1:43); energy_thresh_child(5,1:43); energy_thresh_child(6,1:43); energy_thresh_child(7,1:43); energy_thresh_child(8,1:43); energy_thresh_child(9,1:43)], group_child_asd);
% h = findobj(gca, 'Tag' , 'Box');
% for j=1:length(h)
%   patch(get(h(j), 'XData'), get(h(j), 'YData'), colors(j,:), 'FaceAlpha' , 0.5);
% end

