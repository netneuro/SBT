% 2/ 11 / 98
% count the number of pos and neg links

network = z_ensamble_con_14_18_rep; ROI = 400; 
neg_links_con_14_18 = 0; pos_links_con_14_18 = 0;

for i=1:ROI
    for j=1:ROI
       if network(i,j) < 0 
           neg_links_con_14_18 = neg_links_con_14_18 + 1;
           
       elseif network(i,j) > 0
           pos_links_con_14_18 = pos_links_con_14_18 + 1;
       end   
    end
end
 
%probability reptribution of neg and pos links

pos=1; neg=1;

for i=1:ROI
    for j=1:ROI
       if network(i,j) < 0 
           dist_neg_links_con_14_18(1,neg)=network(i,j);
           neg=neg+1;
       elseif network(i,j) > 0
           dist_pos_links_con_14_18(1,pos)=network(i,j);
           pos=pos+1;
       end   
    end
end

% example of ploting the results

% histogram(rept_pos_links_con_14_18, 'facecolor','r');
% hold on
% histogram(rept_pos_links_con_14_18, 'facecolor','b');
% alpha(0.5)
 