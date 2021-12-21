
% 23 Mehr 98

% finds the pair triads (two triad that share common edge)
% Find the energy of these two triads
% Uses Find_Index function: each axes 401 interval (-2:0.01:+2), to each
% enery the function assigns an index of the interval within which the
% enrgy is in.

clear all

% load ('corr_mean.mat');
% Corr = corr_control_ses2;
% u = zeros (116,116,116);
% 
% for i=1 : 114
%         for j=i+1 : 115
%             for k= j+1 : 116
%                 u (i,j,k) = - (Corr (i,j) * Corr(i,k) * Corr(j,k));
%             end
%             
%         end
% end

% load ('energy_triads_autism_ses2');
% u = u_a_autism_ses2;
% 
% map_a_autism_ses2 = zeros (401 , 401);

for i = 1 : 113
    for j = i+1 : 114
        for x = j+1 : 115     
              for y = x+1 : 116 
                  
                  if u(i,j,x) ~= 0 && u(i,j,y) ~= 0
                      column = find_index( u(i,j,x),1 );
                      row = find_index( u(i,j,y),2 );
                      map_a_autism_ses2(row,column) = map_a_autism_ses2(row,column) + 1;
                  end
                  
                  if u(i,x,y) ~= 0 && u(j,x,y) ~= 0
                      column = find_index( u(i,x,y),1 );
                      row = find_index( u(j,x,y),2 );
                      map_a_autism_ses2(row,column) = map_a_autism_ses2(row,column) + 1;
                  end
                  
              end
               
         end
                    
        
    end
end

log_map_a_autism_ses2 = log(map_a_autism_ses2);

% Draw the map:

% pair_map
% log_map_autism_ses2 = log(map);
% map_autism_ses2 = map;
% pair_map
% log_map_autism_ses2 = log(map);
% map_autism_ses2 = map;
% pair_map
% log_map_control_ses2 = log(map);
% map_control_ses2 = map;
% pair_map
% log_map_control_ses2 = log(map);
% map_control_ses2 = map;
% 
% 
% x = (-2:0.5:2);
% y = (-2:0.5:2);
% 
% x_axes = zeros(1,9);
% y_axes = zeros(1,9);
% 
% 
% load('map_control_ses2.mat')
% imagesc(x,y,log_map_control_ses2);
% hold on
% plot(x, y_axes);
% hold on
% plot(x, y_axes);
% hold on
% plot(x_axes, y);
% load('u_control_ses2.mat')
% min(u_control_ses2)
% x_limit = -1.232620820098739 * ones(1,9);
% y_limit = 1.232620820098739 * ones(1,9);
% hold on
% plot(x_limit, y);
% hold on
% plot(x, y_limit);
% title ('Energy Pairs in Control Session 1 Network');



