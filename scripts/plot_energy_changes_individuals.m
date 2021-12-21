

% clear all
% 
% load('Age.mat');
% load('z_individuals.mat');
% load('u_individuals_using_z.mat');

c = distinguishable_colors(25);
figure
for i=1:23
    x = [age_autism_ses1(1,i),age_autism_ses2(1,i)];
    y = [u_autism_ses1_z_all_binary(1,i),u_autism_ses2_z_all_binary(1,i)];
    if u_autism_ses2_z_all_binary(1,i) > u_autism_ses1_z_all_binary(1,i)
        plot(x,y,'--','Color',c(i+10,:),'LineWidth',2);
        Legend{i} = num2str(i);
        hold on
    end
    
end
title('Autism: More Balanced in Ses2');
xlabel('Age');
ylabel('U');
ylim([-0.06 0]);
Legend(cellfun('isempty',Legend)) = [];
legend(Legend);
% for i=1:15
%     x = [age_autism_base(1,i),age_autism_follow(1,i)];
%     y = [u_autism_ses1(1,i),u_autism_ses2(1,i)];
%     plot(x,y);
%     legend
%     hold on
%     
% end
