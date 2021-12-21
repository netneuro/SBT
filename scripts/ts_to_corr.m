
% clear all
% load('ts_conn.mat');

corr_autism_base= cell(1,10);
pval_autism_base= cell(1,10);

corr_autism_follow= cell(1,14);
pval_autism_follow= cell(1,14);

corr_control_base= cell(1,6);
pval_control_base= cell(1,6);

corr_control_follow= cell(1,7);
pval_control_follow= cell(1,7);

for i=1:10
[corr_autism_base{1,i}, pval_autism_base{1,i}] = Corr_estimate(ts_interpole_autism_base{1,i},1);
end

for i=1:10
    for j=1:116
        for k=1:116
             if (pval_autism_base{1,i}(j,k)>0.05)
                 corr_autism_base{1,i}(j,k)=0;
             end
        end
    end
    
end

for i=1:14
[corr_autism_follow{1,i}, pval_autism_follow{1,i}] = Corr_estimate(ts_interpole_autism_follow{1,i},1);
end

for i=1:14
    for j=1:116
        for k=1:116
             if (pval_autism_follow{1,i}(j,k)>0.05)
                 corr_autism_follow{1,i}(j,k)=0;
             end
        end
    end
    
end

for i=1:6
[corr_control_base{1,i}, pval_control_base{1,i}] = Corr_estimate(ts_interpole_control_base{1,i},1);
end

for i=1:6
    for j=1:116
        for k=1:116
             if (pval_control_base{1,i}(j,k)>0.05)
                 corr_control_base{1,i}(j,k)=0;
             end
        end
    end
    
end

for i=1:7
[corr_control_follow{1,i}, pval_control_follow{1,i}] = Corr_estimate(ts_interpole_control_follow{1,i},1);
end

for i=1:7
    for j=1:116
        for k=1:116
             if (pval_control_follow{1,i}(j,k)>0.05)
                 corr_control_follow{1,i}(j,k)=0;
             end
        end
    end
    
end

