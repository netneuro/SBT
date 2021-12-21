% 4 Bahman 98
% cov(x,y,z) and corr(x,y,z)


n=343;

for i=1:n
    name_1 = 'ts_';
    
    if i<10
        temp = {'00', num2str(i)};
        name_2 = strcat(temp{1,1},temp{1,2});
    elseif i<100
        temp = {'0', num2str(i)};
        name_2 = strcat(temp{1,1},temp{1,2});
    else
        name_2 = num2str(i);
    end
    name_3 = '.mat';
    name = strcat(name_1, name_2, name_3);
    
    if isfile (name)
        
        load(name);
        [length_timeseries,ROI] = size(ts);
        num = nchoosek(ROI,3);

        cov_3 = zeros(ROI,ROI,ROI);
        corr_3 = zeros(ROI,ROI,ROI);

        for j=1:ROI-2
            for k=j+1:ROI-1
                for l=k+1:ROI
                    x = ts(:,j); y = ts(:,k); z = ts(:,l);
                    mean_x = mean(x); mean_y = mean(y); mean_z = mean(z);
                    std_x = std(x); std_y = std(y); std_z = std(z);
                    sum = 0;
                    for m=1:length_timeseries
                        sum = sum + (x(m,1)-mean_x) * (y(m,1)-mean_y) * (z(m,1)-mean_z);
                    end
                    cov_3(j,k,l) = sum / (length_timeseries-1);
                    corr_3(j,k,l) = cov_3(j,k,l) / (std_x * std_y * std_z);

                end
            end
        end

        dir_cov = '/Volumes/ADATA HD830/SBU/Thesis/Experiments/Cross study/divide in two New/Schaefer/cov_3/';    
        output_name_cov = strcat(dir_cov, 'cov_3_',name_2);
        save(output_name_cov, 'cov_3');

        dir_corr = '/Volumes/ADATA HD830/SBU/Thesis/Experiments/Cross study/divide in two New/Schaefer/corrCoef_3/';    
        output_name_corr = strcat(dir_corr, 'corr_3_',name_2);
        save(output_name_corr, 'corr_3');
    end
end
    