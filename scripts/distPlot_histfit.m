%b
h_con_ses1 = histogram(u_b_control_ses1_number, 500);
hold on
histfit(u_b_control_ses1_number, 500, 'kernel');
hold on

h_con_ses2 = histogram(u_b_control_ses2_number, 500);
hold on
histfit(u_b_control_ses2_number, 500, 'kernel');
hold on

h_asd_ses1 = histogram(u_b_autism_ses1_number, 500);
hold on
histfit(u_b_autism_ses1_number, 500, 'kernel');
hold on

h_asd_ses2 = histogram(u_b_autism_ses2_number, 500);
hold on
histfit(u_b_autism_ses2_number, 500, 'kernel');
hold on

%a
h_con_ses2 = histogram(u_a_control_ses2_number, 5000);
hold on
histfit(u_a_control_ses2_number, 5000, 'kernel');
hold on

h_con_ses1 = histogram(u_a_control_ses1_number, 5000);
hold on
histfit(u_a_control_ses1_number, 5000, 'kernel');
hold on

h_asd_ses1 = histogram(u_a_autism_ses1_number, 5000);
hold on
histfit(u_a_autism_ses1_number, 5000, 'kernel');
hold on

h_asd_ses2 = histogram(u_a_autism_ses2_number, 5000);
hold on
histfit(u_a_autism_ses2_number, 5000, 'kernel');
hold on

%c
h_asd_ses1 = histogram(u_c_autism_ses1_number, 20000);
hold on
histfit(u_c_autism_ses1_number, 20000, 'kernel');
hold on

h_asd_ses2 = histogram(u_c_autism_ses2_number, 20000);
hold on
histfit(u_c_autism_ses2_number, 20000, 'kernel');
hold on

h_con_ses1 = histogram(u_c_control_ses1_number, 20000);
hold on
histfit(u_c_control_ses1_number, 20000, 'kernel');
hold on

h_con_ses2 = histogram(u_c_control_ses2_number, 20000);
hold on
histfit(u_c_control_ses2_number, 20000, 'kernel');
hold on

%d
h_con_ses2 = histogram(u_d_control_ses2_number, 20000);
hold on
histfit(u_d_control_ses2_number, 20000, 'kernel');
hold on

h_con_ses1 = histogram(u_d_control_ses1_number, 20000);
hold on
histfit(u_d_control_ses1_number, 20000, 'kernel');
hold on

h_asd_ses1 = histogram(u_d_autism_ses1_number, 20000);
hold on
histfit(u_d_autism_ses1_number, 20000, 'kernel');
hold on

h_asd_ses2 = histogram(u_d_autism_ses2_number, 20000);
hold on
histfit(u_d_autism_ses2_number, 20000, 'kernel');
hold on


alpha(0.5)
legend([h_asd_ses1, h_con_ses1, h_asd_ses2, h_con_ses2], {'  Autism   session one','  Control  session one','  Autism   session two', '  Control  session two'});
