% 25 Mehr 98

clear all

load ('energy_triads_control_ses2.mat');
load('corr_mean');

[u_a , index_a] = maxNvalues(u_a_control_ses2,10);
[u_b , index_b] = maxNvalues(u_b_control_ses2,10);
[u_c , index_c] = minNvalues(u_c_control_ses2,10);
[u_d , index_d] = minNvalues(u_d_control_ses2,10);

%Draw

top_10_edges_control_ses2 = zeros(116,116);
color_top_10_edges_control_ses2 = zeros(116,116);

for i=1:10
  top_10_edges_control_ses2 (index_a(i,1), index_a(i,2)) = corr_control_ses2(index_a(i,1), index_a(i,2));
  color_top_10_edges_control_ses2 (index_a(i,1), index_a(i,2)) = 0;
  
  top_10_edges_control_ses2 (index_a(i,1), index_a(i,3)) = corr_control_ses2(index_a(i,1), index_a(i,3));
  color_top_10_edges_control_ses2 (index_a(i,1), index_a(i,3)) = 0;
  
  top_10_edges_control_ses2 (index_a(i,2), index_a(i,3)) = corr_control_ses2(index_a(i,2), index_a(i,3));
  color_top_10_edges_control_ses2 (index_a(i,2), index_a(i,3)) = 0;
end

for i=1:10
  top_10_edges_control_ses2 (index_b(i,1), index_b(i,2)) = corr_control_ses2(index_b(i,1), index_b(i,2));
  color_top_10_edges_control_ses2 (index_b(i,1), index_b(i,2)) = 1;

  top_10_edges_control_ses2 (index_b(i,1), index_b(i,3)) = corr_control_ses2(index_b(i,1), index_b(i,3));
  color_top_10_edges_control_ses2 (index_b(i,1), index_b(i,3)) = 1;
  
  top_10_edges_control_ses2 (index_b(i,2), index_b(i,3)) = corr_control_ses2(index_b(i,2), index_b(i,3));
  color_top_10_edges_control_ses2 (index_b(i,2), index_b(i,3)) = 1;
  
end

for i=1:10
  top_10_edges_control_ses2 (index_c(i,1), index_c(i,2)) = corr_control_ses2(index_c(i,1), index_c(i,2));
  color_top_10_edges_control_ses2 (index_c(i,1), index_c(i,2)) = 2;
  
  top_10_edges_control_ses2 (index_c(i,1), index_c(i,3)) = corr_control_ses2(index_c(i,1), index_c(i,3));
  color_top_10_edges_control_ses2 (index_c(i,1), index_c(i,3)) = 2;
  
  top_10_edges_control_ses2 (index_c(i,2), index_c(i,3)) = corr_control_ses2(index_c(i,2), index_c(i,3));
  color_top_10_edges_control_ses2 (index_c(i,2), index_c(i,3)) = 2;
  
end

for i=1:10
  top_10_edges_control_ses2 (index_d(i,1), index_d(i,2)) = corr_control_ses2(index_d(i,1), index_d(i,2));
  color_top_10_edges_control_ses2 (index_d(i,1), index_d(i,2)) = 3;
  
  top_10_edges_control_ses2 (index_d(i,1), index_d(i,3)) = corr_control_ses2(index_d(i,1), index_d(i,3));
  color_top_10_edges_control_ses2 (index_d(i,1), index_d(i,3)) = 3;

  top_10_edges_control_ses2 (index_d(i,2), index_d(i,3)) = corr_control_ses2(index_d(i,2), index_d(i,3));
  color_top_10_edges_control_ses2 (index_d(i,2), index_d(i,3)) = 3;

end

dlmwrite('top_10_edges_control_ses2.edge',top_10_edges_control_ses2,'delimiter','\t','precision',15);
dlmwrite('color_top_10_edges_control_ses2.txt',color_top_10_edges_control_ses2,'delimiter','\t');
