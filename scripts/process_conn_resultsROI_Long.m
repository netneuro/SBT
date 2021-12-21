
% load('resultsROI_Condition002.mat')
n_autism = 22;
n_control = 15; 

% z_autism_follow = cell(1,n_autism);
% z_control_follow = cell(1,n_control);
% 
% r_autism_follow = cell(1,n_autism);
% r_control_follow = cell(1,n_control);
% 
% net_autism_follow = cell(1,n_autism);
% net_control_follow = cell(1,n_control);
% 
% Strogatz_autism_follow = zeros(1,n_autism);
% Strogatz_control_follow = zeros(1,n_control);

z_autism_base = cell(1,n_autism);
z_control_base = cell(1,n_control);

r_autism_base = cell(1,n_autism);
r_control_base = cell(1,n_control);

net_autism_base = cell(1,n_autism);
net_control_base = cell(1,n_control);

Strogatz_autism_base = zeros(1,n_autism);
Strogatz_control_base = zeros(1,n_control);

for i=1:n_autism
%     z_autism_follow{1,i} = Z(1:116,1:116,i);
    z_autism_base{1,i} = Z(1:116,1:116,i);

end
for i=1:n_control
%     z_control_follow{1,i} = Z(1:116,1:116,i+n_autism);
    z_control_base{1,i} = Z(1:116,1:116,i+n_autism);

end
for i=1:n_autism
    for j=1:116
        for k=1:116
%             if isnan(z_autism_follow{1,i}(j,k))
            if isnan(z_autism_base{1,i}(j,k))

%                 z_autism_follow{1,i}(j,k)=0;
                z_autism_base{1,i}(j,k)=0;

            end
        end
    end
end

for i=1:n_control
    for j=1:116
        for k=1:116
%             if isnan(z_control_follow{1,i}(j,k))
            if isnan(z_control_base{1,i}(j,k))

%                 z_control_follow{1,i}(j,k)=0;
                z_control_base{1,i}(j,k)=0;

            end
        end
    end
end

for i=1:n_autism
    for j=1:116
        for k=1:116
%             r_autism_follow{1,i}(j,k) = tanh(z_autism_follow{1,i}(j,k));
            r_autism_base{1,i}(j,k) = tanh(z_autism_base{1,i}(j,k));

            
        end
    end
end  
for i=1:n_control
    for j=1:116
        for k=1:116
%             r_control_follow{1,i}(j,k) = tanh(z_control_follow{1,i}(j,k));
            r_control_base{1,i}(j,k) = tanh(z_control_base{1,i}(j,k));

            
        end
    end
end  

for i=1:n_autism
%     net_autism_follow{1,i} = corr_to_net(r_autism_follow{1,i});
    net_autism_base{1,i} = corr_to_net(r_autism_base{1,i});

end

for i=1:n_control
%     net_control_follow{1,i} = corr_to_net(r_control_follow{1,i});
    net_control_base{1,i} = corr_to_net(r_control_base{1,i});

end

for i=1:n_autism
%     Strogatz_autism_follow(1,i) = U(net_autism_follow{1,i});
    Strogatz_autism_base(1,i) = U(net_autism_base{1,i});

end

for i=1:n_control
%     Strogatz_control_follow(1,i) = U(net_control_follow{1,i});
    Strogatz_control_base(1,i) = U(net_control_base{1,i});

end

% [h_follow, p_follow] = ttest2(Strogatz_autism_follow,Strogatz_control_follow);

  [h_base, p_base] = ttest2(Strogatz_autism_base,Strogatz_control_base);
  