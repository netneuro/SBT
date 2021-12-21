% 9 Azar

%Box plot for energies
% colormap = [250 88 164; 88 201 250 ;1 0 0;141 23 241 ; 32 23 241 ];

figure
colormap = [255 0 0; 0 0 255];
colormap = colormap/ 255;

data = [u_dorsAttnB_asd_6_9_dis; u_dorsAttnB_con_6_9_dis];
group = [ones(size(u_dorsAttnB_asd_6_9_dis)); 0.5*ones(size(u_dorsAttnB_con_6_9_dis))];

boxplot(data,group, 'Notch','on', 'Width', 0.2, 'Colors', colormap);

set(findobj(gca,'type','line'),'linew',1.2);
% xticklabels({'Autism','Control'});
% ylabel(' Energy ( U ( N ) ) ');

% outliers
h = findobj(gcf,'tag','Outliers');
for iH = 1:length(h)
    h(iH).MarkerEdgeColor = 'k';
end

%legend
box = findall(gca,'Tag','Box');
box = flip(box);
% for i=1:2
%     new_box(i,1)= box(i,1);
% end
% for i=3:4
%     new_box(i,1)= box(i+1,1);
% end  
% legend(box, {'Autism','Control'});