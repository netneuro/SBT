
%b
h_b_asd_6_9 = histogram(u_b_asd_6_9_number, 400);
s_asd_ses1 = scatter (h_b_asd_6_9.BinEdges(1:400), h_b_asd_6_9.Values);
hold on
h_b_autism_ses2 = histogram(u_b_autism_ses2_number, 400);
s_asd_ses2 = scatter (h_b_autism_ses2.BinEdges(1:400), h_b_autism_ses2.Values);
hold on
h_b_control_ses1 = histogram(u_b_control_ses1_number, 400);
s_con_ses1 = scatter (h_b_control_ses1.BinEdges(1:400), h_b_control_ses1.Values);
hold on
h_b_control_ses2 = histogram(u_b_control_ses2_number, 400);
s_con_ses2 = scatter (h_b_control_ses2.BinEdges(1:400), h_b_control_ses2.Values);
legend([s_asd_ses1, s_con_ses1, s_asd_ses2, s_con_ses2], {'  Autism   session one','  Control  session one','  Autism   session two', '  Control  session two'});

%a
h_a_asd_6_9 = histogram(u_a_asd_6_9_number, 400);
s_asd_ses1 = scatter (h_a_asd_6_9.BinEdges(1:400), h_a_asd_6_9.Values);
hold on
h_a_autism_ses2 = histogram(u_a_autism_ses2_number, 400);
s_asd_ses2 = scatter (h_a_autism_ses2.BinEdges(1:400), h_a_autism_ses2.Values);
hold on
h_a_control_ses1 = histogram(u_a_control_ses1_number, 400);
s_con_ses1 = scatter (h_a_control_ses1.BinEdges(1:400), h_a_control_ses1.Values);
hold on
/Volumes/ZAHRA5TB/Experiments/cross_study/results/firstlevel/ANALYSIS_01/resultsROI_Condition
%c
h_c_asd_6_9 = histogram(u_c_asd_6_9_number, 400);
s_asd_ses1 = scatter (h_c_asd_6_9.BinEdges(1:400), h_c_asd_6_9.Values);
hold on
h_c_autism_ses2 = histogram(u_c_autism_ses2_number, 400);
s_asd_ses2 = scatter (h_c_autism_ses2.BinEdges(1:400), h_c_autism_ses2.Values);
hold on
h_c_control_ses1 = histogram(u_c_control_ses1_number, 400);
s_con_ses1 = scatter (h_c_control_ses1.BinEdges(1:400), h_c_control_ses1.Values);
hold on
h_c_control_ses2 = histogram(u_c_control_ses2_number, 400);
s_con_ses2 = scatter (h_c_control_ses2.BinEdges(1:400), h_c_control_ses2.Values);
legend([h_asd_ses1, h_con_ses1, h_asd_ses2, h_con_ses2], {'  Autism   session one','  Control  session one','  Autism   session two', '  Control  session two'});

%d
h_d_asd_6_9 = histogram(u_d_asd_6_9_number, 400);
s_asd_ses1 = scatter (h_d_asd_6_9.BinEdges(1:400), h_d_asd_6_9.Values);
hold on
h_d_autism_ses2 = histogram(u_d_autism_ses2_number, 400);
s_asd_ses2 = scatter (h_d_autism_ses2.BinEdges(1:400), h_d_autism_ses2.Values);
hold on
h_d_control_ses1 = histogram(u_d_control_ses1_number, 400);
s_con_ses1 = scatter (h_d_control_ses1.BinEdges(1:400), h_d_control_ses1.Values);
hold on
h_d_control_ses2 = histogram(u_d_control_ses2_number, 400);
s_con_ses2 = scatter (h_d_control_ses2.BinEdges(1:400), h_d_control_ses2.Values);