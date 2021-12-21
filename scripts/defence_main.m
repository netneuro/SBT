%% Applying Structural Balance Theory on the resting-state functional brain networks 

% Zahra Moradimanesh (zahra.moradimanesh@gmail.com)
% March 2021 

% Abbreviations:
    % SBT = Structural balance theory, asd: Autism, con: Healthy controls
    % SN: The Salience Network, EN: The Executive-control Network, DMN: The Default Mode Network, roi: Regions of interest, 
    % pos: Positive edges, neg: Negative edges,
    % T2: Unbalanced triad with two positive edges, T0: Unbalanced triad with zero positive edges, 
    % T3: Balanced triad with three positive edges, T1: Balanced triad with one positive edges, 

%% ==============
%  Initialization
%  ==============
clc; 
clear all;
global subject_count corr roi_whole_brain roi_SN roi_EN roi_DMN age_group diagnosis_group bin

% Number of subjects in each group
% Rows: Age groups, 1: Childhood, 2: Adolescence, 3: Adulthood
% Cols: Diagnosis group, 1: individuals with autism, 2: healthy participants 
subject_count = [40, 40; 40, 40; 40, 40]; 
age_group = {'Childhood', 'Adolescence' 'Adulthood'};
txt_labels = {'child', 'adolescent', 'adult'};
diagnosis_group = {'Autism', 'Control'};

% ROIs as in the Schaefer-400 17net 2mm atlas: 
% https://github.com/ThomasYeoLab/CBIG/blob/master/stable_projects/brain_parcellation/Schaefer2018_LocalGlobal/Parcellations/MNI/Schaefer2018_400Parcels_17Networks_order_FSLMNI152_2mm.nii.gz
roi_whole_brain = 400; 
roi_SN = 51;
roi_EN = 61;
roi_DMN = 79;

bin = 500; % For plotting the histograms

% Choose the thresholding method
valid_input = 0;

while ~valid_input
    threshold_method = input('Choose a thresholding method: 1 for no thresholds (fully-connected networks), 2 for t-test on each group, 3 for t-test on all groups, and 4 for G-Lasso threshold:');   
    if threshold_method == 1 % No thresholds
        valid_input = 1; 
        
        input_dir = '/media/zahra/ZAHRA5TB/ongoing_data/zahra_march2021/combat/whole_brain/'; 
        cd(char(input_dir));
        % Pearson's correlation coefficient matrices which are harmonized using the ComBat method: https://github.com/Jfortin1/ComBatHarmonization
        load('corr_hamonized_child.mat');
        load('corr_hamonized_adol.mat');
        load('corr_hamonized_adult.mat');
        
        % Summerize input as a 3*80 matrix. 
        % Rows: Age groups, 1: childhood, 2: adolescence, 3: adulthood. 
        % Cols: Correlation matrices for each individuals' brain network, 1-40: autism and 41-80: halthy controls
        whole_brain_corr = [corr_harmonized_child; corr_harmonized_adol; corr_harmonized_adult]; 
        results_dir = '/media/zahra/ZAHRA5TB/ongoing_projects/defence/results/figures/fully_connected/';

    elseif threshold_method == 2 % Only keeps those edges that are statistically different from zero within the group using t-test
        valid_input = 1;        
        input_dir = '/media/zahra/ZAHRA5TB/ongoing_data/zahra_march2021/combat/whole_brain/';
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
        results_dir = '/media/zahra/ZAHRA5TB/ongoing_projects/defence/results/figures/t_test/';
        disp('Thresholding is done!');

    elseif threshold_method == 3 % Only keeps those edges that are statistically different from zero within all the groups using t-test
        valid_input = 1;        
        input_dir = '/media/zahra/ZAHRA5TB/ongoing_data/zahra_march2021/combat/whole_brain/';
        cd(char(input_dir));
        load('corr_hamonized_child.mat');
        load('corr_hamonized_adol.mat');
        load('corr_hamonized_adult.mat');
        
        temp_corr = [corr_harmonized_child, corr_harmonized_adol, corr_harmonized_adult]; 
        thresholded_corr = t_test_threshold(temp_corr);  
 
        whole_brain_corr = [thresholded_corr(1, 1:80); thresholded_corr(1, 81:160); thresholded_corr(1, 161:240)];        
        results_dir = '/media/zahra/ZAHRA5TB/ongoing_projects/defence/results/figures/t_test_equal_density/';
        disp('Thresholding is done!');        
        
        
    elseif threshold_method == 4 
        valid_input = 1;
        
        % load glasso functional connectivities, that are thresholded using python's G-Lasso       
        alpha = input('What is the alpha value you wish to load the related functional connectivity?');
        input_dir = strcat('/media/zahra/ZAHRA5TB/ongoing_data/zahra_march2021/corr_glasso_', num2str(alpha),'/');
        cd(char(input_dir));
        % create a cell for MATLAB out of txt files that are python's G-Lasso outputs
        for age = 1: numel(age_group)
           temp_dir = strcat(input_dir, num2str(age), '.', {' '}, age_group{1, age});
           temp_name = strcat('corr_glasso_', txt_labels{1, age}, '_');
           output_cell{1, age} = txt2cell(temp_dir, temp_name);            
        end
              
        whole_brain_corr = [output_cell{1, 1}; output_cell{1, 2}; output_cell{1, 3}];               
        results_dir = strcat('/media/zahra/ZAHRA5TB/ongoing_projects/defence/results/figures/glasso_', num2str(alpha), '/');
     
    else, warning('Please enter a valid number for the threshold method :)');
    end
end

% Create a folder for each network to save the final results
dir = {strcat(results_dir, 'whole_brain/'), strcat(results_dir, 'SN/'), strcat(results_dir, 'EN/'),...
    strcat(results_dir, 'DMN/'), strcat(results_dir, 'SN_EN/'), strcat(results_dir, 'SN_DMN/'), strcat(results_dir, 'EN_DMN/')};
for directory = 1:7 
    if not(isfolder(dir{1, directory}))
        status = mkdir(dir{1, directory}); 
        if ~status 
            error('Please login as a user with permission to create folders :)');
        end
    end
end

% Extract sub-networks from the whole brain network
[SN, EN, DMN, SN_EN, SN_DMN, EN_DMN] = extract_triple_network(whole_brain_corr);

all_corrs = {whole_brain_corr, SN, EN, DMN, SN_EN, SN_DMN, EN_DMN};
roi = {roi_whole_brain, roi_SN, roi_EN, roi_DMN, [roi_SN, roi_EN], [roi_SN, roi_DMN], [roi_EN, roi_DMN]};
networks = {'Whole Brain Network', 'Salience Network', 'Executive Network', 'Default Mode Network', 'Salience Network + Executive Network', 'Salience Network + Default Mode Network', 'Executive Network + Default Mode Network'};
subnets_label = {['SN', 'EN'], ['SN', 'DMN'], ['EN', 'DMN']};

%% =======================================================================
%  Analysis of networks' parameters based on the Structural Balance Theory
%  =======================================================================
disp('SBT analysis is started...');
for net = 1:7 % 1: Whole Brain Network, 2: Salience Network, 3: Executive Network, 4: Default Mode Network, 5: Salience and Executive Networks, 6: Salience and Default Mode Networks, 7: Executive and Default Mode Networks
    disp(strcat('analysis of the', {' '}, networks{1, net}, {' '}, 'is started...'));
    if net == 5 || net == 6 || net == 7, single_net = 0; else, single_net = 1; end % Some lines need to be executaed only in the case of networks with two or more sub-nets
    
    %==========================================================================================================
    % 1) Calculate parameters of the structural balance theory for every subject in every age group, as follows:
    
    corr = all_corrs{1, net};    
    for age = 1:numel(age_group)  %1: Childhood, 2: Adolescence, 3: Adulthood        
        for s = 1:subject_count(age, 1) + subject_count(age, 2) % 1-40: Individuals with autism, 41-80: Healthy participants
                        
            % 1.1. Calculate the overall energy of the network
            energy(age, s) = U(corr{age, s}); % U is the balance energy as defined in: Marvel, Seth A., Steven H. Strogatz, and Jon M. Kleinberg. "Energy landscape of social balance." Physical review letters 103.19 (2009).
            
            % 1.2. Count frequency and weights of links
            [pos_count(age, s), neg_count(age, s), ~, ~] = pos_neg(corr{age, s});
            links_weight{age, s} = nonzeros(tril(corr{age, s}));
            
            % 1.3. Count frequency and weights (or the so-called energy) of triads
            [energy_T2, energy_T0, energy_T3, energy_T1] = energy_of_triads(corr{age, s});
            triads_energy = {energy_T2, energy_T0, energy_T3, energy_T1};
            for t = 1:4 % Four types of triads as, 1: T2 = ( + + - ), 2: T0 = ( - - - ), 3: T3 = ( + + + ), 4: T1 = ( + - - )
                triads_weight{1, t}{age, s} = nonzeros(reshape(triads_energy{1, t}, [1, sum(roi{1,net}), sum(roi{1,net}), sum(roi{1,net})]));     
                triads_frequency{1, t}(age, s) = numel(triads_weight{1, t}{age, s});
            end
            clearvars triads_energy
            
            % 1.4. Analysis of the directing triads
            if ~single_net % Is only valid for nets consisting of 2 or more sub-nets                 
                [directors{1, 1}{age, s}, directors{1, 2}{age, s}] = directing_triads(corr{age, s}, roi{1, net}(1, 1), roi{1, net}(1, 2)); % Find directing triads from 1st to 2nd net (directors_1) and vice versa (directors_2)                
                for d = 1:2 % Direction, 1: From 1st to 2nd net, 2: From 2nd to 1st net
                    [~, directors_frequency{1, d}(age, s)] = size(directors{1, d}{age, s}); % Returns a 3*80 matrix containing frequency of directing triads for each participant in different agr ranges
                    if ~(isempty(directors{1, d}{age, s}))
                        directors_weight{1, d}{age, s} = directors{1, d}{age, s}(4, :)';
                    end
                end
            else % Skip networks with zero subnets, in which analysis of the directing triads does not have meaning
                directors_frequency = {[], []};
                directors_weight = {{}, {}};
            end
            
            disp(strcat('From', {' '}, age_group{1, age}, {' '}, 'subject', {' '}, num2str(s),{' '}, 'is done!'));
        end
    end 
    
    % Summerize the calculated parameters in a 1*15 cell, rows represent each of the calculated parameters
    SBT_parameters = {energy, pos_count, neg_count, triads_frequency{1, :}, directors_frequency{1,:}, triads_weight{1, :}, directors_weight{1, :}};
    SBT_parameters_labels = {'Energy', 'Frequency of positive links', 'Frequency of negative links',...
        'Frequency of T2 triads', 'Frequency of T0 triads', 'Frequency of T3 triads', 'Frequency of T1 triads',... 
        'Frequency of directing triads from 1st to 2nd network', 'Frequency of directing triads from 2nd to 1st network',...
        'Weights of T2 triads', 'Weights of T0 triads', 'Weights of T3 triads', 'Weights of T1 triads',...
        'Weights of directing triads from 1st to 2nd network', 'Weights of directing triads from 2nd to 1st network'};
    
    % ========================================================================================================================   
    % 2) Check differnces of overall patterns using ANCOVA. Independent variables: Group and age, Dependent variable: Energy
    
    
    
    % =============================================
    % 3) Box plots of the parameters' frequencies    
    
    for parameter = 1:9
        if ~isempty(SBT_parameters{1, parameter})
            % 3.1. First check whether differences are statistically significant regarding frequencies, using Mann-Whitney U test
            [p{1, parameter}, effect_size{1, parameter}] = defence_ranksum(SBT_parameters{1, parameter});
            
            % 3.2. Draw the boxplots
            [ax{1, parameter}(1, net), fig{1, parameter}(1, net)] = defence_boxplot(SBT_parameters{1, parameter}, p{1, parameter},  effect_size{1, parameter}, networks{1, net}, SBT_parameters_labels{1, parameter});
        end
    end
    
    % Synchronize the y-axes for negative and positive plots within the network
    linkaxes([ax{1, 2}(1,net) ax{1, 3}(1,net)], 'y'); 
    
    % Synchronize the y-axes for T2, T3 and T1 within the network
    linkaxes([ax{1, 4}(1,net) ax{1, 6}(1,net) ax{1, 7}(1,net)], 'y'); 
    
    if ~single_net
        % Synchronize the y-axes for directing triads
        linkaxes([ax{1, 8}(1, net) ax{1, 9}(1, net)], 'y');
    end
    
    % ==========================================
    % 4) Histograms of the parameters' weights. 
    % Note: This analysis is done on the ensamble networks. Thus, first we have computed the ensamble of brain networks for each asd/con groups during development.
    
    for age = 1:3
        temp{age, 1} = cat(3, whole_brain_corr{age, 1:40}); % autism
        temp{age, 2} = cat(3, whole_brain_corr{age, 41:80}); % controls

        for group = 1:2
            ensamble_net{age, group} = mean(temp{age, group}, 3);
            links_weight{age, group} = nonzeros(tril(ensamble_net{age, group}));

            [energy_T2, energy_T0, energy_T3, energy_T1] = energy_of_triads(ensamble_net{age, group});
            triads_energy{age, group} = {energy_T2, energy_T0, energy_T3, energy_T1};
            for triad = 1:4
                triads_weight{age, group}{1, triad} = nonzeros(reshape(triads_energy{age, group}{1, triad}, [1, sum(roi{1,net}), sum(roi{1,net}), sum(roi{1,net})]));
                triads_frequency{age, group}{1, triad} = numel(triads_weight{age, group}{1, triad});
            end
        end
    end
    
    
    for parameter = 10:15 % Only for triads' and directing triads' weights
        for age = 1:numel(age_group)
            if ~isempty(SBT_parameters{1, parameter})
                
                dist_asd = 
                dist_con = 
                
                % 4.1. Compute the distance between triads' weights' distributions using KL-Divergence
                kl(parameter, age) = defence_KL(dist_asd, dist_con);
                
                % 4.2. Draw the histogram of triads' weights
                [ax{1, parameter}(age, net), fig{1, parameter}(age, net)] = defence_hist(dist_asd, dist_con, kl(parameter, age), strcat(networks{1, net}, {' during '}, age_group{1, age}), SBT_parameters_labels{1, parameter}, 1);
            end
        end
    end
    
    % Synchronize y-axes for all four types of triads across all three age ranges within the network in two following steps  
    linkaxes([ax{1, 10}(1, net) ax{1, 11}(1, net) ax{1, 12}(1, net) ax{1, 13}(1, net)], 'y'); % First, sync four triads during childhood
    linkaxes([ax{1, 10}(1, net) ax{1, 10}(2, net) ax{1, 10}(3, net)], 'y'); % Then, sync T2 across the three age ranges
    linkaxes([ax{1, 11}(1, net) ax{1, 11}(2, net) ax{1, 11}(3, net)], 'y'); % Sync T0 across the three age ranges
    linkaxes([ax{1, 12}(1, net) ax{1, 12}(2, net) ax{1, 12}(3, net)], 'y'); % Sync T3 across the three age ranges
    linkaxes([ax{1, 13}(1, net) ax{1, 13}(2, net) ax{1, 13}(3, net)], 'y'); % Sync T1 across the three age ranges
    
    % Synchronize x-axes for two unbalaced triads
    linkaxes([ax{1, 10}(1, net) ax{1, 11}(1, net)], 'x'); % First, sync two triads during childhood
    linkaxes([ax{1, 10}(1, net) ax{1, 10}(2, net) ax{1, 10}(3, net)], 'x'); % Then, sync T2 triad across the three age ranges
    linkaxes([ax{1, 11}(1, net) ax{1, 11}(2, net) ax{1, 11}(3, net)], 'x'); % Sync T0 triad across the three age ranges
    
    % Synchronize x-axes for two balaced triads    
    linkaxes([ax{1, 12}(1, net) ax{1, 13}(1, net)], 'x'); % First, sync two triads during childhood
    linkaxes([ax{1, 12}(1, net) ax{1, 12}(2, net) ax{1, 12}(3, net)], 'x'); % Then, sync T3 triad across the three age ranges
    linkaxes([ax{1, 13}(1, net) ax{1, 13}(2, net) ax{1, 13}(3, net)], 'x'); % Sync T1 triad across the three age ranges
    
    if ~single_net
        % Synchronize axes for the directing triads across age groups
        linkaxes([ax{1, 14}(1, net) ax{1, 15}(1, net)]); % First, sync two directing triads during childhood    
        linkaxes([ax{1, 14}(1, net) ax{1, 14}(2, net) ax{1, 14}(3, net)]); % Then, sync directing triads from 1st to 2nd subnet across the three age ranges  
        linkaxes([ax{1, 15}(1, net) ax{1, 15}(2, net) ax{1, 15}(3, net)]); % Sync directing triads from 2nd to 1st subnet across the three age ranges  
    end
    
    disp(strcat(networks{1, net}, {' '}, 'is done!'));
    pause(5);
    
end

%================================================================================================================
% 5) Sycnchronize axes which are close to each other across different networks so to better compare the results

% 5.1. For energy (ax{1, 1}), sync axes between all nets except the whole brain network
linkaxes([ax{1, 1}(1, 2) ax{1, 1}(1, 3) ax{1, 1}(1, 4) ax{1, 1}(1, 5) ax{1, 1}(1, 6) ax{1, 1}(1, 7)]); 

% 5.2. For links and triads, sync axes between SN, EN and DMN from one hand, and SN_EN, SN_DMN and EN_DMN from the other hand
for parameter = 2:15
    if parameter == 8 || parameter == 9 || parameter == 14 || parameter == 15 % Case of the directing triads
        linkaxes([ax{1, parameter}(1, 5) ax{1, parameter}(1,6) ax{1, parameter}(1,7)]);
    else
        linkaxes([ax{1, parameter}(1, 2) ax{1, parameter}(1, 3) ax{1, parameter}(1, 4)]); % Sync the axes to positive links between SN, EN and DMN
        linkaxes([ax{1, parameter}(1, 5) ax{1, parameter}(1, 6) ax{1, parameter}(1, 7)]); % Sync the axes to positive links between SN-EN, SN-DMN and EN-DMN
    end
end

%==========================================================
% 6) Save the figures as pdf files in the defined directory

for net = 1:7
    for parameter = 1:15
        if isa(fig{1, parameter}(1, net), 'matlab.ui.Figure') % Check if we have a figure
            if parameter <= 9
                print_name = strcat(dir(1, net), SBT_parameters_labels{1, parameter}, '.pdf');
                print(fig{1, parameter}(1, net), print_name{1, 1}, '-dpdf', '-r400');
            elseif parameter > 9 % For triads' and directing triads' weights we have 3 figures for each triads' types, one for each age group
                for age = 1:numel(age_group)
                    print_name = strcat(dir(1, net), SBT_parameters_labels{1, parameter}, {'_'}, num2str(age), {'.'}, age_group{1, age}, '.pdf');
                    print(fig{1, parameter}(age, net), print_name{1, 1}, '-dpdf', '-r400');
                end            
            end
        end
    end
end

disp("That's it :) You can now check your directory for the results!");

    