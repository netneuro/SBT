% 4 Bahman 98
% U(x,y,z)

n=343;

subject = 1;

for i=1:n
    name_1 = 'corr_3_';
    
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
        [n,m,ROI] = size(corr_3);
        numerator = nonzeros(reshape(corr_3,[1,ROI*ROI*ROI]));
        u(1,subject) = - (sum(numerator) / numel(numerator));
        subject = subject + 1;
    end
    
end
    