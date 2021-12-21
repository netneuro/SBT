
clear all
load ('corr_mean.mat');
load ('energy_triads_autism_ses2');

edges_b0_autism_ses2 = zeros(116,116);
count = 0;

for i=1:114
    for j=i+1:115
        for k=j+1:116
% Autism Session 1           
%             if u_b_autism_ses1 (i,j,k) ~= 0
%             if u_b_autism_ses1 (i,j,k) >= 0.0001 
%             if u_b_autism_ses1 (i,j,k) >= 0.0002 
%             if u_b_autism_ses1 (i,j,k) >= 0.0003

% Autism Session 2           
%             if u_b_autism_ses2 (i,j,k) ~= 0
%             if u_b_autism_ses2 (i,j,k) >= 0.0001 
%             if u_b_autism_ses2 (i,j,k) >= 0.0002 
              if u_b_autism_ses2 (i,j,k) >= 0.0003

% Control Session 1           
%                 if u_b_control_ses1 (i,j,k) ~= 0
%                 if u_b_control_ses1 (i,j,k) >= 0.0001 
%                 if u_b_control_ses1 (i,j,k) >= 0.0002 
%                 if u_b_control_ses1 (i,j,k) >= 0.0003

% Control Session 2           
%                 if u_b_control_ses2 (i,j,k) ~= 0
%                 if u_b_control_ses2 (i,j,k) >= 0.0001 
%                 if u_b_control_ses2 (i,j,k) >= 0.0002 
%                 if u_b_control_ses2 (i,j,k) >= 0.0003

                    count = count+1;
                    edges_b0_autism_ses2 (i,j) = corr_control_ses1 (i,j);
                    edges_b0_autism_ses2 (i,k) = corr_control_ses1 (i,k);
                    edges_b0_autism_ses2 (j,k) = corr_control_ses1 (j,k);
             end
            
        end
    end
end
% dlmwrite('b0_control_ses1.edge',edges_b0_autism_ses2,'delimiter','\t','precision',15);

% t=1;
% for i=1:116
% for j=1:116
% if edges_b0_autism_ses2(i,j) ~= 0
%     b0{1,t} = i;
%     b0{2,t}=j;
%     t=t+1;
% end
% end
% end