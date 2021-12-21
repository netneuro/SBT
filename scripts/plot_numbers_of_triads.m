
a = [size(u_a_asd_6_9), size(u_a_con_6_9),size(u_a_control)];
b = [size(u_b_combined), size(u_b_inattentive),size(u_b_control)];
c = [size(u_c_combined), size(u_c_inattentive),size(u_c_control)];
d = [size(u_d_combined), size(u_d_inattentive),size(u_d_control)];

a (:,2) = [];
a (:,3) = [];
a (:,4) = [];
b (:,2) = [];
b (:,3) = [];
b (:,4) = [];
c (:,2) = [];
c (:,3) = [];
c (:,4) = [];
d (:,2) = [];
d (:,3) = [];
d (:,4) = [];

numbers = [a;b;c;d];
bar(numbers);
legend('Combined', 'Inattentive','Control');
hold on