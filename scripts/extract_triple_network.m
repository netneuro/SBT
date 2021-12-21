function [SN, EN, DMN, SN_EN, SN_DMN, EN_DMN, SN_EN_DMN] = extract_triple_network(corr)

% Extract follwoing sub-networks from the Schaefer 400 atlas:

% 1. Salience Network (SN) nodes' index: 51 nodes
%               Left hemesphiere  => 86 : 108 => 23 nodes
%               Right hemesphiere => 285 : 312 => 28 nodes
%
% 2. Executive Network (EN) nodes' index: 61 nodes
%               Left hemesphiere  => 121 : 148 => 28 noeds
%               Right hemesphiere => 325 : 357 => 33 nodes
% 3. Default Mode Network (DMN) nodes' index: 79 nodes
%               Left hemesphiere  => 149 : 194 => 46 nodes
%               Right hemesphiere => 358 : 390 => 33 nodels

% Thus the triple network is (191, 191) matrix: [SN (1:51), EN (52:112), DMN (113:191)]

% corr is a 3 * 80 matrix: 
    % Rows representing age group as, 1: childhood, 2: adolescence, 3: adulthood
    % Columns representing subjects as, 1-40: individuals with autism, 41-80: healthy controls
% mod is either 1 or 2: 1 for single subject analysis, 2 for ensamble network analysis

global subject_count roi_SN roi_EN roi_DMN 

for age = 1:3  %1 : childhood, 2 : adolescence, 3 : adulthood
    for s = 1:subject_count(age, 1) + subject_count(age, 2)
        FC = corr{age,s};
        triple = [FC(86 :108, 86:108), FC(86 :108, 285:312), FC(86 :108, 121:148), FC(86 :108, 325:357), FC(86 :108, 149:194), FC(86 :108, 358:390);
                  FC(285:312, 86:108), FC(285:312, 285:312), FC(285:312, 121:148), FC(285:312, 325:357), FC(285:312, 149:194), FC(285:312, 358:390);
                  FC(121:148, 86:108), FC(121:148, 285:312), FC(121:148, 121:148), FC(121:148, 325:357), FC(121:148, 149:194), FC(121:148, 358:390);
                  FC(325:357, 86:108), FC(325:357, 285:312), FC(325:357, 121:148), FC(325:357, 325:357), FC(325:357, 149:194), FC(325:357, 358:390);
                  FC(149:194, 86:108), FC(149:194, 285:312), FC(149:194, 121:148), FC(149:194, 325:357), FC(149:194, 149:194), FC(149:194, 358:390);
                  FC(358:390, 86:108), FC(358:390, 285:312), FC(358:390, 121:148), FC(358:390, 325:357), FC(358:390, 149:194), FC(358:390, 358:390)];
        
        SN{age, s} = triple(1:51, 1:51);
        EN{age, s} = triple(52:112, 52:112);
        DMN{age, s} = triple(113:191, 113:191);
        
        full_SN_EN = triple(1:112, 1:112) ; %112 nodes
        SN_EN{age, s} = extract_triads_between_subnetworks(full_SN_EN, roi_SN, roi_EN); % Extract triads between Salience and Executive networks
        
        full_SN_DMN = [triple(1:51, 1:51), triple(1:51, 113:191); triple(113:191, 1:51), triple(113:191, 113:191)]; % 130 nodes
        SN_DMN{age, s} = extract_triads_between_subnetworks(full_SN_DMN, roi_SN, roi_DMN); % Extract triads between Salience and Default networks
        
        full_EN_DMN = triple(52:191, 52:191); % 140 nodes
        EN_DMN{age, s} = extract_triads_between_subnetworks(full_EN_DMN, roi_EN, roi_DMN); % Extract triads between Executive and Default networks
        
        SN_EN_DMN{age, s} = triple;
    end
end

    
end

