function [ax, fig] = defence_hist(data_autism, data_control, kl, the_title, y_label, mod)

% mod is zero for simple histogram without scatters and log-log axes
global bin edges


fig = figure('DefaultAxesFontSize', 12);
set(0, 'DefaultFigureWindowStyle', 'docked');
surf(peaks);
fig.PaperPositionMode = 'manual';
orient(fig, 'landscape');
ax = gca;

if mod 
    h1 = histogram(data_control, bin, 'FaceColor', 'g'); % Control hist
    s1 = scatter (h1.BinEdges(1:bin), h1.Values, 'g', 's', 'MarkerEdgeColor', [126/255 47/255 142/255], 'MarkerFaceColor', [0 1 0], 'LineWidth', 1);
    delete(h1);
else
    if ~(isempty(data_control))
        if ~isempty(edges) 
            h1 = histogram(data_control, 'BinEdges', edges, 'FaceColor', 'g'); % Control hist
        else
            h1 = histogram(data_control, 'FaceColor', 'g'); % Control hist
            edges = h1.BinEdges;
        end
    end
end

if ~(isempty(data_control))
    hold on
end

if mod
    h2 = histogram(data_autism, bin, 'FaceColor', 'm'); % Autism hist
    s2 = scatter (h2.BinEdges(1:bin), h2.Values, 'm', '^', 'MarkerEdgeColor',[18/255 54/255 36/255], 'MarkerFaceColor', [1 0 1], 'LineWidth', 1);
    delete(h2);
else
    if ~(isempty(data_control))
        h2 = histogram(data_autism, 'BinEdges', edges, 'FaceColor', 'm'); % Autism hist
    elseif ~(isempty(data_autism))
        h2 = histogram(data_autism, 'FaceColor', 'm'); % Autism hist
    else
        newplot;
    end
end

alpha(0.5);
temp_name = split(y_label, ' ');
if mod
    ylabel(char(strcat('Log_1_0 |', temp_name{1, 1},'|')));
    xlabel(char(strcat('Log_1_0 U (', temp_name{1, 1},')')));
else
    ylabel(char(strcat('|', temp_name{1, 1},'|')));
    xlabel(char(strcat('U (', temp_name{1, 1},')')));
end
title(char(strcat(y_label, {' '}, 'in', {' '}, the_title)));

if mod 
    set(gca,'xscale','log');
    set(gca,'yscale','log');
end

% TextLocation(strcat('p =', {' '}, num2str(pvalue, '%.4f'), '\n eta-squared =', {' '}, num2str(distane, '%.4f')),'Location','northwest');
if mod
    legend([s1 s2],'Control','Autism');
else
    if ~(isempty(data_control)) && ~(isempty(data_autism))
        legend([h1 h2],'Control','Autism');    
    elseif ~isempty(data_control)
        legend(h1, 'Control');
    elseif ~isempty(data_autism)
        legend(h2, 'Autism');
    end

end

