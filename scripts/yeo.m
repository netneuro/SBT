% 5 Bahman 98
% 17 YEO networks


%% split 400 ROI timeseries into 17 yea networks:

n = 171;
for i=1:n
%     load('tsadol.mat');
    ts = time_series{1,i};
    name = strcat('ts_', num2str('%03i', i), '.mat');
%     name_1 = 'ts_';
%     
%     if i<10
%         temp = {'00', num2str(i)};
%         name_2 = strcat(temp{1,1},temp{1,2});
%     elseif i<100
%         temp = {'0', num2str(i)};
%         name_2 = strcat(temp{1,1},temp{1,2});
%     else
%         name_2 = num2str(i);
%     end
%     name_3 = '.mat';
%     
%     name = strcat(name_1, name_2, name_3);
%     if isfile (name)
%         load(name);
        
        % 1. visual centeral
%         for j=1:12
%             ts_visCent_l(:,j) = ts(:,j);
%         end
%         
%         for j=201:212
%             ts_visCent_r(:,j-200) = ts(:,j);
%         end
%         
%         ts_visCent = [ts_visCent_l, ts_visCent_r];
%         
%         dir_visCent = '/Volumes/ZAHRA5TB/scientificReport/Schaefer/Yeo networks/asd_6_9/1. visual centeral/+ts/';
%         output_name_visCent = strcat(dir_visCent, 'visCent_',name);
%         save(output_name_visCent, 'ts_visCent');
%       
%          % 2. peripheral centeral
%         for j=13:24
%             ts_visPeri_l(:,j-12) = ts(:,j);
%         end
%         
%         for j=213:223
%             ts_visPeri_r(:,j-212) = ts(:,j);
%         end
%         
%         ts_visPeri = [ts_visPeri_l, ts_visPeri_r];
%         
%         dir_visPeri = '/Volumes/ZAHRA5TB/scientificReport/Schaefer/Yeo networks/asd_6_9/2. visual peripheral/+ts/';
%         output_name_visPeri = strcat(dir_visPeri, 'visPeri_',name);
%         save(output_name_visPeri, 'ts_visPeri');
%         
%         % 3. somato motor A
%         for j=25:43
%             ts_somMotA_l(:,j-24) = ts(:,j);
%         end
%         
%         for j=224:243
%             ts_somMotA_r(:,j-223) = ts(:,j);
%         end
%         
%         ts_somMotA = [ts_somMotA_l, ts_somMotA_r];
% 
%         dir_somMotA = '/Volumes/ZAHRA5TB/scientificReport/Schaefer/Yeo networks/asd_6_9/3. somato motor A/+ts/';
%         output_name_somMotA = strcat(dir_somMotA, 'somMotA_',name);
%         save(output_name_somMotA, 'ts_somMotA');
%         
%          % 4. somato motor B
%         for j=44:59
%             ts_somMotB_l(:,j-43) = ts(:,j);
%         end
%         
%         for j=244:258
%             ts_somMotB_r(:,j-243) = ts(:,j);
%         end
%         
%         ts_somMotB = [ts_somMotB_l, ts_somMotB_r];        
% 
%         dir_somMotB = '/Volumes/ZAHRA5TB/scientificReport/Schaefer/Yeo networks/asd_6_9/4. somato motor B/+ts/';
%         output_name_somMotB = strcat(dir_somMotB, 'somMotB_',name);
%         save(output_name_somMotB, 'ts_somMotB');
%         
%         % 5. dorsal attention A
%         for j=60:72
%             ts_dorsAttnA_l(:,j-59) = ts(:,j);
%         end
%         
%         for j=259:272
%             ts_dorsAttnA_r(:,j-258) = ts(:,j);
%         end
%         
%         ts_dorsAttnA = [ts_dorsAttnA_l, ts_dorsAttnA_r];
% 
%         dir_dorsAttenA = '/Volumes/ZAHRA5TB/scientificReport/Schaefer/Yeo networks/asd_6_9/5. dorsal attention A/+ts/';
%         output_name_dorsAttenA = strcat(dir_dorsAttenA, 'dorsAttnA_',name);
%         save(output_name_dorsAttenA, 'ts_dorsAttnA');
%         
%          % 6. dorsal attention B
%         for j=73:85
%             ts_dorsAttnB_l(:,j-72) = ts(:,j);
%         end
%         
%         for j=273:284
%             ts_dorsAttnB_r(:,j-272) = ts(:,j);
%         end
%         
%         ts_dorsAttnB = [ts_dorsAttnB_l, ts_dorsAttnB_r];
% 
%         dir_dorsAttenB = '/Volumes/ZAHRA5TB/scientificReport/Schaefer/Yeo networks/asd_6_9/6. dorsal attention B/+ts/';
%         output_name_dorsAttenB = strcat(dir_dorsAttenB, 'dorsAttnB_',name);
%         save(output_name_dorsAttenB, 'ts_dorsAttnB');
        
        % 7. salience A
        for j=86:100
            ts_salA_l(:,j-85) = ts(:,j);
        end
        
        for j=285:303
            ts_salA_r(:,j-284) = ts(:,j);
        end

        ts_salA = [ts_salA_l, ts_salA_r];
        ts_salA_adol{1,i} = ts_salA;
        
%         dir_salA = '/Users/zahra/Documents/Energy lags/denoised_data/subnetworks/ts/';
%         output_name_salA = strcat(dir_salA, 'salA_',name);
%         save(output_name_salA, 'ts_salA');       

         % 8. salience B
        for j=101:108
            ts_salB_l(:,j-100) = ts(:,j);
        end
        
        for j=304:312
            ts_salB_r(:,j-303) = ts(:,j);
        end
        
        ts_salB = [ts_salB_l, ts_salB_r]; 
        ts_salB_adol{1,i} = ts_salB;

%         dir_salB = '/Users/zahra/Documents/Energy lags/denoised_data/subnetworks/ts/';
%         output_name_salB = strcat(dir_salB, 'salB_',name);
%         save(output_name_salB, 'ts_salB');
        
%         % 9. limbic B
%         for j=109:113
%             ts_limbicB_l(:,j-108) = ts(:,j);
%         end
%         
%         for j=313:318
%             ts_limbicB_r(:,j-312) = ts(:,j);
%         end
%         
%         ts_limbicB = [ts_limbicB_l, ts_limbicB_r];
% 
%         dir_limbicB = '/Volumes/ZAHRA5TB/scientificReport/Schaefer/Yeo networks/asd_6_9/9. limbic B/+ts/';
%         output_name_limbicB = strcat(dir_limbicB, 'limbicB_',name);
%         save(output_name_limbicB, 'ts_limbicB');
%         
%          % 10. limbic A
%         for j=114:120
%             ts_limbicA_l(:,j-113) = ts(:,j);
%         end
%         
%         for j=319:324
%             ts_limbicA_r(:,j-318) = ts(:,j);
%         end
%         
%         ts_limbicA = [ts_limbicA_l, ts_limbicA_r];
% 
%         dir_limbicA = '/Volumes/ZAHRA5TB/scientificReport/Schaefer/Yeo networks/asd_6_9/10. limbic A/+ts/';
%         output_name_limbicA = strcat(dir_limbicA, 'limbicA_',name);
%         save(output_name_limbicA, 'ts_limbicA');
        
        % 11. Cont A
        for j=121:133
            ts_contA_l(:,j-120) = ts(:,j);
        end
        
        for j=325:335
            ts_contA_r(:,j-324) = ts(:,j);
        end
        
        ts_contA = [ts_contA_l, ts_contA_r];
        ts_contA_adol{1,i} = ts_contA;
%         dir_contA = '/Users/zahra/Documents/Energy lags/denoised_data/subnetworks/ts/';
%         output_name_contA = strcat(dir_contA, 'contA_',name);
%         save(output_name_contA, 'ts_contA');
        
         % 12. Cont B
        for j=134:143
            ts_contB_l(:,j-133) = ts(:,j);
        end
        
        for j=336:350
            ts_contB_r(:,j-335) = ts(:,j);
        end
        
        ts_contB = [ts_contB_l, ts_contB_r];        
        ts_contB_adol{1,i} = ts_contB;

%         dir_contB = '/Users/zahra/Documents/Energy lags/denoised_data/subnetworks/ts/';
%         output_name_contB = strcat(dir_contB, 'contB_',name);
%         save(output_name_contB, 'ts_contB');
        
        % 13. Cont C
        for j=144:148
            ts_contC_l(:,j-143) = ts(:,j);
        end
        
        for j=351:357
            ts_contC_r(:,j-350) = ts(:,j);
        end
        
        ts_contC = [ts_contC_l, ts_contC_r];
        ts_contC_adol{1,i} = ts_contC;

%         dir_contC = '/Users/zahra/Documents/Energy lags/denoised_data/subnetworks/ts/';
%         output_name_contC = strcat(dir_contC, 'contC_',name);
%         save(output_name_contC, 'ts_contC');
        
         % 14. DMN A
        for j=149:166
            ts_dmnA_l(:,j-148) = ts(:,j);
        end
        
        for j=358:373
            ts_dmnA_r(:,j-357) = ts(:,j);
        end
        
        ts_dmnA = [ts_dmnA_l, ts_dmnA_r];
        ts_dmnA_adol{1,i} = ts_dmnA;

%         dir_dmnA = '/Users/zahra/Documents/Energy lags/denoised_data/subnetworks/ts/';
%         output_name_dmnA = strcat(dir_dmnA, 'dmnA_',name);
%         save(output_name_dmnA, 'ts_dmnA');
        
        % 15. DMN B
        for j=167:187
            ts_dmnB_l(:,j-166) = ts(:,j);
        end
        
        for j=374:384
            ts_dmnB_r(:,j-373) = ts(:,j);
        end
        
        ts_dmnB = [ts_dmnB_l, ts_dmnB_r];
        ts_dmnB_adol{1,i} = ts_dmnB;

%         dir_dmnB = '/Users/zahra/Documents/Energy lags/denoised_data/subnetworks/ts/';
%         output_name_dmnB = strcat(dir_dmnB, 'dmnB_',name);
%         save(output_name_dmnB, 'ts_dmnB');
        
         % 16. BMN C
        for j=188:194
            ts_dmnC_l(:,j-187) = ts(:,j);
        end
        
        for j=385:390
            ts_dmnC_r(:,j-384) = ts(:,j);
        end
        
        ts_dmnC = [ts_dmnC_l, ts_dmnC_r];        
        ts_dmnC_adol{1,i} = ts_dmnC;

%         dir_dmnC = '/Users/zahra/Documents/Energy lags/denoised_data/subnetworks/ts/';
%         output_name_dmnC = strcat(dir_dmnC, 'dmnC_',name);
%         save(output_name_dmnC, 'ts_dmnC');
        
         % 17. temporo parietal
%         for j=195:200
%             ts_tempPar_l(:,j-194) = ts(:,j);
%         end
%         
%         for j=391:400
%             ts_tempPar_r(:,j-390) = ts(:,j);
%         end
%         
%         ts_temp_par = [ts_tempPar_l, ts_tempPar_r];        
%         ts_temp_par_adol{1,i} = ts_temp_par;

%         dir_tempPar = '/Users/zahra/Documents/Energy lags/denoised_data/subnetworks/ts/';
%         output_name_tempPar = strcat(dir_tempPar, 'temp_par_',name);
%         save(output_name_tempPar, 'ts_temp_par');
        
    
    clearvars -except time_series ts_salA_adol ts_salB_adol ts_dmnA_adol ts_dmnB_adol ts_dmnC_adol ts_contA_adol ts_contB_adol ts_contC_adol
end

