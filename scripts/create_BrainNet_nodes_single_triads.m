

n_d = 39877;
nodes_d_control_ses2 = zeros(n_d, 6);
key = 0;

for i=1:n_d
%     module
    nodes_d_control_ses2 (i, 4) = 2;
%     size
    nodes_d_control_ses2 (i, 5) = 1; 
%     name
    nodes_d_control_ses2 (i, 6) = 0;   
end

x = x_triads_d_control_ses2;
y = y_triads_d_control_ses2;
z = z_triads_d_control_ses2;

u = u_d_control_ses2;

t=1;
for i=1:116
    for j=1:116
        for k=1:116
            
            if u(i,j,k) ~=0 
                
                    nodes_d_control_ses2(t, 1) = x(i,j,k);
                    nodes_d_control_ses2(t, 2) = y(i,j,k);
                    nodes_d_control_ses2(t, 3) = z(i,j,k);
                    t = t + 1;
            
            end
        end
    end
end

% check the number of written triads
if n_d == t-1
    key = 1;
end


