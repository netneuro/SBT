% 13 Aban

%plot energy changes for the mean networks

% clear afterDelTwo

% load('mean_age.mat');
% load('u_z_mean_binary.mat');
% load('u_z_individuals(19_13)_binary.mat');

x_autism = [mean_age_autism_ses1 mean_age_autism_ses2] ;
x_control = [mean_age_control_ses1 mean_age_control_ses2];

mean_u_autism_ses1 = mean(u_autism_ses1_z_afterDelTwoAsd_binary);
mean_u_autism_ses2 = mean(u_autism_ses2_z_afterDelTwoAsd_binary);
mean_u_control_ses1 = mean(u_control_ses1_z_all_binary);
mean_u_control_ses2 = mean(u_control_ses2_z_all_binary);

% mean_u_autism_ses1 = u_autism_ses1_z_mean_binary;
% mean_u_autism_ses2 = u_autism_ses2_z_mean_binary;
% mean_u_control_ses1 = u_control_ses1_z_mean_binary;
% mean_u_control_ses2 = u_control_ses2_z_mean_binary;

y_autism = [mean_u_autism_ses1 mean_u_autism_ses2];
y_control = [mean_u_control_ses1 mean_u_control_ses2];

sd_autism_ses1 =var(u_autism_ses1_z_afterDelTwoAsd_binary);
sd_autism_ses2 =var(u_autism_ses2_z_afterDelTwoAsd_binary);

sd_control_ses1 =var(u_control_ses1_z_all_binary);
sd_control_ses2 =var(u_control_ses2_z_all_binary);

below_error_autism  = [sd_autism_ses1 sd_autism_ses2];
above_error_autism  = [sd_autism_ses1 sd_autism_ses2];

below_error_control  = [sd_control_ses1 sd_control_ses2];
above_error_control  = [sd_control_ses1 sd_control_ses2];

% min_u_autism_ses1 = min(u_autism_ses1_z_afterDelTwo_binary);
% max_u_autism_ses1 = max(u_autism_ses1_z_afterDelTwo_binary);
% 
% min_u_autism_ses2 = min(u_autism_ses2_z_afterDelTwo_binary);
% max_u_autism_ses2 = max(u_autism_ses2_z_afterDelTwo_binary);
% 
% min_u_control_ses1 = min(u_control_ses1_z_afterDelTwo_binary);
% max_u_control_ses1 = max(u_control_ses1_z_afterDelTwo_binary);
% 
% min_u_control_ses2 = min(u_control_ses2_z_afterDelTwo_binary);
% max_u_control_ses2 = max(u_control_ses2_z_afterDelTwo_binary);

% below_error_autism_ses1 = mean_u_autism_ses1 - min_u_autism_ses1;
% above_error_autism_ses1 = max_u_autism_ses1 - mean_u_autism_ses1;
% 
% below_error_autism_ses2 = mean_u_autism_ses2 - min_u_autism_ses2;
% above_error_autism_ses2 = max_u_autism_ses2 - mean_u_autism_ses2;
% 
% below_error_control_ses1 = mean_u_control_ses1 - min_u_control_ses1;
% above_error_control_ses1 = max_u_control_ses1 - mean_u_control_ses1;
% 
% below_error_control_ses2 = mean_u_control_ses2 - min_u_control_ses2;
% above_error_control_ses2 = max_u_control_ses2 - mean_u_control_ses2;

% below_error_autism = [below_error_autism_ses1 below_error_autism_ses2];
% above_error_autism = [above_error_autism_ses1 above_error_autism_ses2];
% 
% below_error_control = [below_error_control_ses1 below_error_control_ses2];
% above_error_control = [above_error_control_ses1 above_error_control_ses2];


figure
autism =errorbar(x_autism,y_autism,below_error_autism, above_error_autism,'LineWidth',2);
hold on
control = errorbar(x_control,y_control,below_error_control, above_error_control,'LineWidth',2);


title('Energy Dynamics from Session One to Session Two');
xlabel('Age');
xlim([10 20]);
% ylim([-0.01 0]);
ylabel('Energy');
legend([autism, control], {'Autism','Control'});

