function [ax_boxplot] = run_directing_nodes(FC, net_1, net_2)

global subject_count roi_SN roi_EN roi_DMN dir age_group

input = strcat(net_1, {'_'}, net_2);

switch input{1,1}
    case 'SN_EN'
        roi_1 = roi_SN;
        roi_2 = roi_EN;
        print_name_1{1, 1} = cell2mat(strcat(dir(1, 5), 'SN_directs_EN_Frequency.pdf'));
        print_name_1{1, 2} = cell2mat(strcat(dir(1, 5), 'SN_directs_EN_Weights.pdf'));

        print_name_2{1, 1} = cell2mat(strcat(dir(1, 5), 'EN_directs_SN_Frequency.pdf'));
        print_name_2{1, 2} = cell2mat(strcat(dir(1, 5), 'EN_directs_SN_Weights.pdf'));
                
    case 'SN_DMN'
        roi_1 = roi_SN;
        roi_2 = roi_DMN;
        print_name_1{1, 1} = cell2mat(strcat(dir(1, 6), 'SN_directs_DMN_Frequency.pdf'));
        print_name_1{1, 2} = cell2mat(strcat(dir(1, 6), 'SN_directs_DMN_Weights.pdf'));
        
        print_name_2{1, 1} = cell2mat(strcat(dir(1, 6), 'DMN_directs_SN_Frequency.pdf'));
        print_name_2{1, 2} = cell2mat(strcat(dir(1, 6), 'DMN_directs_SN_Weights.pdf'));
        
        
    case 'EN_DMN'
        roi_1 = roi_EN;
        roi_2 = roi_DMN;
        print_name_1{1, 1} = cell2mat(strcat(dir(1, 7), 'EN_directs_DMN_Frequency.pdf'));
        print_name_1{1, 2} = cell2mat(strcat(dir(1, 7), 'EN_directs_DMN_Weights.pdf'));
        
        print_name_2{1, 1} = cell2mat(strcat(dir(1, 7), 'DMN_directs_EN_Frequency.pdf'));
        print_name_2{1, 2} = cell2mat(strcat(dir(1, 7), 'DMN_directs_EN_Weights.pdf'));
        
end



print(fig_directors_1, print_name_1{1,1}, '-dpdf', '-r400');
print(fig_directors_2, print_name_2{1,1}, '-dpdf', '-r400');


% 2) Now calculate and draw the histograms for the weights (energy) of the directing triads
for age = 1:3
    temp_1{age, 1} = cell2mat(directors_1_weight(age, 1:40)); 
    temp_1{age, 2} = cell2mat(directors_1_weight(age, 41:80)); 
    
    temp_2{age, 1} = cell2mat(directors_2_weight(age, 1:40)); 
    temp_2{age, 2} = cell2mat(directors_2_weight(age, 41:80));

end
directors_1_weight = temp_1; % A 3 * 2 cell that contains weights of directing triads from 1st to 2nd net: Rows representing age group, cols representing 1: autism, 2: control
directors_2_weight = temp_2; % A 3 * 2 cell that contains weights of directing triads from 2nd to 1st: rows representing age group, cols representing 1: autism, 2: control

for d = 1:2 % Directing triad which is, 1: from 1st to 2nd net, 2: from 2nd to 1st net
    
    switch d
        case 1
            source = net_1; 
            dest = net_2;
            directors_weight = directors_1_weight;
            print_name = print_name_1;
            bin = 100;
            
        case 2
            source = net_2; 
            dest = net_1;
            directors_weight = directors_2_weight;
            print_name = print_name_2;
            bin = 100;
    end
    
    fig = figure('DefaultAxesFontSize', 12);
    set(0, 'DefaultFigureWindowStyle', 'docked');
    surf(peaks);
    fig.PaperPositionMode = 'manual';
    orient(fig, 'landscape');
    t = tiledlayout(3,1);
    xlabel(t, strcat('Weights of directing triads from', {' '}, source, {' '}, 'to', {' '}, dest), 'FontSize', 12);
    
    for age = 1:3
        ax(1, age) = nexttile;
        h1 = histogram(directors_weight{age, 2}, bin, 'FaceColor', 'g'); % Control hist
        s1 = scatter (h1.BinEdges(1:bin), h1.Values, 'g', 's', 'MarkerEdgeColor', [126/255 47/255 142/255], 'MarkerFaceColor', [0 1 0], 'LineWidth', 1);
        delete(h1);
        
        hold on
        
        h2 = histogram(directors_weight{age, 1}, bin, 'FaceColor', 'm'); % Autism hist
        s2 = scatter (h2.BinEdges(1:bin), h2.Values, 'm', '^', 'MarkerEdgeColor',[18/255 54/255 36/255], 'MarkerFaceColor', [1 0 1], 'LineWidth', 1);
        delete(h2);
               
        alpha(0.6);
        title(age_group{1, age});
        
        set(gca,'xscale','log');
        set(gca,'yscale','log');               
    end
    
    linkaxes([ax(1, 1) ax(1, 2) ax(1, 3)]);
    xlim([0.003 0.1]);
    
    print(fig, print_name{1,2}, '-dpdf', '-r600');
    
end

end
