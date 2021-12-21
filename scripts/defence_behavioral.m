function [ax, fig] = defence_behavioral(energy, net)

global age_group dir network_labels

load('/media/zahra/ZAHRA5TB/ongoing_projects/defence/results/mat_files/behavioral_scores');

score_values = {ADI_R_SOCIAL, ADI_R_VERBAL, ADI_RRB,...
    ADOS_TOTAL, ADOS_COMM, ADOS_SOCIAL, ADOS_STEREO_BEHAV,...
    ADOS_G_SOCIAL, ADOS_G_RRB, ADOS_G_TOTAL, ADOS_G_SEVERITY};

score_labels = {'ADI Social', 'ADI Verbal', 'ADI Restricted and Repetitive Behaviors',...
    'ADOS Total', 'ADOS Communication', 'ADOS Social', 'ADOS Stereotype Behaviors',...
    'ADOS-G Social', 'ADOS-G RRB', 'ADOS-G Total', 'ADOS-G Severity'};


for age = 1:numel(age_group)
    for score = 1:numel(score_values)
        fig{age, score} = figure('DefaultAxesFontSize', 12);
        set(0, 'DefaultFigureWindowStyle', 'docked');
        surf(peaks);
        fig{age, score}.PaperPositionMode = 'manual';
        orient(fig{age, score}, 'landscape');
        ax{age, score} = gca;
        
        p = plot(score_values{1, score}(age, :), energy(age, 1:40), '*r');
        hold on
        l = lsline;
        set(l, 'color', 'k');
        slope = corr(energy(age, 1:40)', score_values{1, score}(age, :)', 'rows', 'complete');
        TextLocation(char(strcat('r =', {' '}, num2str(slope, '%.4f'))),'Location','northeast');
        box 'off'
        xlabel(char(strcat(score_labels{1, score}, {' '}, 'scores')));
        ylabel('Balance energy');
        title(char(strcat(network_labels{1, net}, {' '}, 'during', {' '}, age_group{1, age})));
    end
end

% Save the results
quote = char(39);
command = char(strcat('gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=', quote, network_labels{1, net}, '_brain_behavior.pdf', quote));
for score = 1:numel(score_values)
    for age = 1:numel(age_group)
        print_name = char(strcat(dir{1, net}, score_labels{1, score}, '_', num2str(age), '.', {' '}, age_group{1, age}, '.pdf'));
        print(fig{age, score}, print_name, '-dpdf', '-r400'); 
        command = char(strcat(command, {' '}, quote, score_labels{1, score}, '_', num2str(age), '.', {' '}, age_group{1, age}, '.pdf', quote));
        
    end
end

cd(char(dir{1, net}));
[status, cmdout] = system(command); % to merge all pdfs in one single pdf
source = strcat(quote, network_labels{1, net}, '.pdf', quote);

clear command
close all

end

% fig = figure('DefaultAxesFontSize', 12);
% set(0, 'DefaultFigureWindowStyle', 'docked');
% surf(peaks);
% fig.PaperPositionMode = 'manual';
% orient(fig, 'landscape');
% ax = gca;
% p = plot(ADOS_SOCIAL(2, :), energy(2, 1:40), 'om', 'MarkerSize', 12, 'MarkerFaceColor','m');
% hold on
% l = lsline;
% set(l, 'color', 'k');
% ylim([-0.015 0]);
% box 'off'
% ylabel('Balance energy', 'FontSize', 16);
% xlabel('ADOS-Social scores','FontSize', 16);
% title('Whole brain network during adolescence','FontSize', 16);
% TextLocation('r = -0.5083','Location','northeast');
