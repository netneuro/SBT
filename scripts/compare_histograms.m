function [] = compare_histograms(control_data,altered_data)
% Creates scatter plot for links and triads weights
% Feb 2021


[d ,control_count] = size(control_data);
[d ,altered_count] = size(altered_data);

densities = (0.05:0.05:1);

for d=1:20
    set(0, 'DefaultFigureWindowStyle', 'docked');
    figure;
    alpha(0.01);
    for s=1:control_count
        h = histogram(nonzeros(cell2mat(control_data(d,s))), 400, 'FaceColor','b');
        scat = scatter(h.BinEdges(1:400), h.Values, 'b');
        delete(h);
        hold on
    end
    for s=1:altered_count
        h = histogram(nonzeros(cell2mat(altered_data(d,s))), 400, 'FaceColor','r');
        scat = scatter(h.BinEdges(1:400), h.Values, 'r');
        delete(h);
        hold on
    end
    title(strcat('d = ', num2str(densities(1,d))));
    set(gca, 'XScale', 'log');
    set(gca, 'YScale', 'log');
end
end

