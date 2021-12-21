% divide AAL time series into left and right hemisphere
% 20 Dey 98

n = 343;

for i=1:n
    
    name_1 = 'ts_right_';
    
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
    load(name);
    
%     ts_left = ts(:,1:2:end);
%     ts_right = ts(:,2:2:end);
% 
    %cov_left = cov(ts_left);
    cov_right = cov(ts_right);
 
    %dir_left = '/Users/zahra/Documents/SBU/Thesis/Experiments/Cross study/divide in two DS/AAL 90/cov/left/';
    dir_right = '/Users/zahra/Documents/SBU/Thesis/Experiments/Cross study/divide in two DS/AAL 90/cov/right/';

    %output_name_left = strcat(dir_left, 'cov_left_',name_2);
    output_name_right = strcat(dir_right, 'cov_right_',name_2);
    
    %save(output_name_left, 'cov_left');
    save(output_name_right, 'cov_right');

        
    %[Theta_left W_left] = glasso(cov_left, 0.01);
    [Theta_right W_right] = glasso(cov_right, 0.01);
    
    %dir_left = '/Users/zahra/Documents/SBU/Thesis/Experiments/Cross study/divide in two DS/AAL 90/inverseCov/left/';
    dir_right = '/Users/zahra/Documents/SBU/Thesis/Experiments/Cross study/divide in two DS/AAL 90/inverseCov/right/';

    %output_name_left = strcat(dir_left, 'inverseCov_left_',name_2);
    output_name_right = strcat(dir_right, 'inverseCov_right_',name_2);
    
    %save(output_name_left, 'Theta_left');
    save(output_name_right, 'Theta_right');

    clear all
end

