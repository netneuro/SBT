% 8 Dey
% Density of total energy of individuals 
% histfit with normalize Y Axes

% remember to set the sizes manually!!

% cretae a handle to the histfit. We dont want this plot, just the handle
% is what we need here
figure
h_con_6_9 = histfit(u_z_weighted_con_6_9,10, 'kernel');


% Then we use the handle to plot the bar (h(1)) and the curve (h(2))
figure
plot(h_con_6_9(1).XData,h_con_6_9(1).YData/33); 
hold on
% Here go and manually change the plot type to Bar instead of line

plot(h_con_6_9(2).XData, h_con_6_9(2).YData / 33);
hold on






