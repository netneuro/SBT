function [ax,fig] = defence_IQ_energy(energy)

load('/Volumes/ZAHRA5TB/ongoing_projects/defence/results/mat_files/demographic.mat');

IQ = {FIQ, VIQ, PIQ};
IQ_labels = {'FIQ', 'VIQ', 'PIQ'};
group_labels = {'childhood', 'adolescence', 'adulthood'};

for age = 1:3
    for i = 1:numel(IQ)
        fig{age, i} = figure('DefaultAxesFontSize', 12);
        set(0, 'DefaultFigureWindowStyle', 'docked');
        surf(peaks);
        fig{age, i}.PaperPositionMode = 'manual';
        orient(fig{age, i}, 'landscape');
        ax{age, i} = gca;
        
        p_asd = plot(IQ{1, i}(1:40, age), energy(age, 1:40)','om', 'MarkerSize', 10, 'MarkerFaceColor','m');
        hold on
        l_asd = lsline;
        set(l_asd, 'LineWidth', 3);
        hold on
        p_con = plot(IQ{1, i}(41:80, age), energy(age, 41:80)','og', 'MarkerSize', 10, 'MarkerFaceColor','g');
        hold on
        l_con = lsline;
        set(l_con, 'LineWidth', 3);
        
        title(char(strcat(IQ_labels{1, i}, {' '}, 'during', {' '}, group_labels{1,age})));
        corr_asd = corr(IQ{1, i}(1:40, age), energy(age, 1:40)');
        corr_con = corr(IQ{1, i}(41:80, age), energy(age, 41:80)');
        
        TextLocation(char(strcat('r - asd =', {' '},  num2str(corr_asd, '%.3f'),...
            ', r - con =', {' '}, num2str(corr_con, '%.3f'))), 'Location','northeast');
        
    end
end

end

