% codes for Frontiers physiology 
% 8/Bahman/98

%% FC measures
% clear all
% load('ts_ses1.mat');
% load('ts_ses2.mat');

% for i=1:38 
    
%     covariance_ses1{1,i} = cov(ts_ses1{1,i});
%     
%     corrCoef_ses1{1,i} = corrcoef(ts_ses1{1,i});
%     corrCoef_ses1{1,i}(isnan(corrCoef_ses1{1,i})) = 0;
%     
%     fisherZ_ses1{1,i} = atanh (corrCoef_ses1{1,i});
%     fisherZ_ses1{1,i}(isinf(fisherZ_ses1{1,i})) = 1;
%     
%     u_ses1(1,i) = U(corrCoef_ses1{1,i});
% 
%     covariance_ses2{1,i} = cov(ts_ses2{1,i});
%     
%     corrCoef_ses2{1,i} = corrcoef(ts_ses2{1,i});
%     corrCoef_ses2{1,i}(isnan(corrCoef_ses2{1,i})) = 0;
% 
%     fisherZ_ses2{1,i} = atanh (corrCoef_ses2{1,i});
%     fisherZ_ses2{1,i}(isinf(fisherZ_ses2{1,i})) = 1;
%     
%     u_ses2(1,i) = U(corrCoef_ses2{1,i});    
              
%     
% end

%% T test
% for i=1:116
%     for j=1:116
%         for sub = 1:12
%             temp(1,sub) = z_control_ses2{1,sub}(i,j);
%             z_mean_unc(i,j) = mean(temp);
%         end
%         [h,p,ci,stats] = ttest(temp);
%         p_unc(i,j) = p;
%     end
% end
% p_unc(isnan(p_unc))=0;
% % 
% % %Analysis level FDR correction:
% % p_FDR = reshape(conn_fdr(p_unc(:)),size(p_unc));
% % 
% for i=1:116
%     for j=1:116
%         if p_unc(i,j)<0.05
%             z_ensamble_con_ses2(i,j) = z_mean_unc(i,j);
%         end
%     end
% end
% z_ensamble_con_ses2(isnan(z_ensamble_con_ses2))= 1;

%% pos neg links


total_links = ((116*116)-116) / 2;

%asd

neg_asd_ses1 = 0; pos_asd_ses1=0; zeros_asd_ses1 = 0;
neg_asd_ses2 = 0; pos_asd_ses2=0; zeros_asd_ses2 = 0;


for i=1:115
    for j=i+1:116
        if z_ensamble_asd_ses1(i,j)<0
            neg_asd_ses1 = neg_asd_ses1 +1;
            dist_neg_asd_ses1(1,neg_asd_ses1) = z_ensamble_asd_ses1(i,j);
            
        elseif z_ensamble_asd_ses1(i,j)>0
            pos_asd_ses1 = pos_asd_ses1 +1;
            dist_pos_asd_ses1(1,pos_asd_ses1) = z_ensamble_asd_ses1(i,j);
            
        elseif z_ensamble_asd_ses1(i,j) == 0 
            zeros_asd_ses1 = zeros_asd_ses1+1;
        end 
    end
end
estimated_links_asd_ses1 = zeros_asd_ses1 + pos_asd_ses1 + neg_asd_ses1;

for i=1:115
    for j=i+1:116
        if z_ensamble_asd_ses2(i,j)<0
            neg_asd_ses2 = neg_asd_ses2 +1;
            dist_neg_asd_ses2(1,neg_asd_ses2) = z_ensamble_asd_ses2(i,j);
            
        elseif z_ensamble_asd_ses2(i,j)>0
            pos_asd_ses2 = pos_asd_ses2 +1;
            dist_pos_asd_ses2(1,pos_asd_ses2) = z_ensamble_asd_ses2(i,j);
            
        elseif z_ensamble_asd_ses2(i,j) == 0 
            zeros_asd_ses2 = zeros_asd_ses2+1;
        end 
    end
end
estimated_links_asd_ses2 = zeros_asd_ses2 + pos_asd_ses2 + neg_asd_ses2;

% control

neg_con_ses1 = 0; pos_con_ses1=0; zeros_con_ses1 = 0;
neg_con_ses2 = 0; pos_con_ses2=0; zeros_con_ses2 = 0;

for i=1:115
    for j=i+1:116
        if z_ensamble_con_ses1(i,j)<0
            neg_con_ses1 = neg_con_ses1 +1;
            dist_neg_con_ses1(1,neg_con_ses1) = z_ensamble_con_ses1(i,j);
            
        elseif z_ensamble_con_ses1(i,j)>0
            pos_con_ses1 = pos_con_ses1 +1;
            dist_pos_con_ses1(1,pos_con_ses1) = z_ensamble_con_ses1(i,j);
            
        elseif z_ensamble_con_ses1(i,j) == 0 
            zeros_con_ses1 = zeros_con_ses1+1;
        end 
    end
end
estimated_links_con_ses1 = zeros_con_ses1 + pos_con_ses1 + neg_con_ses1;


for i=1:115
    for j=i+1:116
        if z_ensamble_con_ses2(i,j)<0
            neg_con_ses2 = neg_con_ses2 +1;
            dist_neg_con_ses2(1,neg_con_ses2) = z_ensamble_con_ses2(i,j);
            
        elseif z_ensamble_con_ses2(i,j)>0
            pos_con_ses2 = pos_con_ses2 +1;
            dist_pos_con_ses2(1,pos_con_ses2) = z_ensamble_con_ses2(i,j);
            
        elseif z_ensamble_con_ses2(i,j) == 0 
            zeros_con_ses2 = zeros_con_ses2+1;
        end 
    end
end
estimated_links_con_ses2 = zeros_con_ses2 + pos_con_ses2 + neg_con_ses2;
