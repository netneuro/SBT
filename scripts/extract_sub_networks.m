function [single_nets, double_nets, triple_nets] = extract_sub_networks(corr)

% Extract follwoing sub-networks from the Schaefer 400 atlas using indexes as a global variable.

% 1. Visual Network (VN) nodes' index: 47 nodes
%               Left hemesphiere  => 1   : 24  => 24 nodes
%               Right hemesphiere => 201 : 223 => 23 nodes
%
% 2. Somato Motor Network (SMN) nodes' index: 70 nodes
%               Left hemesphiere  => 25  : 59  => 35 noeds
%               Right hemesphiere => 224 : 258 => 35 nodes
%
% 3. Dorsal Attention Network (DAN) nodes' index: 52 nodes
%               Left hemesphiere  => 60  : 85  => 26 nodes
%               Right hemesphiere => 259 : 284 => 26 nodes
%
% 4. Salience Network (SN) nodes' index: 51 nodes
%               Left hemesphiere  => 86 : 108 => 23 nodes
%               Right hemesphiere => 285 : 312 => 28 nodes
%
% 5. Central Executive Network (CEN) nodes' index: 61 nodes
%               Left hemesphiere  => 121 : 148 => 28 noeds
%               Right hemesphiere => 325 : 357 => 33 nodes
%
% 6. Default Mode Network (DMN) nodes' index: 79 nodes
%               Left hemesphiere  => 149 : 194 => 46 nodes
%               Right hemesphiere => 358 : 390 => 33 nodels

% corr is a 3 * 80 matrix:
% Rows representing age group as, 1: childhood, 2: adolescence, 3: adulthood
% Columns representing subjects as, 1-40: individuals with autism, 41-80: healthy controls

global subject_count indexes

for age = 1:3  %1 : childhood, 2 : adolescence, 3 : adulthood
    for s = 1:(subject_count(age, 1) + subject_count(age, 2))
        FC = corr{age,s};
        for net = 1:6 % single nets
            single_nets{1, net}{age, s} = [FC(indexes{1, net}(1):indexes{1, net}(2), indexes{1, net}(1):indexes{1, net}(2)),...
                FC(indexes{1, net}(1):indexes{1, net}(2), indexes{1, net}(3):indexes{1, net}(4));...
                FC(indexes{1, net}(3):indexes{1, net}(4), indexes{1, net}(1):indexes{1, net}(2)),...
                FC(indexes{1, net}(3):indexes{1, net}(4), indexes{1, net}(3):indexes{1, net}(4))];
        end
        single_nets{1, 7}{age, s} = FC(1:200, 1:200); % Left hemisphere
        single_nets{1, 8}{age, s} = FC(201:400, 201:400); % Right hemisphere
        
        for i = 1:5 % double nets
            for j = i+1:6
                
                temp_a = [FC(indexes{1, i}(1):indexes{1, i}(2), indexes{1, j}(1):indexes{1, j}(2)),...
                    FC(indexes{1, i}(1):indexes{1, i}(2), indexes{1, j}(3):indexes{1, j}(4));...
                    FC(indexes{1, i}(3):indexes{1, i}(4), indexes{1, j}(1):indexes{1, j}(2)),...
                    FC(indexes{1, i}(3):indexes{1, i}(4), indexes{1, j}(3):indexes{1, j}(4))];
                
                temp_b = [FC(indexes{1, j}(1):indexes{1, j}(2), indexes{1, i}(1):indexes{1, i}(2)),...
                    FC(indexes{1, j}(1):indexes{1, j}(2), indexes{1, i}(3):indexes{1, i}(4));...
                    FC(indexes{1, j}(3):indexes{1, j}(4), indexes{1, i}(1):indexes{1, i}(2)),...
                    FC(indexes{1, j}(3):indexes{1, j}(4), indexes{1, i}(3):indexes{1, i}(4))];
                
                double_nets{i, j}{age, s} = [single_nets{1, i}{age, s}, temp_a; temp_b single_nets{1, j}{age, s}];
            end
        end
        clear temp_a temp_b
        
        count = 1;
        for i = 1:4
            for j = i+1:5
                for k = j+1:6
                    temp_a = [FC(indexes{1, i}(1):indexes{1, i}(2), indexes{1, k}(1):indexes{1, k}(2)),...
                        FC(indexes{1, i}(1):indexes{1, i}(2), indexes{1, k}(3):indexes{1, k}(4));...
                        FC(indexes{1, i}(3):indexes{1, i}(4), indexes{1, k}(1):indexes{1, k}(2)),...
                        FC(indexes{1, i}(3):indexes{1, i}(4), indexes{1, k}(3):indexes{1, k}(4));
                        
                        FC(indexes{1, j}(1):indexes{1, j}(2), indexes{1, k}(1):indexes{1, k}(2)),...
                        FC(indexes{1, j}(1):indexes{1, j}(2), indexes{1, k}(3):indexes{1, k}(4));...
                        FC(indexes{1, j}(3):indexes{1, j}(4), indexes{1, k}(1):indexes{1, k}(2)),...
                        FC(indexes{1, j}(3):indexes{1, j}(4), indexes{1, k}(3):indexes{1, k}(4))];
                    
                    temp_b = [FC(indexes{1, k}(1):indexes{1, k}(2), indexes{1, i}(1):indexes{1, i}(2)),...
                        FC(indexes{1, k}(1):indexes{1, k}(2), indexes{1, i}(3):indexes{1, i}(4)),...
                        FC(indexes{1, k}(1):indexes{1, k}(2), indexes{1, j}(1):indexes{1, j}(2)),...
                        FC(indexes{1, k}(1):indexes{1, k}(2), indexes{1, j}(3):indexes{1, j}(4));
                        
                        FC(indexes{1, k}(3):indexes{1, k}(4), indexes{1, i}(1):indexes{1, i}(2)),...
                        FC(indexes{1, k}(3):indexes{1, k}(4), indexes{1, i}(3):indexes{1, i}(4)),...
                        FC(indexes{1, k}(3):indexes{1, k}(4), indexes{1, j}(1):indexes{1, j}(2)),...
                        FC(indexes{1, k}(3):indexes{1, k}(4), indexes{1, j}(3):indexes{1, j}(4))];
                    
                    triple_nets{1, count}{age, s} = [double_nets{i, j}{age, s}, temp_a; temp_b, single_nets{1, k}{age, s}];
                    count = count + 1;
                end
            end
        end
        
    end
end

double_nets = reshape(double_nets.', [], 1); 
double_nets = double_nets(~cellfun('isempty',double_nets))';
end

