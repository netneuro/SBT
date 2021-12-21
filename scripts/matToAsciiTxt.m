n = 343;
for i=1:n
    name_1 = 'maskedCorr_';
    
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
    out_name = strcat(name_1,name_2,'.txt');
    
    if isfile (name)
        load(name);
        save(out_name, 'FC', '-ascii');
    end
end

% new version
for i = 1:80
name = strcat('corr_harmonized_adolescent_', num2str(i, '%03i'), '.txt');
fc = corr_harmonized_adol{1, i};
save(name, 'fc', '-ascii');
end