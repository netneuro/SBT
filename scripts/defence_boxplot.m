function [ax, fig] = defence_boxplot(data, p, effect_size, the_title, y_label)

% data is a 3 * 80 matrix.
% Rows corresponding to age ranges (1: CHILDhood: ADOLescence, 3: ADULThood).
% Cols corresponding to diagnosis group (1-40: data for individuals with ASD, 41-80: data for halethy CONtrols)

% p and effect size are 3 * 6 matrices.
% Rows corresponding to age ranges (1: CHILDhood: ADOLescence, 3: ADULThood).
% Cols corresponding to diagnosis group (1: individuals with ASD, 2: healthy CONtrols)

fig = figure('DefaultAxesFontSize', 12);
surf(peaks);
fig.PaperPositionMode = 'manual';
orient(fig, 'landscape');
set(0, 'DefaultFigureWindowStyle', 'docked');
ax = gca;

group_1 = [ones(40, 1); ones(40, 1); ones(40, 1); 2*ones(40, 1); 2*ones(40, 1); 2*ones(40, 1)];
group_2 = repmat({'CHILD CON','ADOL CON', 'ADULT CON', 'CHILD ASD','ADOL ASD', 'ADULT ASD'}, 40, 1);
group_2 = group_2(:);
data = [data(1, 41:80)'; data(2, 41:80)'; data(3, 41:80)'; data(1, 1:40)'; data(2, 1:40)'; data(3, 1:40)'];

boxplot(data, {group_1, group_2}, 'factorgap', [40 0])

h = findobj(gca, 'Tag' , 'Box');
colors = [1 0 1; 1 0 1; 1 0 1; 0 1 0; 0 1 0; 0 1 0];
for j=1:length(h)
    patch(get(h(j), 'XData'), get(h(j), 'YData'), colors(j,:), 'FaceAlpha' , 0.5);
end

set(gca,'XTick',1:8,'XTickLabel',{'CHILD CON','ADOL CON', 'ADULT CON', ' ', ' ', 'CHILD ASD','ADOL ASD', 'ADULT ASD'})

if p(1, 2) <= 0.01
    defence_sigstar({{'CHILD ASD','CHILD CON'}}, p(1, 2), effect_size(1, 2), 0); % defence_sigstar is based on sigstar method in the sigstar package: https://github.com/raacampbell/sigstar/
end
if p(3, 4) <= 0.01
    defence_sigstar({{'ADOL ASD','ADOL CON'}}, p(3, 4), effect_size(3, 4), 0);
end
if p(5, 6) <= 0.01
    defence_sigstar({{'ADULT ASD','ADULT CON'}}, p(5, 6), effect_size(5, 6), 0);
end
if p(1, 3) <= 0.01
    defence_sigstar({{'CHILD ASD','ADOL ASD'}}, p(1, 3), effect_size(1, 3), 0);
end
if p(1, 5) <= 0.01
    defence_sigstar({{'CHILD ASD','ADULT ASD'}}, p(1, 5), effect_size(1, 5), 0);
end
if p(2, 4) <= 0.01
    defence_sigstar({{'CHILD CON','ADOL CON'}}, p(2, 4), effect_size(2, 4), 0);
end
if p(2, 6) <= 0.01
    defence_sigstar({{'CHILD CON','ADULT CON'}}, p(2, 6), effect_size(2, 6), 0);
end
if p(3, 5) <= 0.01
    defence_sigstar({{'ADOL ASD','ADULT ASD'}}, p(3, 5), effect_size(3, 5), 0);
end
if p(4, 6) <= 0.01
    defence_sigstar({{'ADOL CON','ADULT CON'}}, p(4, 6), effect_size(4, 6), 0);
end

title(the_title);
ylabel(y_label, 'FontSize', 12);
% TextLocation(strcat('** p < 0.01, *** p < 0.001' ),'Location','southwest');

end

