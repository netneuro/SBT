%% Applying Structural Balance Theory on the resting-state functional brain networks

% Zahra Moradimanesh (zahra.moradimanesh@gmail.com)
% March 2021

% Abbreviations:
% SBT = Structural balance theory, asd: Autism, con: Healthy controls
% VN: Visual Network, SMN: Somato Motor Network, DAN: Dorsal attention Network,
% SN: The Salience Network, CEN: The Executive-control Network, DMN: The Default Mode Network, roi: Regions of interest,
% pos: Positive edges, neg: Negative edges,
% T2: Unbalanced triad with two positive edges, T0: Unbalanced triad with zero positive edges,
% T3: Balanced triad with three positive edges, T1: Balanced triad with one positive edges,

%% ==============
%  Initialization
%  ==============
clc;
clear all;

tic
global subject_count corr roi_whole_brain indexes age_group diagnosis_group bin edges dir network_labels

% Number of subjects in each group
% Rows: Age groups, 1: Childhood, 2: Adolescence, 3: Adulthood
% Cols: Diagnosis group, 1: individuals with autism, 2: healthy participants
subject_count = [40, 40; 40, 40; 40, 40];
age_group = {'childhood', 'adolescence' 'adulthood'};
txt_labels = {'child', 'adolescent', 'adult'};
diagnosis_group = {'Autism', 'Control'};

% ROIs as in the Schaefer-400 17net 2mm atlas:
% https://github.com/ThomasYeoLab/CBIG/blob/master/stable_projects/brain_parcellation/Schaefer2018_LocalGlobal/Parcellations/MNI/Schaefer2018_400Parcels_17Networks_order_FSLMNI152_2mm.nii.gz
roi_whole_brain = 400;
roi_VN = 47;
roi_SMN = 70;
roi_DAN = 52;
roi_SN = 51;
roi_CEN = 61;
roi_DMN = 79;
roi = {roi_whole_brain, roi_VN, roi_SMN, roi_DAN, roi_SN, roi_CEN, roi_DMN, 200, 200, [200, 200]};
network_labels = {'whole brain network', 'VN', 'SMN', 'DAN', 'SN', 'CEN', 'DMN', 'left hemisphere', 'right hemisphere', 'between hemispheres'};

% Index of each subnetworks' elements = [Left hemispere start index, Left hemisphere end index, Right hemispere start index, Right hemisphere end index]
VN_index = [1, 24, 201, 223];
SMN_index = [25, 59, 224, 258];
DAN_index = [60, 85, 259, 284];
SN_index = [86, 108, 285, 312];
CEN_index = [121, 148, 325, 357];
DMN_index = [149, 194, 358, 390];

indexes = {VN_index, SMN_index, DAN_index, SN_index, CEN_index, DMN_index};

bin = 500; % For plotting the histograms


% Get the thresholding method from the user
valid_input = 0;

while ~valid_input
    threshold_method = input('Choose a thresholding method: 1 for no thresholds (fully-connected networks), 2 for t-test on each group, 3 for t-test on all groups, and 4 for G-Lasso threshold:');
    if threshold_method == 1 % No thresholds
        valid_input = 1;
        
        input_dir = '/Volumes/ZAHRA5TB/ongoing_data/zahra_march2021/combat/whole_brain/';
        cd(char(input_dir));
        % Pearson's correlation coefficient matrices which are harmonized using the ComBat method: https://github.com/Jfortin1/ComBatHarmonization
        load('corr_hamonized_child.mat');
        load('corr_hamonized_adol.mat');
        load('corr_hamonized_adult.mat');
        
        % Summerize input as a 3*80 matrix.
        % Rows: Age groups, 1: childhood, 2: adolescence, 3: adulthood.
        % Cols: Correlation matrices for each individuals' brain network, 1-40: autism and 41-80: halthy controls
        whole_brain_corr = [corr_harmonized_child; corr_harmonized_adol; corr_harmonized_adult];
        results_dir = '/Volumes/ZAHRA5TB/ongoing_projects/defence/results/figures/fully_connected/';
        
    elseif threshold_method == 2 % Only keeps those edges that are statistically different from zero within the group using t-test
        valid_input = 1;
        input_dir = '/Volumes/ZAHRA5TB/ongoing_data/zahra_march2021/combat/whole_brain/';
        cd(char(input_dir));
        load('corr_hamonized_child.mat');
        load('corr_hamonized_adol.mat');
        load('corr_hamonized_adult.mat');
        whole_brain_corr = [corr_harmonized_child; corr_harmonized_adol; corr_harmonized_adult];
        
        for age = 1:numel(age_group)
            for s = 1:subject_count(age, 1) % Select correlations of the autism group
                full_corr_asd{1, s} = whole_brain_corr{age, s};
            end
            thresholded_corr_asd = t_test_threshold(full_corr_asd);
            for s = 1:subject_count(age, 2) % Select correlations of the control group
                full_corr_con{1, s} = whole_brain_corr{age, s+subject_count(age, 1)};
            end
            thresholded_corr_con = t_test_threshold(full_corr_con);
            
            thresholded_corr(age, :) = [thresholded_corr_asd, thresholded_corr_con];
            
        end
        
        whole_brain_corr = thresholded_corr;
        results_dir = '/Volumes/ZAHRA5TB/ongoing_projects/defence/results/figures/t_test/';
        disp('Thresholding is done!');
        
    elseif threshold_method == 3 % Only keeps those edges that are statistically different from zero within all the groups using t-test
        valid_input = 1;
        input_dir = '/Volumes/ZAHRA5TB/ongoing_data/zahra_march2021/combat/whole_brain/';
        cd(char(input_dir));
        load('corr_hamonized_child.mat');
        load('corr_hamonized_adol.mat');
        load('corr_hamonized_adult.mat');
        
        temp_corr = [corr_harmonized_child, corr_harmonized_adol, corr_harmonized_adult];
        thresholded_corr = t_test_threshold(temp_corr);
        
        whole_brain_corr = [thresholded_corr(1, 1:80); thresholded_corr(1, 81:160); thresholded_corr(1, 161:240)];
        results_dir = '/Volumes/ZAHRA5TB/ongoing_projects/defence/results/figures/t_test_equal_density/';
        disp('Thresholding is done!');
        
        
    elseif threshold_method == 4
        valid_input = 1;
        
        % load glasso functional connectivities, that are thresholded using python's G-Lasso
        alpha = input('What is the alpha value you wish to load the related functional connectivity?');
        input_dir = strcat('/Volumes/ZAHRA5TB/ongoing_data/zahra_march2021/corr_glasso_', num2str(alpha, '%.3f'),'/');
        cd(char(input_dir));
        % create a cell for MATLAB out of txt files that are python's G-Lasso outputs
        for age = 1: numel(age_group)
            temp_dir = strcat(input_dir, num2str(age), '.', {' '}, age_group{1, age});
            temp_name = strcat('corr_glasso_', txt_labels{1, age}, '_');
            output_cell{1, age} = txt2cell(temp_dir, temp_name);
        end
        
        whole_brain_corr = [output_cell{1, 1}; output_cell{1, 2}; output_cell{1, 3}];
        results_dir = strcat('/Volumes/ZAHRA5TB/ongoing_projects/defence/results/figures/glasso_', num2str(alpha), '/');
        
    else, warning('Please enter a valid number for the threshold method :)');
    end
end


% Extract sub-networks from the whole brain network
[single_nets, double_nets, triple_nets] = extract_sub_networks(whole_brain_corr);
between_hemisphere = whole_brain_corr;

dir = {char(strcat(results_dir, '1.', {' '}, 'whole_brain/')), char(strcat(results_dir, '2.', {' '}, 'VN/')),...
    char(strcat(results_dir, '3.', {' '}, 'SMN/')), char(strcat(results_dir, '4.', {' '}, 'DAN/')),...
    char(strcat(results_dir, '5.', {' '}, 'SN/')), char(strcat(results_dir, '6.', {' '}, 'CEN/')),...
    char(strcat(results_dir, '7.', {' '}, 'DMN/')), char(strcat(results_dir, '8.', {' '}, 'Left Hemisphere/')), char(strcat(results_dir, '9.', {' '}, 'Right Hemisphere/'))};
network_type = ones(1, 9); % single networks

dir{1, 10} = char(strcat(results_dir, '10.', {' '}, 'Between hemispheres/'));
network_type(1, 10) = 2;


count = 11;
for i = 2:6
    for j = i+1:7
        roi{1, count} = [roi{1, i}, roi{1, j}];
        network_labels{1, count} = char(strcat(network_labels{1, i}, '-', network_labels{1, j}));
        dir{1, count} = char(strcat(results_dir, num2str(count), '.', {' '}, network_labels{1, count}, '/'));
        network_type(1, count) = 2; % double networks
        count = count +1;
    end
end
for i = 2:5
    for j = i+1:6
        for k = j+1:7
            roi{1, count} = [roi{1, i}, roi{1, j}, roi{1, k}];
            network_labels{1, count} = char(strcat(network_labels{1, i}, '-', network_labels{1, j}, '-', network_labels{1, k}));
            dir{1, count} = char(strcat(results_dir, num2str(count), '.', {' '}, network_labels{1, count}, '/'));
            network_type(1, count) = 3; % triple networks
            count = count + 1;
        end
    end
end

networks = {whole_brain_corr, single_nets{1, :}, between_hemisphere, double_nets{1, :}, triple_nets{1, :}};

% Create a folder for each network to save the final results
for directory = 1:numel(networks)
    if not(isfolder(dir{1, directory}))
        status = mkdir(dir{1, directory});
        if ~status
            error('Please login as a user with permission to create folder :)');
        end
    end
end

%% =======================================================================
%  Analysis of networks' parameters based on the Structural Balance Theory
%  =======================================================================
disp('SBT analysis is started...');
for net = 1:numel(networks)
    disp(strcat('analysis of the', {' '}, network_labels{1, net}, {' '}, 'is started...'));
    
    %==========================================================================================================
    % 1) Calculate parameters of the structural balance theory at two scales, that is,
    % Single-level analysis for brain's energy, frequency of links and triads for every subject in every age group
    % and ensamble-network analysis for triads' weights and directing triads' weights as follows:
    
    corr = networks{1, net};
    
    for age = 1:numel(age_group)  %1: Childhood, 2: Adolescence, 3: Adulthood
        
        % 1.1 First we work on the ensamble networks
        temp{age, 1} = cat(3, corr{age, 1:40}); % autism
        temp{age, 2} = cat(3, corr{age, 41:80}); % controls
        
        for group = 1:2 % group = 1: autism, = 2: control
            
            ensamble_net{age, group} = mean(temp{age, group}, 3); % This is the ensamble brain network, stored in a 3*2 cell: rows age groups, cols: 1 autism, 2 controls
            
            % 1.1.2. Compute weights of links for the ensamble networks
            if network_type(1, net) < 2 % single neworks
                links_temp{age, group} = nonzeros(tril(ensamble_net{age, group}));
            else % Networks with more than one subnetworks
                ensamble_net_interactions{age, group} = zeros(sum(roi{1, net}));
                for i = 1:(sum(roi{1, net}))
                    for j = 1:(sum(roi{1, net}))
                        a = roi{1, net}(1, 1);
                        b = roi{1, net}(1, 2);
                        switch network_type(1, net)
                            case 2
                                if ~((i <= a && j <= a) || (i > a && j > a)) % For edges that are not only in 1st or 2nd subnets
                                    ensamble_net_interactions{age, group}(i, j) = ensamble_net{age, group}(i ,j);
                                end
                            case 3
                                if ~((i <= a && j <= a) || ((i > a && i <= a + b) && (j > a && j <= a +b)) || (i > a + b  && j > a + b)) % For edges that are not only in 1st or 2nd subnets
                                    ensamble_net_interactions{age, group}(i, j) = ensamble_net{age, group}(i ,j);
                                end
                        end
                    end
                end
                links_temp{age, group} = nonzeros(tril(ensamble_net_interactions{age, group}));
            end
            links_distribution_ensamble{1, 1} = links_temp;
            
            % 1.1.2. Compute weights (or the so-called energy) of triads for the ensamble networks
            [energy_T2, energy_T0, energy_T3, energy_T1] = energy_of_triads(ensamble_net{age, group}, roi{1, net}, network_type(1, net));
            triads_temp{age, group} = {energy_T2, energy_T0, energy_T3, energy_T1};
            for triad = 1:4 % Four types of triads as, 1: T2 = ( + + - ), 2: T0 = ( - - - ), 3: T3 = ( + + + ), 4: T1 = ( + - - )
                triads_distribution_ensamble{1, triad}{age, group} = nonzeros(reshape(triads_temp{age, group}{1, triad}, [1, sum(roi{1, net}), sum(roi{1, net}), sum(roi{1, net})]));
            end
            
            % 1.1.3. Compute the distribution of directing, segregating and integrating triads between subnetworks
            if network_type(1, net) >= 2 % Is only valid for nets consisting of 2 or more subnets
                interactions{age, group} = inter_network_analysis(ensamble_net{age, group}, roi{1, net}); % Find directing triads from 1st to 2nd net (directors_1) and vice versa (directors_2)
                for i = 1:numel(interactions{age, group})
                    if ~(isempty(interactions{age, group}{1, i}))
                        interactions_distribution_ensamble{1, i}{age, group} = interactions{age, group}{1, i}(4, :)';
                    end
                end
            end
        end
        % 1.2 Now we start the single-level analysis on each of participants' brain networks
        for s = 1:subject_count(age, 1) + subject_count(age, 2) % 1-40: Individuals with autism, 41-80: Healthy participants
            
            % 1.2.1. Calculate the overall energy of the network
            energy{1, net}(age, s) = U(corr{age, s}, roi{1, net}, network_type(1, net)); % U is the balance energy as defined in: Marvel, Seth A., Steven H. Strogatz, and Jon M. Kleinberg. "Energy landscape of social balance." Physical review letters 103.19 (2009).
            
            %             % 1.2.2. Count frequency and weight of links
            %             [pos_count(age, s), neg_count(age, s), ~, ~] = pos_neg(corr{age, s});
            %             links_distribution_individuals{age, s} = nonzeros(tril(corr{age, s}));
            %
            %             % 1.2.3. Count frequency of triads
            %             [energy_T2, energy_T0, energy_T3, energy_T1] = energy_of_triads(corr{age, s});
            %             triads_energy = {energy_T2, energy_T0, energy_T3, energy_T1};
            %             for t = 1:4 % Four types of triads as, 1: T2 = ( + + - ), 2: T0 = ( - - - ), 3: T3 = ( + + + ), 4: T1 = ( + - - )
            %                 triads_distribution_individuals{1, t}{age, s} = nonzeros(reshape(triads_energy{1, t}, [1, sum(roi{1,net}), sum(roi{1,net}), sum(roi{1,net})]));
            %                 triads_frequency{1, t}(age, s) = numel(triads_distribution_individuals{1, t}{age, s});
            %             end
            %             clearvars triads_energy
            %
            %             % 1.2.4. Analysis of the frequency of directing triads
            %             if ~single_net % Is only valid for nets consisting of 2 or more sub-nets
            %                 [directors{1, 1}{age, s}, directors{1, 2}{age, s}] = directing_triads(corr{age, s}, roi{1, net}(1, 1), roi{1, net}(1, 2)); % Find directing triads from 1st to 2nd net (directors_1) and vice versa (directors_2)
            %                 for d = 1:2 % Direction, 1: From 1st to 2nd net, 2: From 2nd to 1st net
            %                     [~, directors_frequency{1, d}(age, s)] = size(directors{1, d}{age, s}); % Returns a 3*80 matrix containing frequency of directing triads for each participant in different agr ranges
            %                 end
            %             else % Skip networks with zero subnets, in which analysis of the directing triads is not relevant
            %                 directors_frequency = {[], []};
            %             end
            %
            %             disp(strcat('From', {' '}, age_group{1, age}, {' '}, 'subject', {' '}, num2str(s),{' '}, 'is done!'));
        end
    end
    
    % Brian behavior relation
%     [ax_behavioral, fig_behavioral] = defence_behavioral(energy, net);
    
%     % Summerize the calculated parameters in a 1*15 cell, rows represent each of the calculated parameters
%     
%     SBT_parameters = {energy, links_distribution_ensamble{1,:}, triads_distribution_ensamble{1,:}};
%     SBT_parameters_labels = {'Balance energy', 'Links distribution', 'T_2 distribution', 'T_0 distribution', 'T_3 distribution', 'T_1 distribution'};
%     if network_type(1, net) == 2
%         SBT_parameters = {SBT_parameters{1, :}, interactions_distribution_ensamble{1, :}};
%         SBT_parameters_labels = {SBT_parameters_labels{:}, 'T^{\prime}_2_a distribution', 'T^{\prime}_2_b distribution',...
%             'T^{\prime}_3_a distribution', 'T^{\prime}_3_b distribution',...
%             'T^{\prime}_1_a distribution', 'T^{\prime}_1_b distribution',...
%             'T^{\prime}_0_a distribution', 'T^{\prime}_0_b distribution'};
%     elseif network_type(1, net) == 3
%         SBT_parameters = {SBT_parameters{1, :}, interactions_distribution_ensamble{1, :}};
%         SBT_parameters_labels = {SBT_parameters_labels{:}, 'T^{\prime\prime}_2_a distribution', 'T^{\prime\prime}_2_b distribution',...
%             'T^{\prime\prime}_2_c distribution', 'T^{\prime\prime}_1_c distribution', 'T^{\prime\prime}_1_a distribution',...
%             'T^{\prime\prime}_1_b distribution', 'T^{\prime\prime}_3 distribution', 'T^{\prime\prime}_0 distribution'};
%     end
%     
%     % ========================================================================================================================
%     % 2) Check differnces of overall patterns using ANCOVA. Independent variables: Group and age, Dependent variable: Energy
%     
%     
%     
%     % =============================================
%     % 3) Box plots of the parameters' frequencies
%     
%     for parameter = 1:1 % Only for energy draw the boxplot
%         if ~isempty(SBT_parameters{1, parameter})
%             % 3.1. First check whether differences are statistically significant regarding frequencies, using Mann-Whitney U test
%             [p{1, parameter}, effect_size{1, parameter}] = defence_ranksum(SBT_parameters{1, parameter});
%             
%             % 3.2. Draw the boxplots
%             [ax{1, parameter}(1, 1), fig{1, parameter}(1, 1)] = defence_boxplot(SBT_parameters{1, parameter}, p{1, parameter},  effect_size{1, parameter}, network_labels{1, net}, SBT_parameters_labels{1, parameter});
%         end
%     end
%     
%     %     % Synchronize the y-axes for negative and positive plots within the network
%     %     linkaxes([ax{1, 2}(1,net) ax{1, 3}(1,net)], 'y');
%     %
%     %     % Synchronize the y-axes for T2, T3 and T1 within the network
%     %     linkaxes([ax{1, 4}(1,net) ax{1, 6}(1,net) ax{1, 7}(1,net)], 'y');
%     %
%     %     if ~single_net
%     %         % Synchronize the y-axes for directing triads
%     %         linkaxes([ax{1, 8}(1, net) ax{1, 9}(1, net)], 'y');
%     %     end
%     %
%     % ==========================================
%     % 4) Histograms of the parameters' weights.
%     % Note: This analysis is done on the ensamble networks.
%     
%     for parameter = 2:numel(SBT_parameters) % For links', triads', and directing triads' distribution
%         edges = [];
%         for age = 1:numel(age_group)
%             if ~isempty(SBT_parameters{1, parameter})
%                 
%                 dist_asd = SBT_parameters{1, parameter}{age, 1};
%                 dist_con = SBT_parameters{1, parameter}{age, 2};
%                 
%                 % 4.1. Compute the distance between triads' weights' distributions using KL-Divergence
%                 kl(parameter, age) = defence_KL(dist_asd, dist_con);
%                 
%                 % 4.2. Draw the histogram of triads' weights
%                 mod{1, parameter}(age, 1) = 1;
%                 if parameter == 2 || numel(dist_asd) < 400 || numel(dist_con) < 400
%                     mod{1, parameter}(age, 1) = 0;
%                     
%                 end
%                 [ax{1, parameter}(age, 1), fig{1, parameter}(age, 1)] = defence_hist(dist_asd, dist_con, kl(parameter, age), strcat(network_labels{1, net}, {' during '}, age_group{1, age}), SBT_parameters_labels{1, parameter}, mod{1, parameter}(age, 1));
%                 if isempty(dist_asd) || isempty(dist_con)
%                     mod{1, parameter}(age, 1) = 100;
%                 end
%             else
%                 fig{1, parameter}(age, 1) = gobjects;
%             end
%         end
%         
%     end
%     linkaxes([ax{1, 2}(1, 1) ax{1, 2}(2, 1) ax{1, 2}(3, 1)]); % links across age
%     if net == 1
%         linkaxes([ax{1, 3}(1, 1) ax{1, 5}(1, 1)]);
%         linkaxes([ax{1, 4}(1, 1) ax{1, 4}(2, 1) ax{1, 4}(3, 1)]);
%         linkaxes([ax{1, 3}(1, 1) ax{1, 3}(2, 1) ax{1, 3}(3, 1)]);
%         linkaxes([ax{1, 5}(1, 1) ax{1, 5}(2, 1) ax{1, 5}(3, 1)]);
%         linkaxes([ax{1, 6}(1, 1) ax{1, 6}(2, 1) ax{1, 6}(3, 1)]);
%     end
%         
% % %     % Sync axes of links and triads across three age ranges. Do not sync hists withour scatter with hists with scatters.
% % %     for parameter = 2:6
% % %         s = mod{1, parameter}(1, 1) + mod{1, parameter}(2, 1) + mod{1, parameter}(3, 1);
% % %         if s <= 3 % no empty plot
% % %             if s == 3 || s == 0
% % %                 linkaxes([ax{1, parameter}(1, 1) ax{1, parameter}(2, 1) ax{1, parameter}(3, 1)]);
% % %             elseif s == 2 % only one hist without scatter
% % %                 if mod{1, parameter}(1, 1) == 0
% % %                     linkaxes([ax{1, parameter}(2, 1) ax{1, parameter}(3, 1)]);
% % %                 elseif mod{1, parameter}(2, 1) == 0
% % %                     linkaxes([ax{1, parameter}(1, 1) ax{1, parameter}(3, 1)]);
% % %                 elseif mod{1, parameter}(3, 1) == 0
% % %                     linkaxes([ax{1, parameter}(1, 1) ax{1, parameter}(2, 1)]);
% % %                 end
% % %             elseif s == 1 % two hists without scatter
% % %                 if mod{1, parameter}(1, 1) == 1
% % %                     linkaxes([ax{1, parameter}(2, 1) ax{1, parameter}(3, 1)]);
% % %                 elseif mod{1, parameter}(2, 1) == 1
% % %                     linkaxes([ax{1, parameter}(1, 1) ax{1, parameter}(3, 1)]);
% % %                 elseif mod{1, parameter}(3, 1) == 1
% % %                     linkaxes([ax{1, parameter}(1, 1) ax{1, parameter}(2, 1)]);
% % %                 end
% % %             end
% % %         elseif s <= 110 % one empty plot
% % %             if mod{1, parameter}(1, 1) == 100
% % %                 linkaxes([ax{1, parameter}(2, 1) ax{1, parameter}(3, 1)]);
% % %             elseif mod{1, parameter}(2, 1) == 100
% % %                 linkaxes([ax{1, parameter}(1, 1) ax{1, parameter}(3, 1)]);
% % %             elseif mod{1, parameter}(3, 1) == 100
% % %                 linkaxes([ax{1, parameter}(1, 1) ax{1, parameter}(2, 1)]);
% % %             end
% % %         end
% % %     end
% % %     
% % %     % Sync axes for each age range across T2, T3 and T1
% % %     for age = 1:numel(age_group)
% % %         s = mod{1, 3}(age, 1) + mod{1, 5}(age, 1) + mod{1, 6}(age, 1);
% % %         if s <= 3 % no empty plot
% % %             if s == 3 || s == 0
% % %                 linkaxes([ax{1, 3}(age, 1) ax{1, 5}(age, 1) ax{1, 6}(age, 1)]);
% % %             elseif s == 2 % only one hist without scatter
% % %                 if mod{1, 3}(age, 1) == 0
% % %                     linkaxes([ax{1, 5}(age, 1) ax{1, 6}(age, 1)]);
% % %                 elseif mod{1, 5}(age, 1) == 0
% % %                     linkaxes([ax{1, 3}(age, 1) ax{1, 6}(age, 1)]);
% % %                 elseif mod{1, 6}(age, 1) == 0
% % %                     linkaxes([ax{1, 3}(age, 1) ax{1, 5}(age, 1)]);
% % %                 end
% % %             elseif s == 1 % two hists without scatter
% % %                 if mod{1, 3}(age, 1) == 1
% % %                     linkaxes([ax{1, 5}(age, 1) ax{1, 6}(age, 1)]);
% % %                 elseif mod{1, 5}(age, 1) == 1
% % %                     linkaxes([ax{1, 3}(age, 1) ax{1, 6}(age, 1)]);
% % %                 elseif mod{1, 6}(age, 1) == 1
% % %                     linkaxes([ax{1, 3}(age, 1) ax{1, 5}(age, 1)]);
% % %                 end
% % %             end
% % %         elseif s <= 110 % one empty plot
% % %             if mod{1, 3}(age, 1) == 100
% % %                 linkaxes([ax{1, 5}(2, 1) ax{1, 6}(3, 1)]);
% % %             elseif mod{1, 5}(2, 1) == 100
% % %                 linkaxes([ax{1, 3}(1, 1) ax{1, 6}(3, 1)]);
% % %             elseif mod{1, 6}(3, 1) == 100
% % %                 linkaxes([ax{1, 3}(1, 1) ax{1, 5}(2, 1)]);
% % %             end
% % %         end
% % %     end
% % %     
% % %     
% % %     if network_type(1, net) == 2
% % %         % Synchronize axes for the directing, integrating and segregating triads across age groups
% % %         for parameter = 7:12
% % %             s = mod{1, parameter}(1, 1) + mod{1, parameter}(2, 1) + mod{1, parameter}(3, 1);
% % %             if s <= 3 % no empty plot
% % %                 if s == 3 || s == 0
% % %                     linkaxes([ax{1, parameter}(1, 1) ax{1, parameter}(2, 1) ax{1, parameter}(3, 1)]);
% % %                 elseif s == 2 % only one hist without scatter
% % %                     if mod{1, parameter}(1, 1) == 0
% % %                         linkaxes([ax{1, parameter}(2, 1) ax{1, parameter}(3, 1)]);
% % %                     elseif mod{1, parameter}(2, 1) == 0
% % %                         linkaxes([ax{1, parameter}(1, 1) ax{1, parameter}(3, 1)]);
% % %                     elseif mod{1, parameter}(3, 1) == 0
% % %                         linkaxes([ax{1, parameter}(1, 1) ax{1, parameter}(2, 1)]);
% % %                     end
% % %                 elseif s == 1 % two hists without scatter
% % %                     if mod{1, parameter}(1, 1) == 1
% % %                         linkaxes([ax{1, parameter}(2, 1) ax{1, parameter}(3, 1)]);
% % %                     elseif mod{1, parameter}(2, 1) == 1
% % %                         linkaxes([ax{1, parameter}(1, 1) ax{1, parameter}(3, 1)]);
% % %                     elseif mod{1, parameter}(3, 1) == 1
% % %                         linkaxes([ax{1, parameter}(1, 1) ax{1, parameter}(2, 1)]);
% % %                     end
% % %                 end
% % %             elseif s <= 110 % one empty plot
% % %                 if mod{1, parameter}(1, 1) == 100
% % %                     linkaxes([ax{1, parameter}(2, 1) ax{1, parameter}(3, 1)]);
% % %                 elseif mod{1, parameter}(2, 1) == 100
% % %                     linkaxes([ax{1, parameter}(1, 1) ax{1, parameter}(3, 1)]);
% % %                 elseif mod{1, parameter}(3, 1) == 100
% % %                     linkaxes([ax{1, parameter}(1, 1) ax{1, parameter}(2, 1)]);
% % %                 end
% % %             end
% % %         end
% % %         
% % %         % Sync axes for each age range across directing triad, integrating triads and segregating trids
% % %         for parameters = 7:2:12
% % %             for age = 1:numel(age_group)
% % %                 s = mod{1, parameters}(age, 1) + mod{1, parameters + 1}(age, 1);
% % %                 if s <= 2 % no empty plot
% % %                     if s == 2 || s == 0
% % %                         linkaxes([ax{1, parameters}(age, 1) ax{1, parameters + 1}(age, 1)]);
% % %                     end
% % %                 end
% % %             end
% % %         end
% % %     end
% % %     
% % %     if network_type(1, net) == 3
% % %         for parameters = 7:14
% % %             s = mod{1, parameter}(1, 1) + mod{1, parameter}(2, 1) + mod{1, parameter}(3, 1);
% % %             if s <= 3 % no empty plot
% % %                 if s == 3 || s == 0
% % %                     linkaxes([ax{1, parameter}(1, 1) ax{1, parameter}(2, 1) ax{1, parameter}(3, 1)]);
% % %                 elseif s == 2 % only one hist without scatter
% % %                     if mod{1, parameter}(1, 1) == 0
% % %                         linkaxes([ax{1, parameter}(2, 1) ax{1, parameter}(3, 1)]);
% % %                     elseif mod{1, parameter}(2, 1) == 0
% % %                         linkaxes([ax{1, parameter}(1, 1) ax{1, parameter}(3, 1)]);
% % %                     elseif mod{1, parameter}(3, 1) == 0
% % %                         linkaxes([ax{1, parameter}(1, 1) ax{1, parameter}(2, 1)]);
% % %                     end
% % %                 elseif s == 1 % two hists without scatter
% % %                     if mod{1, parameter}(1, 1) == 1
% % %                         linkaxes([ax{1, parameter}(2, 1) ax{1, parameter}(3, 1)]);
% % %                     elseif mod{1, parameter}(2, 1) == 1
% % %                         linkaxes([ax{1, parameter}(1, 1) ax{1, parameter}(3, 1)]);
% % %                     elseif mod{1, parameter}(3, 1) == 1
% % %                         linkaxes([ax{1, parameter}(1, 1) ax{1, parameter}(2, 1)]);
% % %                     end
% % %                 end
% % %             elseif s <= 110 % one empty plot
% % %                 if mod{1, parameter}(1, 1) == 100
% % %                     linkaxes([ax{1, parameter}(2, 1) ax{1, parameter}(3, 1)]);
% % %                 elseif mod{1, parameter}(2, 1) == 100
% % %                     linkaxes([ax{1, parameter}(1, 1) ax{1, parameter}(3, 1)]);
% % %                 elseif mod{1, parameter}(3, 1) == 100
% % %                     linkaxes([ax{1, parameter}(1, 1) ax{1, parameter}(2, 1)]);
% % %                 end
% % %             end
% % %             
% % %         end
% % %         
% % %         
% % %         % Synchronize axes for the directing triads across age groups
% % %         for parameter = 7:3:12
% % %             for age = 1:numel(age_group)
% % %                 s = mod{1, parameter}(age, 1) + mod{1, parameter + 1}(age, 1) + mod{1, parameter + 2}(age, 1);
% % %                 if s <= 3 % no empty plot
% % %                     if s == 3 || s == 0
% % %                         linkaxes([ax{1, parameter}(age, 1) ax{1, parameter + 1}(age, 1) ax{1, parameter + 2}(age, 1)]);
% % %                     elseif s == 2 % only one hist without scatter
% % %                         if mod{1, parameter}(age, 1) == 0
% % %                             linkaxes([ax{1, parameter + 1}(age, 1) ax{1, parameter + 2}(age, 1)]);
% % %                         elseif mod{1, parameter + 1}(age, 1) == 0
% % %                             linkaxes([ax{1, parameter}(age, 1) ax{1, parameter + 2}(age, 1)]);
% % %                         elseif mod{1, parameter + 2}(age, 1) == 0
% % %                             linkaxes([ax{1, parameter}(age, 1) ax{1, parameter + 1}(age, 1)]);
% % %                         end
% % %                     elseif s == 1 % two hists without scatter
% % %                         if mod{1, parameter}(age, 1) == 1
% % %                             linkaxes([ax{1, parameter + 1}(age, 1) ax{1, parameter + 2}(age, 1)]);
% % %                         elseif mod{1, parameter + 1}(age, 1) == 1
% % %                             linkaxes([ax{1, parameter}(age, 1) ax{1, parameter + 2}(age, 1)]);
% % %                         elseif mod{1, parameter + 2}(age, 1) == 1
% % %                             linkaxes([ax{1, parameter}(age, 1) ax{1, parameter + 1}(age, 1)]);
% % %                         end
% % %                     end
% % %                 elseif s <= 110 % one empty plot
% % %                         if mod{1, parameter}(age, 1) == 100
% % %                             linkaxes([ax{1, parameter + 1}(age, 1) ax{1, parameter + 2}(age, 1)]);
% % %                         elseif mod{1, parameter + 1}(age, 1) == 100
% % %                             linkaxes([ax{1, parameter}(age, 1) ax{1, parameter + 2}(age, 1)]);
% % %                         elseif mod{1, parameter + 2}(age, 1) == 100
% % %                             linkaxes([ax{1, parameter}(age, 1) ax{1, parameter + 1}(age, 1)]);
% % %                         end
% % %                 end
% % %             end
% % %         end
% % %     end
% 
%     if network_type(1, net) == 2
%         SBT_parameters_labels = {SBT_parameters_labels{:, 1:6}, 'T-prime-2a Distribution', 'T-prime-2b Distribution',...
%             'T-prime-3a Distribution', 'T-prime-3b Distribution',...
%             'T-prime-1a Distribution', 'T-prime-1b Distribution',...
%             'T-prime-0a Distribution', 'T-prime-0b Distribution'};
%     elseif network_type(1, net) == 3
%         SBT_parameters_labels = {SBT_parameters_labels{:, 1:6}, 'T-zegond-2a Distribution', 'T-zegond-2b Distribution',...
%             'T-zegond-2c Distribution', 'T-zegond-1c Distribution', 'T-zegond-1a Distribution',...
%             'T-zegond-1b Distribution', 'T-zegond-3 Distribution', 'T-zegond-0 Distribution'};
%     end
    
%     % 6) Save the figures as pdf files in the defined directory
%     quote = char(39);
%     command = char(strcat('gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=', quote, network_labels{1, net}, '.pdf', quote));
%     for parameter = 1:numel(SBT_parameters)
%         if isa(fig{1, parameter}(1, 1), 'matlab.ui.Figure') % Check if we have a figure
%             if parameter == 1
%                 print_name = strcat(dir{1, net}, SBT_parameters_labels{1, parameter}, '.pdf');
%                 print(fig{1, parameter}(1, 1), print_name, '-dpdf', '-r400'); % to print each fig as a single pdf
%                 command = char(strcat(command, {' '}, quote, SBT_parameters_labels{1, parameter}, '.pdf', quote));
%                 
%             elseif parameter > 1 % For triads' and directing triads' weights we have 3 figures for each triads' types, one for each age group
%                 for age = 1:numel(age_group)
%                     print_name = char(strcat(dir{1, net}, SBT_parameters_labels{1, parameter}, '_', num2str(age), '.', {' '}, age_group{1, age}, '.pdf'));
%                     print(fig{1, parameter}(age, 1), print_name, '-dpdf', '-r400'); % to print each fig as a single pdf
%                     command = char(strcat(command, {' '}, quote, SBT_parameters_labels{1, parameter}, '_', num2str(age), '.', {' '}, age_group{1, age}, '.pdf', quote));
%                     
%                 end
%             end
%         end
%     end
%     cd(char(dir{1, net}));
%     [status, cmdout] = system(command); % to merge all pdfs in one single pdf
%     source = strcat(quote, network_labels{1, net}, '.pdf', quote);
%     clear command
%     close all
%     clear interactions_distribution_ensamble
    disp(strcat(network_labels{1, net}, {' '}, 'is done!'));
    
end

%================================================================================================================
% 5) Sycnchronize axes which are close to each other across different networks so to better compare the results

% % 5.1. For energy (ax{1, 1}), sync axes between the three single subnets and the three soublenets
% linkaxes([ax{1, 1}(1, 3) ax{1, 1}(1, 4) ax{1, 1}(1, 5)]);
% linkaxes([ax{1, 1}(1, 6) ax{1, 1}(1, 7) ax{1, 1}(1, 8)]);
%
% % 5.2. For links and triads, sync axes between SN, CEN and DMN from one hand, and SN_CEN, SN_DMN and CEN_DMN from the other hand
% for parameter = 3:8
%     if parameter == 7 || parameter == 8  % Case of the directing triads
%         linkaxes([ax{1, parameter}(1, 7) ax{1, parameter}(1, 8)]);
%     else
%         %         linkaxes([ax{1, parameter}(1, 3) ax{1, parameter}(1, 4) ax{1, parameter}(1, 5)]); % Sync the axes to positive links between SN, CEN and DMN
%         linkaxes([ax{1, parameter}(1, 6) ax{1, parameter}(1, 7) ax{1, parameter}(1, 8)]); % Sync the axes to positive links between SN-CEN, SN-DMN and CEN-DMN
%     end
% end
%

clear mod
disp("That's it :) You can now check your directory for the results!");
elapsed_time = toc;
disp(strcat("Elapsed time is:", {' '}, num2str(elapsed_time / 60, '%.2f'), {' '}, 'minutes and',...
    {' '}, num2str(mod(elapsed_time, 60), '%.2f'), {' '}, 'seconds.'));
