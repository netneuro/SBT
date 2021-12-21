
clc
clear all

global bin subject_count roi_SN roi_EN roi_DMN roi_whole_brain

age_group = {'Childhood', 'Adolescence' 'Adulthood'};
triads_label = {'Weights of T2 triads', 'Weights of T0 triads', 'Weights of T3 triads', 'Weights of T1 triads'};
subject_count = [1, 1; 1, 1; 1, 1]; % one ensamble net for each group 
roi_whole_brain = 400;
roi_SN = 51;
roi_EN = 61;
roi_DMN = 79;
networks = {'Whole Brain Network', 'Salience Network', 'Executive Network', 'Default Mode Network', 'Salience Network + Executive Network', 'Salience Network + Default Mode Network', 'Executive Network + Default Mode Network'};
roi = {roi_whole_brain, roi_SN, roi_EN, roi_DMN, [roi_SN, roi_EN], [roi_SN, roi_DMN], [roi_EN, roi_DMN]};

bin = 500;

input_dir = '/media/zahra/ZAHRA5TB/ongoing_data/zahra_march2021/combat/whole_brain/';
cd(char(input_dir));
load('corr_hamonized_child.mat');
load('corr_hamonized_adol.mat');
load('corr_hamonized_adult.mat');
whole_brain_corr = [corr_harmonized_child; corr_harmonized_adol; corr_harmonized_adult];
[SN, EN, DMN, SN_EN, SN_DMN, EN_DMN] = extract_triple_network(whole_brain_corr);
all_corrs = {whole_brain_corr, SN, EN, DMN, SN_EN, SN_DMN, EN_DMN};

for net = 1:1
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
        for triad = 1:4
            dist_asd = triads_weight{age, 1}{1, triad};
            dist_con = triads_weight{age, 2}{1, triad};
            kl = defence_KL(dist_asd, dist_con);
            [ax, fig] = defence_hist(dist_asd, dist_con, kl, strcat(networks{1, net}, {' during '}, age_group{1, age}), triads_label{1, triad}, 1);
        end
    end
end








