
% load('resultsROI_Condition002.mat')

n_autism = 20;
n_control = 20; 

z_autism = cell(1,n_autism);
z_control = cell(1,n_control);

r_autism = cell(1,n_autism);
r_control = cell(1,n_control);

net_autism = cell(1,n_autism);
net_control = cell(1,n_control);

Strogatz_autism = zeros(1,n_autism);
Strogatz_control = zeros(1,n_control);

for i=1:n_autism
    z_autism{1,i} = Z(1:116,1:116,i);
end
for i=1:n_control
    z_control{1,i} = Z(1:116,1:116,i+(n_autism));
end
for i=1:n_autism
    for j=1:116
        for k=1:116
            if isnan(z_autism{1,i}(j,k))
                z_autism{1,i}(j,k)=0;
            end
        end
    end
end

for i=1:n_control
    for j=1:116
        for k=1:116
            if isnan(z_control{1,i}(j,k))
                z_control{1,i}(j,k)=0;
            end
        end
    end
end

for i=1:n_autism
    for j=1:116
        for k=1:116
            r_autism{1,i}(j,k) = tanh(z_autism{1,i}(j,k));
            
        end
    end
end  
for i=1:n_control
    for j=1:116
        for k=1:116
            r_control{1,i}(j,k) = tanh(z_control{1,i}(j,k));
            
        end
    end
end  

for i=1:n_autism
    net_autism{1,i} = corr_to_net(r_autism{1,i});
end

for i=1:n_control
    net_control{1,i} = corr_to_net(r_control{1,i});
end

for i=1:n_autism
    Strogatz_autism(1,i) = U(net_autism{1,i});
end

for i=1:n_control
    Strogatz_control(1,i) = U(net_control{1,i});
end

[h, p] = ttest2(Strogatz_autism,Strogatz_control);

    